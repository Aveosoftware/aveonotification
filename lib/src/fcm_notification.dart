part of aveonotification;

class FcmNotification {
  FcmNotification._instance();
  static FcmNotification get instance => FcmNotification._instance();

  ///server key of your firebse project
  late String serverKey;

  ///Set a backgroundHandler function which is called when the app is in the background or terminated.
  ///
  ///This provided handler must be a top-level function(outside main function) and cannot be anonymous otherwise an [ArgumentError] will be thrown.
  ///   example of backroundHandler:
  late Future<void> Function(RemoteMessage remoteMessage) backgroundHandler;

  ///this function will be called, If the application has been opened from a terminated state via a [RemoteMessage] (containing a [Notification]), it will be returned, otherwise it will be null.

  late Function(RemoteMessage? remoteMessage)? getIntial;

  ///function that will be called  when an incoming FCM payload is received whilst the Flutter instance is in the foreground.
  late Function(RemoteMessage? remotem)? onMessage;

  ///this function will be called, if the app has opened from a background state (not terminated).
  ///
  ///If your app is opened via a notification whilst the app is terminated, see [getInitialMessage].
  late Function(RemoteMessage? remotem)? onMessageOpenedApp;

  ///[FcmNotification] is a package used to get pushNotification easily, you should initailize this pacakge in main function of your app
  ///
  ///example:
  ///
  ///        FcmNotification.init(backgroundHandler: backgroundHandler,serverKey:'Your server key of firebase');
  ///
  ///Note : Set a backgroundHandler function which is called when the app is in the background or terminated.
  ///
  ///This provided handler must be a top-level function(outside main function) and cannot be anonymous otherwise an [ArgumentError] will be thrown.
  ///   example of backroundHandler:
  ///
  ///                               Future<void> backgroundHandler(RemoteMessage message) async {
  ///
  ///                                       print(message.data.toString());
  ///
  ///                                       print(message.notification!.title);
  ///
  ///                               }
  ///
  FcmNotification.init(
      {required this.serverKey,
      required this.backgroundHandler,
      this.getIntial,
      this.onMessage,
      this.onMessageOpenedApp}) {
    LocalNotificationService.initialize();
    D2DNotification(serverKey: serverKey);
    _getInitailmsg(getIntial);
    _onMsgListen();
    _backgroundMessageHandler(backgroundHandler);
    _onMessageOpenedApp(onMessageOpenedApp);
    FirebaseMessaging.instance
        .getToken()
        .then((value) => print('token---------' + value!));
  }

  ///this method will send notification to perticular topic,all the user subscribed to that topic will get notification
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

  ///this will subscribe the user to the [topic] provided
  ///
  ///[topic] must match the following regular expression: [a-zA-Z0-9-_.~%]{1,900}.
  Future subscribeToD2dNotification(String topic) async {
    await FirebaseMessaging.instance.subscribeToTopic(topic);
  }

  ///unsubscribe [D2DNotification]
  Future unSubscribeD2dNotification(String topic) async {
    await FirebaseMessaging.instance.unsubscribeFromTopic(topic);
  }

  _getInitailmsg(Function(RemoteMessage? remoteMessage)? getIntial) {
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

  _onMessageOpenedApp(
      Function(RemoteMessage? remoteMessage)? onMessageOpenedApp) {
    FirebaseMessaging.onMessageOpenedApp.listen(onMessageOpenedApp);
  }
}
