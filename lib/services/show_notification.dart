import 'package:doctor_call/doctowrapper.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class ShowNotification {

  static final FlutterLocalNotificationsPlugin notificationPlugin =  FlutterLocalNotificationsPlugin();

  static void initialize(context){
    final InitializationSettings initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );

    notificationPlugin.initialize(initializationSettings, onSelectNotification: (String? route) async {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const DoctorWrapper()));
    });
  }

  static void display(RemoteMessage message) async {
    final id = DateTime.now().millisecondsSinceEpoch ~/1000;

    final NotificationDetails notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'amrdoctor',
        'amrdoctor channel',
        importance: Importance.max,
        priority: Priority.high,
      )
    );

    await notificationPlugin.show(
      id,
      message.notification!.title,
      message.notification!.body,
      notificationDetails,
    );
  }
}