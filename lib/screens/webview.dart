import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:currency/data/data.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:currency/util/networkapi.dart';

class Webviewscreen extends StatefulWidget {
  var id;
  Webviewscreen({this.id = 0});
  @override
  _WebviewscreenState createState() => _WebviewscreenState(id: id);
}

class _WebviewscreenState extends State<Webviewscreen> {
  WebViewController _controller;
  var id;
  _WebviewscreenState({this.id});
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blue,
          title: Text(
            menuname[id],
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        body: WebView(
          initialUrl: urls[id],
        ));
  }
/*
          onWebViewCreated: (WebViewController webViewController) {
            _controller = webViewController;
            _loadHtmlFromAssets();
          },*/
  _loadHtmlFromAssets() async {
    String fileText = await ApiHelper.getHtml(urls[id]);
    String ff = '<html><body>$fileText</html>';
    _controller.loadUrl(Uri.dataFromString('<html><body>$fileText</html>',
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }
} //urls[id]
