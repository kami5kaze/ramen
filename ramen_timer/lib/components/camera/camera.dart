import "dart:io";

import "package:flutter/material.dart";
import "package:camera/camera.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:ramen_timer/components/result.dart";
import "package:ramen_timer/home/home.dart";
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class CameraApp extends HookWidget {
  const CameraApp(this.camera);

  final CameraDescription camera;

  @override
  Widget build(BuildContext context) {
    late CameraController? _controller =
        CameraController(camera, ResolutionPreset.medium);
    late Future<void> _initializeControllerFuture = _controller.initialize();
    final textRecognizer =
        TextRecognizer(script: TextRecognitionScript.japanese);

    return Scaffold(
      appBar: AppBar(
        title: const Text("カメラ"),
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // カメラプレビューを表示
            return _controller != null
                ? CameraPreview(_controller)
                : const Center(child: Text('カメラの初期化に失敗しました'));
          } else {
            // 読み込み中のインジケーターを表示
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            final image = await _controller.takePicture();
            final file = File(image.path);
            final inputImage = InputImage.fromFile(file);
            final recognizedText =
                await textRecognizer.processImage(inputImage);

            await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ResultPage(recognizedText: recognizedText),
              fullscreenDialog: true,
            ));
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('失敗'),
              ),
            );
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    ); // Replace with your actual widget tree
  }
}
