
import 'package:flutter/material.dart';
import 'package:flutter_application_1/api_widget.dart';
import 'package:flutter_application_1/base_widget.dart';
import 'package:flutter_application_1/main.dart';


class SecondScreen extends BasePage {
  const SecondScreen({Key? key})
      : super(key: key, shouldListenToAppLifecycle: false);

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends BasePageState<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Second Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.blue),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const APIWidget()),
                );
              },
              child: const Text('Go to Third Screen'),
            ),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Go Back to Home Screen'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void didPushNext() {
    print("SecondScreen : didPushNext");
  }

  @override
  void didPop() {
    print("SecondScreen : didPop");
  }

  @override
  void didPush() {
    print("SecondScreen : didPush");
  }

  @override
  void didPopNext() {
    print("SecondScreen : didPopNext");
  }
}


