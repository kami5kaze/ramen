import 'package:audioplayers/audioplayers.dart';

void playLoudSound() async {
  AudioPlayer audioPlayer = AudioPlayer();
  await audioPlayer.setVolume(1.0); // 最大音量
  await audioPlayer.play(
    AssetSource('大爆発2.mp3'),
  );
}
