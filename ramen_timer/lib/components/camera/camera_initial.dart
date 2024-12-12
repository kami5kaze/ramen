import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:ramen_timer/components//camera/camera.dart';

startCamera() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;
  print(firstCamera);
  runApp(CameraApp(firstCamera));
}
