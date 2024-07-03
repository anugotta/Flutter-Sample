import 'package:flutter/material.dart';
import 'package:flutter_application_1/base_widget.dart';
import 'package:dio/dio.dart';
import 'package:http_cyclic_mocks/http_cyclic_mocks.dart';

class APIWidget extends BasePage {
  const APIWidget({Key? key})
      : super(key: key, shouldListenToAppLifecycle: true);

  @override
  State<APIWidget> createState() => _APIWidgetState();
}

class _APIWidgetState extends BasePageState<APIWidget> {
  final dio = Dio();
  late CyclicMockClient mockHttpClient;
  final sampleJsonResponse =
      "{\"browsers\":{\"firefox\":{\"name\":\"Firefox\",\"pref_url\":\"about:config\",\"releases\":{\"1\":{\"release_date\":\"2004-11-09\",\"status\":\"retired\",\"engine\":\"Gecko\",\"engine_version\":\"1.7\"}}}}}";

  @override
  void initState() {
    super.initState();

    mockHttpClient = CyclicMockClient(dio);

    mockHttpClient.addMockResponses('/route1', [
      MockResponse(data: {'Route 1': sampleJsonResponse}, statusCode: 200),
      MockResponse(data: {'Route 1': 'SUCCESS'}, statusCode: 200),
    ]);

    mockHttpClient.addMockResponses('/route2', [
      MockResponse(data: {'Route 2': 'SUCCESS - 2'}, statusCode: 200),
      MockResponse(data: {'Route 2': sampleJsonResponse}, statusCode: 200),
      MockResponse(data: {'Route 2': 'SUCCESS - 1'}, statusCode: 200),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('API Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.blue),
              onPressed: () async {
                final response1 = await dio.get('/route1');
                print(response1.data);

                try {
                  final response2 = await dio.get('/route2');
                  print(response2.data);
                } catch (e) {
                  print(e); // For catching 400 errors
                }
              },
              child: const Text('Call Mock API'),
            ),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Go Back to Second Screen'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void didPushNext() {
    print("APIScreen : didPushNext");
    super.didPushNext();
  }

  @override
  void didPop() {
    print("APIScreen : didPop");
  }

  @override
  void didPush() {
    print("APIScreen : didPush");
  }

  @override
  void didPopNext() {
    print("APIScreen : didPopNext");
  }
}
