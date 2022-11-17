part of aveonotification;

///this class is used to show local notitfication on device
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
      // onSelectNotification:
      // ,
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

  /// this method invokes notification on device
  static void createanddisplaynotification(RemoteMessage message) async {
    try {
      print(message);
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      const NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
            "pushnotificationapp",
            "pushnotificationappchannel",
            importance: Importance.max,
            priority: Priority.max,
          ),
          iOS: IOSNotificationDetails());
      await notificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
      );
    } on Exception catch (e) {
      rethrow;
    }
  }
}
