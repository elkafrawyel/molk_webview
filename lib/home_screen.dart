import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  WebViewController? _controller;

  final Completer<WebViewController> _controllerCompleter =
  Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: WillPopScope(
          onWillPop: () => _goBack(context),

          child: WebView(
            initialUrl: 'http://molk-kw.com/',
            javascriptMode: JavascriptMode.unrestricted,
            zoomEnabled: false,
            onWebViewCreated: (WebViewController webViewController) {
              _controllerCompleter.future.then((value) => _controller = value);
              _controllerCompleter.complete(webViewController);
            },
          ),
        ),
      ),
    );
  }

  Future<bool> _goBack(BuildContext context) async {
    if (_controller!=null&& await _controller!.canGoBack()) {
      _controller!.goBack();
      return Future.value(false);
    } else {
      // showDialog(
      //     context: context,
      //     builder: (context) => AlertDialog(
      //       title: Text('Do you want to exit'),
      //       actions: <Widget>[
      //         FlatButton(
      //           onPressed: () {
      //             Navigator.of(context).pop();
      //           },
      //           child: Text('No'),
      //         ),
      //         FlatButton(
      //           onPressed: () {
      //             SystemNavigator.pop();
      //           },
      //           child: Text('Yes'),
      //         ),
      //       ],
      //     ));
      return Future.value(true);
    }
  }
}
