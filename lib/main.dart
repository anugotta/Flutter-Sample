import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/base_widget.dart';
import 'package:flutter_application_1/home_widget.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
LocalNotifier notifier = LocalNotifier();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends BasePage {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends BasePageState<MyApp> {
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        notifier.shouldShow.addListener(() {
          if (notifier.shouldShow.value) {
            _showNoInternetDialog();
          } else {
            _hideNoInternetDialog();
          }
        });
      },
    );
  }

  void _showNoInternetDialog() {
    if (_overlayEntry == null) {
      _overlayEntry = _createOverlayEntry();
      navigatorKey.currentState!.overlay!.insert(_overlayEntry!);
    }
  }

  void _hideNoInternetDialog() {
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 3,
          sigmaY: 3,
        ),
        child: Container(
          color: Colors.black.withOpacity(0),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: ElevatedButton(
              onPressed: () {
                notifier.setValue(false);
              },
              child: const Text('Remove Overlay'),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      navigatorObservers: [routeObserver],
      home: const HomeScreen(),
    );
  }
}

class LocalNotifier {
  final shouldShow = ValueNotifier<bool>(false);

  setValue(bool value) {
    shouldShow.value = value;
  }
}
