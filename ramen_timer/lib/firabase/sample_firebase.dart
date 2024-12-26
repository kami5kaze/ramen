import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SampleFirebase extends HookWidget {
  const SampleFirebase({Key? key}) : super(key: key);

  Future<Map<String, dynamic>?> getNameData() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('noodles')
          .doc('cupnoodle')
          .get();
      if (doc.exists && doc.data() != null) {
        final data = doc.data();
        print("データ：${data}");
        return data!['name'];
      } else {
        print("データが存在しません");
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final name = getNameData();
    print("name:${name}");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Sample'),
      ),
      body: Center(
        child: Column(
          children: [
            Text("テスト"),
            Text(name.toString()),
          ],
        ),
      ),
    );
  }
}
