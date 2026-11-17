import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    // 1. Pede permissão ao utilizador
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // 2. Configura a inicialização das notificações locais
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);

    await _localNotificationsPlugin.initialize(initializationSettings);

    // 3. Cria o canal de notificações de alta importância (Android)
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'reage_lembretes',
      'Lembretes ReAge',
      description: 'Lembretes diários de hidratação e exercícios',
      importance: Importance.max,
    );

    await _localNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    // 4. Imprime o Token FCM na consola para testes
    String? token = await _firebaseMessaging.getToken();
    print('FCM Token do dispositivo: $token');

    // 5. Mostra a notificação mesmo quando a app está aberta
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        _localNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: '@mipmap/ic_launcher',
            ),
          ),
        );
      }
    });
  }

  // Método para subscrever/cancelar lembretes através do MenuScreen
  static Future<void> toggleTopicSubscription(String topic, bool subscribe) async {
    if (subscribe) {
      await _firebaseMessaging.subscribeToTopic(topic);
    } else {
      await _firebaseMessaging.unsubscribeFromTopic(topic);
    }
  }
}