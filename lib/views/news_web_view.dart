// مش انا اللي كتبت الكود ده
// الكود ده من كورس اسمه Flutter & Dart - The Complete Guide [2024 Edition]
// الكورس على موقع Udemy الي جانب مساعدة ذكاء الاصطناعي في كتابة الكود
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_windows/webview_windows.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class NewsWebView extends StatefulWidget {
  final String url;

  const NewsWebView({super.key, required this.url});

  @override
  State<NewsWebView> createState() => _NewsWebViewState();
}

class _NewsWebViewState extends State<NewsWebView> {
  bool isLoading = true;

  WebViewController? _mobileController;
  final _windowsController = WebviewController();

  @override
  void initState() {
    super.initState();
    _initWebView();
  }

  Future<void> _initWebView() async {
    if (Platform.isAndroid || Platform.isIOS) {
      // ✅ موبايل (Android / iOS)
      late final PlatformWebViewControllerCreationParams params;
      if (Platform.isAndroid) {
        params = const PlatformWebViewControllerCreationParams();
      } else {
        params = WebKitWebViewControllerCreationParams();
      }

      final controller = WebViewController.fromPlatformCreationParams(params)
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(
          NavigationDelegate(
            onPageStarted: (_) => setState(() => isLoading = true),
            onPageFinished: (_) => setState(() => isLoading = false),
          ),
        )
        ..loadRequest(Uri.parse(widget.url));

      _mobileController = controller;
    } else if (Platform.isWindows) {
      // 💻 ويندوز
      await _windowsController.initialize();
      await _windowsController.loadUrl(widget.url);
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  void dispose() {
    if (Platform.isWindows) {
      _windowsController.dispose();
    }
    super.dispose();
  }

  Future<void> _handleBack() async {
    if (Platform.isWindows) {
      try {
        await _windowsController.goBack();
      } catch (e) {
        if (mounted) Navigator.pop(context);
      }
    } else if (_mobileController != null) {
      final canGoBack = await _mobileController!.canGoBack();
      if (canGoBack) {
        await _mobileController!.goBack();
      } else {
        if (mounted) Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await _handleBack();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'News',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Details',
                style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              color: Colors.orange,
              onPressed: _handleBack, // 👈 زر الرجوع داخل الصفحة
            ),
          ],
        ),
        body: Stack(
          children: [
            SafeArea(
              child: Platform.isWindows
                  ? Webview(_windowsController)
                  : _mobileController != null
                  ? WebViewWidget(controller: _mobileController!)
                  : const Center(child: Text("Loading...")),
            ),
            if (isLoading) const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
