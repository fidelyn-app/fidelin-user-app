import 'package:asuka/asuka.dart';
import 'package:dartz/dartz.dart';
import 'package:fidelyn_user_app/app/core/domain/entities/user_entity.dart';
import 'package:fidelyn_user_app/app/core/errors/Failure.dart';
import 'package:fidelyn_user_app/app/core/stores/app_store.dart';
import 'package:fidelyn_user_app/app/modules/auth/domain/usecases/signin_with_email_usecase.dart';
import 'package:fidelyn_user_app/app/modules/auth/domain/usecases/signin_with_google_usecase.dart';
import 'package:fidelyn_user_app/env.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:mobx/mobx.dart';

part 'signin_controller.g.dart';

class SignInController = _SignInControllerBase with _$SignInController;

abstract class _SignInControllerBase with Store {
  late SignInWithEmailUseCase _signInWithEmailUseCase;
  late SignInWithGoogleUseCase _signInWithGoogleUseCase;

  final AppStore _userStore = Modular.get<AppStore>();

  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  _SignInControllerBase({
    required SignInWithEmailUseCase signInWithEmailUseCase,
    required SignInWithGoogleUseCase signInWithGoogleUseCase,
  }) {
    _signInWithEmailUseCase = signInWithEmailUseCase;
    _signInWithGoogleUseCase = signInWithGoogleUseCase;
  }

  final formField = GlobalKey<FormState>();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  @observable
  bool passwordVisible = false;

  @observable
  bool loading = false;

  @action
  void togglePasswordVisible() {
    passwordVisible = !passwordVisible;
  }

  @action
  Future<void> signIn() async {
    formField.currentState!.validate();
    if (formField.currentState!.validate()) {
      loading = true;

      final Either<Failure, UserEntity> _response =
          await _signInWithEmailUseCase.call(
            email: emailTextController.text,
            password: passwordTextController.text,
          );
      _response.fold(
        (Failure e) {
          AsukaSnackbar.alert(e.message).show();
        },
        (UserEntity user) {
          _userStore.setUser(user);
          Modular.to.navigate('/home/');
        },
      );
      loading = false;
    }
  }

  @action
  Future<void> signInWithGoogleFirebase() async {
    try {
      await _googleSignIn.initialize(serverClientId: Env.googleOauthKey);

      final GoogleSignInAccount googleUser = await _googleSignIn.authenticate(
        scopeHint: ['email', 'profile'],
      );

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: null, // Ignorando o accessToken conforme o erro
        idToken: googleAuth.idToken, // Usando apenas o idToken
      );

      // 5. Faz login no Firebase com a credencial
      final UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );
      final User? firebaseUser = userCredential.user;

      if (firebaseUser != null) {
        final String? tokenParaBackend = await firebaseUser.getIdToken();

        final Either<Failure, UserEntity> response =
            await _signInWithGoogleUseCase.call(
              firebaseToken: tokenParaBackend!,
            );
        response.fold(
          (Failure e) {
            AsukaSnackbar.alert(e.message).show();
          },
          (UserEntity user) {
            //_userStore.setUser(user);
            Modular.to.navigate('/home/');
          },
        );
      }
    } catch (error) {
      debugPrint('Erro no login com Google: $error');
      String errorMessage = 'Ocorreu um erro. Tente novamente.';
      if (error is FirebaseException) {
        errorMessage = error.message ?? errorMessage;
      } else if (error is GoogleSignInException) {
        if (error.code == GoogleSignInExceptionCode.canceled) {
          return;
        }
        errorMessage = 'Erro de conexão. Verifique sua internet.';
      }
      AsukaSnackbar.alert(errorMessage).show();
    }
  }

  @action
  Future<void> signInWithAppleFirebase() async {
    try {

      // Solicita autenticação com Apple incluindo email
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      // Cria a credencial OAuth para o Firebase
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      // Faz login no Firebase com a credencial
      final UserCredential userCredential =
          await _auth.signInWithCredential(oauthCredential);
      final User? firebaseUser = userCredential.user;

      if (firebaseUser != null) {
        // Atualiza o display name se fornecido pela Apple
        if (appleCredential.givenName != null || appleCredential.familyName != null) {
          final displayName = '${appleCredential.givenName ?? ''} ${appleCredential.familyName ?? ''}'.trim();
          if (displayName.isNotEmpty && firebaseUser.displayName != displayName) {
            await firebaseUser.updateDisplayName(displayName);
          }
        }

        // O email (real ou ofuscado) estará disponível em firebaseUser.email
        // ou em appleCredential.email (apenas na primeira autenticação)
        debugPrint('Email do usuário: ${firebaseUser.email ?? appleCredential.email}');

        final String? tokenParaBackend = await firebaseUser.getIdToken();

        final Either<Failure, UserEntity> response =
            await _signInWithGoogleUseCase.call(firebaseToken: tokenParaBackend!);
        response.fold(
          (Failure e) {
            AsukaSnackbar.alert(e.message).show();
          },
          (UserEntity user) {
            _userStore.setUser(user);
            Modular.to.navigate('/home/');
          },
        );
      }
    } catch (error) {
      debugPrint('Erro no login com Apple: $error');
      String errorMessage = 'Ocorreu um erro. Tente novamente.';
      if (error is SignInWithAppleAuthorizationException) {
        if (error.code == AuthorizationErrorCode.canceled) {
          return; // Usuário cancelou, não mostra erro
        }
        errorMessage = 'Erro na autenticação com Apple.';
      } else if (error is FirebaseException) {
        errorMessage = error.message ?? errorMessage;
      }
      AsukaSnackbar.alert(errorMessage).show();
    } 
  }
}
