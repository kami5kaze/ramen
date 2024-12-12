import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ramen_timer/components/camera/camera.dart';
import 'package:ramen_timer/components/finish_sound.dart';
import 'package:ramen_timer/components/priset_button.dart';

class HomePage extends HookWidget {
  const HomePage({Key? key, required this.camera}) : super(key: key);

  final CameraDescription camera;

  @override
  Widget build(BuildContext context) {
    final myMinute = useState(0);
    final mySecond = useState(0);
    Timer? timer;
    final isPoused = useState(false);
    final additionalTimers = useState<List<Map<String, dynamic>>>([]);
    final newMinutes = useState(0);
    final newSeconds = useState(0);

    void resetTimer() {
      myMinute.value = 0;
      mySecond.value = 0;
    }

    void stopTimer({bool reset = true}) {
      if (reset) {
        resetTimer();
      }
      timer?.cancel();
      isPoused.value = true;
    }

    void startTimer() {
      timer = Timer.periodic(
        Duration(seconds: 1),
        (_) {
          if (mySecond.value > 0 || myMinute.value > 0) {
            if (myMinute.value > 0 && mySecond.value == 0) {
              myMinute.value--;
              mySecond.value = 59;
            } else {
              mySecond.value--;
            }
          } else {
            stopTimer(reset: false);
            playLoudSound();
          }
        },
      );
    }

    void stopAdditionalTimer(int index, {bool reset = true}) {
      final currentTimer = additionalTimers.value[index];
      currentTimer['timer']?.cancel();
      currentTimer['isPaused'] = true;
      if (reset) {
        currentTimer['minutes'] = 0;
        currentTimer['seconds'] = 0;
      }
      additionalTimers.value = List.from(additionalTimers.value); // Update UI
    }

    void startAdditionalTimer(int index) {
      additionalTimers.value[index]['timer'] = Timer.periodic(
        const Duration(seconds: 1),
        (_) {
          final currentTimer = additionalTimers.value[index];
          if (currentTimer['seconds'] > 0 || currentTimer['minutes'] > 0) {
            if (currentTimer['minutes'] > 0 && currentTimer['seconds'] == 0) {
              currentTimer['minutes']--;
              currentTimer['seconds'] = 59;
            } else {
              currentTimer['seconds']--;
              additionalTimers.value =
                  List.from(additionalTimers.value); // Update UI
            }
          } else {
            stopAdditionalTimer(index, reset: false);
          }
        },
      );
    }

    void deleteAdditionalTimer(int index) {
      additionalTimers.value.removeAt(index);
      additionalTimers.value = List.from(additionalTimers.value); // Update UI
    }

    void showAddTimerDialog() {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('追加タイマーを設定'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    PrisetButton().threeMinutes(null, newMinutes),
                    PrisetButton().fiveMinutes(null, newMinutes),
                  ],
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  additionalTimers.value.add({
                    'minutes': newMinutes.value,
                    'seconds': newSeconds.value,
                    'isPaused': true,
                    'timer': null,
                  });
                  additionalTimers.value = List.from(additionalTimers.value);
                  Navigator.of(context).pop();
                },
                child: const Text('追加'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('キャンセル'),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ramen Timer'),
      ),
      body: Center(
        child: Column(
          children: [
            //タイマー
            Text(
              "${myMinute.value}分${mySecond.value}秒",
              style: const TextStyle(
                fontSize: 80,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            //一般的な時間設定
            Padding(
              padding: EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  PrisetButton().threeMinutes(myMinute, null),
                  PrisetButton().fiveMinutes(myMinute, null),
                  PrisetButton().tenMinutes(myMinute),
                ],
              ),
            ),
            //オリジナル時間設定
            Padding(
              padding: EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  PrisetButton().plusMinute(myMinute),
                  PrisetButton().plusTenSeconds(mySecond, myMinute),
                ],
              ),
            ),
            //start/resetボタン
            Padding(
              padding: EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 110,
                    height: 35,
                    child: ElevatedButton(
                      onPressed: () => {
                        startTimer(),
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      child: const Text("START"),
                    ),
                  ),
                  SizedBox(
                    width: 110,
                    height: 35,
                    child: ElevatedButton(
                      onPressed: () => {stopTimer()},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      child: const Text("リセット"),
                    ),
                  ),
                ],
              ),
            ),
            //追加タイマー
            for (int i = 0; i < additionalTimers.value.length; i++)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${additionalTimers.value[i]['minutes']}分 ${additionalTimers.value[i]['seconds']}秒",
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.play_arrow),
                            onPressed: () => startAdditionalTimer(i),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => deleteAdditionalTimer(i),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            Align(
              alignment: Alignment.bottomRight,
              child: Column(
                children: [
                  IconButton(
                    onPressed: showAddTimerDialog,
                    icon: Icon(Icons.add_circle_outline),
                    style: ButtonStyle(
                      iconSize: MaterialStateProperty.all(50),
                    ),
                  ),
                  IconButton(
                    onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CameraApp(camera),
                        ),
                      ),
                      print("カメラ:${camera}"),
                      print("成功"),
                    },
                    icon: const Icon(Icons.camera_alt),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
