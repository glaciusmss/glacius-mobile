import 'package:flutter/foundation.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class OAuthHelper {
  ChromeSafariBrowser browser;

  OAuthHelper({ChromeSafariBrowser browser}) {
    browser ??= OAuthBrowser();
    this.browser = browser;
  }

  Future<void> connect(String url) async {
    return await browser.open(
      url: url,
      options: ChromeSafariBrowserClassOptions(),
    );
  }
}

class OAuthBrowser extends ChromeSafariBrowser {
  VoidCallback onClosedCallback;

  OAuthBrowser({this.onClosedCallback})
      : super(
          bFallback: OAuthFallbackBrowser(
            onClosedCallback: onClosedCallback,
          ),
        );

  @override
  void onClosed() {
    onClosedCallback();
  }
}

class OAuthFallbackBrowser extends InAppBrowser {
  VoidCallback onClosedCallback;

  OAuthFallbackBrowser({this.onClosedCallback});

  @override
  void onExit() {
    onClosedCallback();
  }
}
