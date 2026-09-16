import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DatafastPaymentScreen extends StatefulWidget {
  final String checkoutId;

  /// Called after Datafast redirects with `resourcePath`.
  /// [resultUrl] is the full shopper-result URL (includes resourcePath).
  final Future<void> Function(String resultUrl)? onPaymentSuccess;

  const DatafastPaymentScreen({
    super.key,
    required this.checkoutId,
    this.onPaymentSuccess,
  });

  @override
  State<DatafastPaymentScreen> createState() => _DatafastPaymentScreenState();
}

class _DatafastPaymentScreenState extends State<DatafastPaymentScreen> {
  static const String _shopperResultUrl = 'https://localhost/payment-result';

  late final WebViewController controller;
  bool _handledResult = false;
  bool _isLoading = true;
  bool _isFinalizing = false;

  @override
  void initState() {
    super.initState();

    final String paymentHtml = '''
<!DOCTYPE html>
<html>
  <head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
    <style>
      body { margin: 12px; font-family: -apple-system, BlinkMacSystemFont, sans-serif; }
    </style>
    <script src="https://test.oppwa.com/v1/paymentWidgets.js?checkoutId=${widget.checkoutId}"></script>
  </head>
  <body>
    <form action="$_shopperResultUrl" class="paymentWidgets" data-brands="VISA MASTER DINERS DISCOVER"></form>
  </body>
</html>
''';

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {
            debugPrint('🌐 WebView navigate: ${request.url}');
            if (_isPaymentResult(request.url)) {
              _handlePaymentResult(request.url);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
          onPageStarted: (url) {
            debugPrint('🌐 WebView started: $url');
            if (mounted) setState(() => _isLoading = true);
          },
          onPageFinished: (String url) {
            debugPrint('🌐 WebView finished: $url');
            if (mounted) setState(() => _isLoading = false);
            if (_isPaymentResult(url)) {
              _handlePaymentResult(url);
            }
          },
        ),
      )
      ..loadHtmlString(paymentHtml, baseUrl: 'https://test.oppwa.com');
  }

  bool _isPaymentResult(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) return false;
    if (uri.queryParameters.containsKey('resourcePath')) return true;
    return url.contains('resourcePath=');
  }

  Future<void> _handlePaymentResult(String url) async {
    if (_handledResult) return;
    _handledResult = true;

    debugPrint('✅ Payment result URL: $url');

    if (mounted) {
      setState(() {
        _isFinalizing = true;
        _isLoading = false;
      });
    }

    final onSuccess = widget.onPaymentSuccess;
    if (onSuccess != null) {
      await onSuccess(url);
    }

    if (mounted) Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Secure Payment'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _isFinalizing ? null : () => Get.back(),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            color: const Color(0xFFE8F5E9),
            child: const Text(
              'Complete card payment below, then wait for verification.\n'
              'Test VISA: 4200000000000000 • any future expiry • any CVV',
              style: TextStyle(fontSize: 12, height: 1.35),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                WebViewWidget(controller: controller),
                if (_isLoading || _isFinalizing)
                  Container(
                    color: Colors.white.withValues(alpha: 0.85),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CircularProgressIndicator(),
                          if (_isFinalizing) ...[
                            const SizedBox(height: 16),
                            const Text('Verifying payment...'),
                          ],
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
