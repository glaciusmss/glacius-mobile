import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glacius_mobile/bloc/universal_link/universal_link.dart';
import 'package:glacius_mobile/views/layout/bloc/bloc.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';

class LayoutPage extends StatefulWidget {
  @override
  _LayoutPageState createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<UniversalLinkBloc>(context)
          .add(CheckIfAppCameFromLinks());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutBloc, LayoutState>(
      builder: (context, layoutState) {
        return Scaffold(
          body: layoutState.pages[layoutState.selectedPageIndex],
          bottomNavigationBar: TitledBottomNavigationBar(
            currentIndex: layoutState.selectedPageIndex,
            onTap: (index) {
              BlocProvider.of<LayoutBloc>(context)
                  .add(ChangeTab(pageIndex: index));
            },
            items: <TitledNavigationBarItem>[
              TitledNavigationBarItem(
                title: 'Home',
                icon: Icons.home,
              ),
              TitledNavigationBarItem(
                title: 'Order',
                icon: Icons.shopping_basket,
              ),
              TitledNavigationBarItem(
                title: 'Product',
                icon: Icons.fastfood,
              ),
              TitledNavigationBarItem(
                title: 'Account',
                icon: Icons.person,
              ),
            ],
          ),
        );
      },
    );
  }
}
