Aqui está um modelo completo e profissional de `README.md` focado na integração do Google Sign-In com Firebase.

Ele cobre desde a configuração no console até o código que corrigimos juntos, servindo como uma documentação sólida para o seu projeto `fidelyn_user_app`.

-----

# 🔐 Integração Google OAuth (Firebase)

Este documento detalha o processo de configuração e implementação do login social com Google utilizando Firebase Authentication no Flutter.

## 📦 Dependências

Certifique-se de ter as seguintes bibliotecas no seu `pubspec.yaml`:

```yaml
dependencies:
  firebase_core: ^latest
  firebase_auth: ^latest
  google_sign_in: ^latest
```

-----

## 🛠️ Passo 1: Configuração no Firebase Console

Para que o login funcione, o projeto no Firebase deve estar configurado corretamente.

### 1\. Ativar o Provedor

1.  Acesse o **Firebase Console** \> **Authentication** \> **Sign-in method**.
2.  Adicione o provedor **Google**.
3.  **IMPORTANTE:** Certifique-se de preencher o campo **"E-mail de suporte do projeto"**. Sem isso, o login falha silenciosamente no Android.
4.  Salve e copie o **ID do cliente da Web** (Web Client ID). Você precisará dele no código Flutter.

### 2\. Cadastrar as Chaves SHA-1 (Android)

O Google exige a "impressão digital" do certificado de assinatura do app. Você precisa cadastrar duas chaves nas configurações do projeto (ícone ⚙️):

  * **Chave de Debug:** Usada durante o desenvolvimento (`flutter run`).
  * **Chave de Release:** Usada para a versão final na Play Store.

**Como gerar o SHA-1:**
No terminal, dentro da pasta `android/`:

```bash
# Windows
gradlew signingReport

# Mac/Linux
./gradlew signingReport
```

Copie o código SHA-1 e adicione em **Configurações do Projeto** \> **Seus aplicativos** \> **Adicionar impressão digital**.

-----

## 🤖 Passo 2: Configuração Android

1.  Baixe o arquivo `google-services.json` atualizado no Firebase Console.
2.  Coloque o arquivo em: `android/app/google-services.json`.

> **Atenção:** Se você adicionar um novo SHA-1 ou mudar configurações no Firebase, baixe este arquivo novamente.

-----

## 🍎 Passo 3: Configuração iOS

1.  Baixe o arquivo `GoogleService-Info.plist` no Firebase Console.
2.  Abra o projeto no Xcode (`ios/Runner.xcworkspace`) e arraste o arquivo para dentro da pasta `Runner`.
3.  No arquivo `ios/Runner/Info.plist`, adicione o esquema de URL reverso (encontrado no `GoogleService-Info.plist` sob a chave `REVERSED_CLIENT_ID`):

<!-- end list -->

```xml
<key>CFBundleURLTypes</key>
<array>
	<dict>
		<key>CFBundleTypeRole</key>
		<string>Editor</string>
		<key>CFBundleURLSchemes</key>
		<array>
			<string>com.googleusercontent.apps.SEU-ID-AQUI</string>
		</array>
	</dict>
</array>
```

-----

## 💻 Passo 4: Implementação no Código (Controller)

Nas versões mais recentes do pacote `google_sign_in` para Android, é **obrigatório** passar o `serverClientId` (que é o Web Client ID do Firebase).

```dart
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  
  // Instância configurada com o ID do Cliente WEB
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    // Pegue este ID no Firebase Console > Auth > Google > Configuração SDK Web
    serverClientId: 'SEU_WEB_CLIENT_ID.apps.googleusercontent.com', 
    scopes: ['email', 'profile'],
  );

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signInWithGoogle() async {
    try {
      // 1. Autenticar com o Google
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      
      if (googleUser == null) return; // Usuário cancelou

      // 2. Obter tokens (Apenas idToken é necessário para Firebase hoje em dia)
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // 3. Criar credencial
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: null, 
        idToken: googleAuth.idToken,
      );

      // 4. Login no Firebase
      await _auth.signInWithCredential(credential);
      
      print("Login realizado com sucesso!");

    } catch (e) {
      print("Erro no login: $e");
    }
  }
}
```

-----

## 🚑 Solução de Problemas Comuns

| Erro | Causa Provável | Solução |
| :--- | :--- | :--- |
| **`[16] Account reauth failed`** | SHA-1 não cadastrado ou incorreto. | Rode o `signingReport` novamente e verifique se o SHA-1 no Firebase bate com o da sua máquina atual. |
| **`serverClientId must be provided`** | Falta o parâmetro no construtor. | Adicione `serverClientId` ao instanciar `GoogleSignIn` (use o ID da Web, não o do Android). |
| **Login funciona no emulador mas falha na Loja** | Falta o SHA-1 de Release. | Copie o SHA-1 do **Google Play Console** (Integridade do app) e adicione no Firebase. |
| **`Missing keystore`** | Caminho da chave incorreto. | Verifique o caminho no `key.properties`. Recomendado usar caminho relativo ou mover a chave para `android/app/`. |