import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:uni_links/uni_links.dart';

mixin UniversalLinkMixin<T extends StatefulWidget> on State<T> {
  StreamSubscription _callbackSubscription;

  @protected
  StreamSubscription get callbackSubscription => _callbackSubscription;

  @override
  void initState() {
    super.initState();
    _callbackSubscription = getUriLinksStream().listen(onUniversalLinkCallback);
  }

  @override
  void dispose() {
    _callbackSubscription.cancel();
    super.dispose();
  }

  void onUniversalLinkCallback(Uri uri);
}
