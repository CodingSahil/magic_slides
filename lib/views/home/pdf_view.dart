import 'dart:io';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PdfView extends StatefulWidget {
  const PdfView({super.key, this.arguments});

  final dynamic arguments;

  @override
  State<PdfView> createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfView> {
  late final String previewUrl;
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    previewUrl = 'https://docs.google.com/gview?embedded=true&url=${Uri.encodeComponent(widget.arguments.toString())}';
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(previewUrl));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [WebViewWidget(controller: controller)]),
    );
  }
}
