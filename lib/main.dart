import 'package:aqua_store/screen/car_details.dart';
import 'package:aqua_store/screen/homepage.dart';
import 'package:aqua_store/screen/login_screen.dart';
import 'package:aqua_store/services/cartservices.dart';
import 'package:aqua_store/services/get_rent_services.dart';
import 'package:aqua_store/services/product_service.dart';
import 'package:aqua_store/services/searchProduct_api.dart';
import 'package:aqua_store/services/view_my_order_services.dart';
import 'package:aqua_store/utils/shared_preference.dart';
import 'package:aqua_store/utils/time_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AwesomeNotifications().initialize(null, // icon for your app notification
      [
        NotificationChannel(
            channelKey: 'key1',
            channelName: 'Aqua Store',
            channelDescription: "Notification example",
            defaultColor: const Color(0XFF9050DD),
            ledColor: Colors.green[900],
            playSound: true,
            enableLights: true,
            importance: NotificationImportance.High,
            enableVibration: true)
      ]);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => MyProduct()),
    ChangeNotifierProvider(create: (_) => TimeProvider()),
    ChangeNotifierProvider(create: (_) => GetAllOrders()),
    ChangeNotifierProvider(create: (_) => SearchProduct()),
    ChangeNotifierProvider(create: (_) => ViewMyOrders()),
    ChangeNotifierProvider(create: (_) => CartProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aqua Store',
      theme: ThemeData(
        primaryColor: Colors.green[800],
      ),
      home: LoginScreen(),
    );
  }
}
