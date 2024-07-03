import 'package:flutter/material.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class BasePage extends StatefulWidget {
  final bool shouldListenToAppLifecycle;

  const BasePage({Key? key, this.shouldListenToAppLifecycle = false})
      : super(key: key);

  @override
  State<BasePage> createState() => BasePageState();
}

class BasePageState<T extends BasePage> extends State<T>
    with WidgetsBindingObserver, RouteAware {
  @override
  void initState() {
    super.initState();
    if (widget.shouldListenToAppLifecycle) {
      WidgetsBinding.instance.addObserver(this);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final ModalRoute<dynamic>? route = ModalRoute.of(context);
    if (route is PageRoute) {
      routeObserver.subscribe(this, route);
    }
  }

  @override
  void dispose() {
    if (widget.shouldListenToAppLifecycle) {
      WidgetsBinding.instance.removeObserver(this);
    }
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (widget.shouldListenToAppLifecycle) {
      super.didChangeAppLifecycleState(state);
      print('${T.toString()} AppLifecycleState changed to $state');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(); 
  }
}
