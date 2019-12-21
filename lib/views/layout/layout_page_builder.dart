import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glacius_mobile/bloc/auth/auth.dart';
import 'package:glacius_mobile/bloc/universal_link/universal_link.dart';
import 'package:glacius_mobile/views/layout/layout.dart';
import 'package:glacius_mobile/widgets/widgets.dart';

import 'bloc/bloc.dart';

class LayoutPageBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _BindBlocProvider(
      child: _InjectBlocListener(
        child: _BlocProviderInjector(),
      ),
    );
  }
}

class _BindBlocProvider extends StatelessWidget {
  final Widget child;

  _BindBlocProvider({this.child});

  @override
  Widget build(BuildContext context) {
    return PersistedBlocProvider(
      child: child,
    );
  }
}

class _InjectBlocListener extends StatelessWidget {
  final Widget child;

  _InjectBlocListener({this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: <BlocListener>[
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthUnauthenticated) {
              Navigator.pushReplacementNamed(context, '/');
            }
          },
        ),
        BlocListener<UniversalLinkBloc, UniversalLinkState>(
          listener: (context, state) {
            if (state is UniversalLinkCheckCompleted) {
              if (state.isCameFromUniversalLink == true) {
                //navigate according to universal link
                Navigator.pushNamed(context, state.path);
              }
            }
          },
        )
      ],
      child: child,
    );
  }
}

class _BlocProviderInjector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutPage(
      universalLinkBloc: BlocProvider.of<UniversalLinkBloc>(context),
      layoutBloc: BlocProvider.of<LayoutBloc>(context),
    );
  }
}
