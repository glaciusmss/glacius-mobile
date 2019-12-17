import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glacius_mobile/bloc/auth/auth.dart';
import 'package:glacius_mobile/bloc/universal_link/universal_link.dart';
import 'package:glacius_mobile/views/layout/layout.dart';
import 'package:glacius_mobile/widgets/widgets.dart';

class LayoutPageBuilder extends StatelessWidget {
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
      child: PersistedBlocProvider(
        child: LayoutPage(),
      ),
    );
  }
}
