import 'package:flutter/material.dart';

class PrisetButton {
  Widget oneMinute(ValueNotifier<int> myMinute) {
    return SizedBox(
      width: 80,
      height: 35,
      child: ElevatedButton(
        onPressed: () => {
          myMinute.value = 1,
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
        ),
        child: Text("1分"),
      ),
    );
  }

  Widget threeMinutes(
      ValueNotifier<int>? myMinute, ValueNotifier<int>? newMinute) {
    return SizedBox(
      width: 80,
      height: 35,
      child: ElevatedButton(
        onPressed: () => {
          if (newMinute == null)
            {
              myMinute!.value = 3,
            }
          else
            {
              newMinute.value = 3,
            }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
        ),
        child: Text("3分"),
      ),
    );
  }

  Widget fiveMinutes(
      ValueNotifier<int>? myMinute, ValueNotifier<int>? newMinute) {
    return SizedBox(
      width: 80,
      height: 35,
      child: ElevatedButton(
        onPressed: () => {
          if (newMinute == null)
            {
              myMinute!.value = 5,
            }
          else
            {
              newMinute.value = 5,
            }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
        ),
        child: Text("5分"),
      ),
    );
  }

  Widget tenMinutes(ValueNotifier<int> myMinute) {
    return SizedBox(
      width: 80,
      height: 35,
      child: ElevatedButton(
        onPressed: () => {
          myMinute.value = 10,
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
        ),
        child: Text("10分"),
      ),
    );
  }

  Widget plusMinute(ValueNotifier<int> myMinute) {
    return SizedBox(
      width: 110,
      height: 35,
      child: ElevatedButton(
        onPressed: () => {
          myMinute.value += 1,
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
        ),
        child: const Text("+1分"),
      ),
    );
  }

  Widget plusTenSeconds(
      ValueNotifier<int> mySecond, ValueNotifier<int> myMinute) {
    return SizedBox(
      width: 110,
      height: 35,
      child: ElevatedButton(
        onPressed: () => {
          if (mySecond.value < 50)
            {
              mySecond.value += 10,
            }
          else if (mySecond.value == 50)
            {
              mySecond.value = 0,
              myMinute.value += 1,
            }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
        ),
        child: const Text("+10秒"),
      ),
    );
  }
}
