import 'package:flutter/material.dart';
import 'package:flutter_application_1/base_widget.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/second_widget.dart';

class HomeScreen extends BasePage {
  const HomeScreen({Key? key})
      : super(key: key, shouldListenToAppLifecycle: true);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BasePageState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.blue),
              onPressed: () {
                notifier.setValue(true);
              },
              child: const Text('Show Overlay'),
            ),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.green),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SecondScreen()),
                );
              },
              child: const Text('Go to Second Screen'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void didPushNext() {
    print("Home : didPushNext");
  }

  @override
  void didPop() {
    print("Home : didPop");
  }

  @override
  void didPush() {
    print("Home : didPush");
  }

  @override
  void didPopNext() {
    print("Home : didPopNext");
  }
}
