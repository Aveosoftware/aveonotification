part of aveonotification;

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}

class FcmNotification {
  FcmNotification._instance();
  static FcmNotification get instance => FcmNotification._instance();

  factory FcmNotification({required String serverKey}) {
    LocalNotificationService.initialize();
    D2DNotification(serverKey: serverKey);
    FirebaseMessaging.onBackgroundMessage(backgroundHandler);
    instance._getInitailmsg();
    instance._onMsgListen();
    instance._onMessageOpenedApp();
    FirebaseMessaging.instance
        .getToken()
        .then((value) => print('token---------' + value!));
    return instance;
  }

  Future<D2DNotificationTopicResponse?> sendD2DNotification(
      {required String to,
      required String title,
      required String body,
      Map<String, dynamic>? data}) async {
    D2DNotificationRequest request = D2DNotificationRequest(
      to: to,

      title: title,
      // subtitle: "This is subtitle",
      body: body,
      data: data ?? {},
    );
    D2DNotificationTopicResponse? response =
        await D2DNotification.instance.sendNotificationToTopic(request);

    return response;
  }

  _getInitailmsg() {
    FirebaseMessaging.instance.getInitialMessage();
  }

  _onMsgListen() {
    FirebaseMessaging.onMessage.listen((message) {
      LocalNotificationService.createanddisplaynotification(message);
    });
  }

  _onMessageOpenedApp() {
    FirebaseMessaging.onMessageOpenedApp.listen((message) {});
  }
}
