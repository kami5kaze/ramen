import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:ramen_timer/firabase/sample_firebase.dart';
import 'package:ramen_timer/home/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ramen_timer/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;
  final app = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform);
  print("初期化:${app}");
  runApp(MyApp(camera: firstCamera));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.camera});

  final CameraDescription camera;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: HomePage(
      //   camera: camera,
      // ),
      home: SampleFirebase(),
    );
  }
}
