# AveoNotification

AveoNotification package simplifys the receving FCM push notification and sending notification to a topic

## What you save 
 If you implement Receving and Sending FCM notification from the scratch it can take upto 20-30 hrs in total to setup and debug. AveoNotification will wrap-up this in just 5 mins!!!  
  


 - [Features](#features)
 - [Getting started](#getting-started)
    - [Requirements](#requirements)
    - [Android](#android)
    - [IOS](#ios)
    - [Usage](#usage)

## Features

-  recevies notifications  from firebase

-  subscribe to topic for notification

-  send notification to a topic

-  unsubscribe from a topic

## Getting started

### Requirements

* before using this package you need to create a firebase project

 * then go to Project Setting/Cloud messaging for getting [server key] of your firebase project.

### Android

for android version 13(API level 33) and above you need to ask user for notification permission.

 add below code in your AndroidManifest.xml file

```xml
<manifest ...>
        <uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
        <application ...>
        ...
     </application>
</manifest>
```

    Caution: If your app targets 12L or lower and the user taps Don't allow, even just once, they aren't prompted again until one of the following occurs:

    The user uninstalls and reinstalls your app.
    You update your app to target Android 13 or higher.


### IOS

* generate APNS key from your apple console and add APNs Authentication Key to your firebase project

* for receving notification in ios you need to add following in your AppDelegate.swift file

```swift
import UIKit
import Flutter
import FirebaseMessaging
import Firebase

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      FirebaseApp.configure()
      if #available(iOS 10.0, *) {
        // For iOS 10 display notification (sent via APNS)
        UNUserNotificationCenter.current().delegate = self

        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
          options: authOptions,
          completionHandler: { _, _ in }
        )
      } else {
        let settings: UIUserNotificationSettings =
          UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
        application.registerUserNotificationSettings(settings)
      }

      application.registerForRemoteNotifications()

    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  
    
    override func application(_ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
      Messaging.messaging().apnsToken = deviceToken;
    }

}

```


## Usage

* for receving FCM notification initialize `[FcmNotification]` in your main function

```dart
Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}
void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    FcmNotification.init(
      backgroundHandler: backgroundHandler // this must be the top level function placed outside main fuction.
      serverKey: 'Your server key');
```

* for Sending/Subscribing/Unsubscribing d2dNotifications
  
  ```dart
    FcmNotification.instance.subscribeToD2dNotification('Topic'); // Subscribing topic

    FcmNotification.instance
        .sendD2DNotification(to: topic, title: title, body: body);// Sending notification to a topic

    FcmNotification.instance.unSubscribeD2dNotification('Topic');// Unsubscribing topic
  ```

  ## Where to use
  - Need to receive notifications through FrebaseCustomMessaging(FCM)? cool By using Aveonotification you can start receiving notifications  by adding just one line!!
  - Want to send notification to a topic from device? don't worry we got your back. you can send/receive notification from topic that too by adding one line!!!