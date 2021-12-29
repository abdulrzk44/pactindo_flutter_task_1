import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:pactindo_flutter_task_1/model/passenggers_data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'PACTINDO Flutter Task 1'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPage = 0;
  late List<Data> data;
  List<Map> items = [];
  bool isLoading = false;
  bool rmItem = true;

  Future _loadDataWithDio() async {
    await new Future.delayed(new Duration(milliseconds: 300));
    PassenggersData passenggersData;
    try {
      Response response;
      var options = BaseOptions(
        baseUrl: 'https://api.instantwebtools.net/v1',
        connectTimeout: 5000,
        receiveTimeout: 3000,
      );
      Dio dio = Dio(options);
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
      response = await dio.get('/passenger?page=$currentPage&size=10');
      passenggersData = PassenggersData.fromJson(response.data);
      setState(() {
        passenggersData.data.forEach((element) {
          var item = {
            'name': element.name,
            'airlinesCountry': element.airline[0].country,
            'airlinesName': element.airline[0].name
          };
          items.add(item);
        });
        isLoading = false;
      });
    } catch (e) {
      print('CATCH ERROR');
      print(e);
    }
    currentPage++;
  }

  @override
  void initState() {
    super.initState();
    _loadDataWithDio();
    // WidgetsBinding.instance!.addPostFrameCallback((_) => _loadDataWithDio());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Container(),
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (!isLoading &&
                    scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent) {
                  _loadDataWithDio();
                  // start loading data
                  setState(() {
                    isLoading = true;
                  });
                }
                return true;
              },
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('${items[index]['name']}'),
                    subtitle: Text('${items[index]['airlinesCountry']}'),
                    trailing: Text('${items[index]['airlinesName']}'),
                  );
                },
              ),
            ),
          ),
          Container(
            height: isLoading ? 50.0 : 0,
            width: isLoading ? 50.0 : 0,
            color: Colors.transparent,
            child: Center(
              child: new CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}
