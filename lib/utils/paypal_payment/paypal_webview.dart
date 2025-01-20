import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaypalWebView extends StatefulWidget {
  String? url;
  PaypalWebView({super.key, required this.url});

  @override
  State<PaypalWebView> createState() => _WebUrlViewState();
}

class _WebUrlViewState extends State<PaypalWebView> {
  late final WebViewController controller;

  @override
  void initState() {

// TODO: implement initState
    print('url adnan :: ${widget.url}');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (navigation) {
            if (navigation.url != widget.url) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url.toString()));
    return WebViewWidget(controller: controller);
  }
}
