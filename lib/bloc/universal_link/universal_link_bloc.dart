import 'package:bloc/bloc.dart';
import 'package:glacius_mobile/bloc/universal_link/universal_link.dart';
import 'package:uni_links/uni_links.dart';
import 'package:flutter/services.dart';

class UniversalLinkBloc extends Bloc<UniversalLinkEvent, UniversalLinkState> {
  @override
  UniversalLinkState get initialState => UniversalLinkInitial();

  @override
  Stream<UniversalLinkState> mapEventToState(UniversalLinkEvent event) async* {
    if (event is CheckIfAppCameFromLinks) {
      try {
        Uri initialLink = await getInitialUri();
        if (initialLink == null) {
          yield UniversalLinkCheckCompleted(isCameFromUniversalLink: false);
        } else {
          yield UniversalLinkCheckCompleted(
            isCameFromUniversalLink: true,
            action: initialLink.host,
            path: initialLink.path,
          );
        }
      } on PlatformException {
        yield UniversalLinkCheckCompleted(isCameFromUniversalLink: false);
      }
    }
  }
}
