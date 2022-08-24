part of aveonotification;

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize() {
    // initializationSettings  for Android
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings(
              "@mipmap/ic_launcher",
            ),
            iOS: IOSInitializationSettings());

    notificationsPlugin.initialize(
      initializationSettings,
      // onSelectNotification: redirectToProfile,
    );
  }

  // static redirectToProfile(String? json) {
  //   Map data = jsonDecode(json!);
  //   if (data != null) {
  //     if (FirebaseAuth.instance.currentUser != null) {
  //       // DashboardController.to.changeView(5);
  //       Get.toNamed(Routes.MATCH_PROFILE,
  //           arguments: MatchProfileViewArgs(
  //               isRequestSent: int.parse(data['status']).isOdd ? false : true,
  //               status: int.parse(data['status']),
  //               uid: data['senderId']));
  //     } else {
  //       Storage.store('isFromNotification', true);
  //       Storage.store('payload', data);
  //     }
  //   }
  // }

  static void createanddisplaynotification(RemoteMessage message) async {
    try {
      print(message);
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      const NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
            "pushnotificationapp",
            "pushnotificationappchannel",
            importance: Importance.max,
            priority: Priority.high,
          ),
          iOS: IOSNotificationDetails());
      await notificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
      );
    } on Exception catch (e) {
      print(e);
    }
  }
}
