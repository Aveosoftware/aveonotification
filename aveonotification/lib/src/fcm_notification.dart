part of aveonotification;

class FcmNotification {
  FcmNotification._instance();
  static FcmNotification get instance => FcmNotification._instance();

  factory FcmNotification(
      {required String serverKey,
      required Future<void> Function(RemoteMessage remoteMessage)
          backgroundHandler,
      Function(RemoteMessage? remoteMessage)? getIntial,
      Function(RemoteMessage? remotem)? onMessage,
      Function(RemoteMessage? remotem)? onMessageOpenedApp}) {
    LocalNotificationService.initialize();
    D2DNotification(serverKey: serverKey);
    instance.getInitailmsg(getIntial);
    instance._onMsgListen();
    instance._backgroundMessageHandler(backgroundHandler);
    instance._onMessageOpenedApp(onMessageOpenedApp);
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

  getInitailmsg(Function(RemoteMessage? remotem)? getIntial) {
    FirebaseMessaging.instance
        .getInitialMessage()
        .then(getIntial ?? (remotem) {});
  }

  _backgroundMessageHandler(
      Future<void> Function(RemoteMessage remoteMessage) backgroundHandler) {
    FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  }

  _onMsgListen() {
    FirebaseMessaging.onMessage.listen((message) {
      LocalNotificationService.createanddisplaynotification(message);
    });
  }

  _onMessageOpenedApp(Function(RemoteMessage? remotem)? onMessageOpenedApp) {
    FirebaseMessaging.onMessageOpenedApp.listen(onMessageOpenedApp);
  }
}
