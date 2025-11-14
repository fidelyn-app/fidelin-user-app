import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// ⚠️ DEVE ser uma função global ou estática
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Se precisar usar firebase aqui, tem que inicializar de novo:
  // await Firebase.initializeApp();
  print("Mensagem em Background: ${message.notification?.title}");
}

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    // 1. Pedir Permissão (Principalmente iOS e Android 13+)
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('Permissão concedida!');

      // 2. Configurar Handler de Background
      FirebaseMessaging.onBackgroundMessage(
        _firebaseMessagingBackgroundHandler,
      );

      // 3. Configurar Notificações Locais (Para mostrar quando app está aberto)
      await _setupLocalNotifications();

      // 4. Ouvir mensagens em Foreground (App Aberto)
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        _showLocalNotification(message);
      });

      // 5. Ouvir clique na notificação (Quando app estava em background)
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print('Usuário clicou na notificação: ${message.data}');
        // Navegar para uma tela específica: Modular.to.pushNamed(...)
      });
    }
  }

  Future<String?> getToken() async {
    final token = await _firebaseMessaging.getToken();
    print("FCM Token: $token");
    return token; // Envie este token para o seu backend salvar no User
  }

  Future<void> _setupLocalNotifications() async {
    const androidSettings = AndroidInitializationSettings(
      '@drawable/ic_stat_notification',
    );
    const iosSettings = DarwinInitializationSettings();

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotifications.initialize(initSettings);
  }

  void _showLocalNotification(RemoteMessage message) {
    final notification = message.notification;
    final android = message.notification?.android;

    if (notification != null && android != null) {
      _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'channel_id_fidelin', // ID do canal
            'Notificações Gerais', // Nome visível nas configurações do Android
            importance: Importance.max,
            priority: Priority.high,
          ),
        ),
      );
    }
  }
}
