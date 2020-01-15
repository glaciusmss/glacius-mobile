import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:glacius_mobile/views/home/home.dart';
import 'package:glacius_mobile/views/order/order.dart';
import 'package:glacius_mobile/views/product/product.dart';
import 'package:glacius_mobile/views/profile/profile.dart';

abstract class LayoutState extends Equatable {
  final int selectedPageIndex;
  final List<Widget> pages = <Widget>[
    HomePage(),
    OrderPageBuilder(),
    ProductPageBuilder(),
    ProfilePageBuilder(),
  ];

  LayoutState({@required this.selectedPageIndex});

  @override
  List<Object> get props => [pages, selectedPageIndex];
}

class LayoutInitial extends LayoutState {
  LayoutInitial() : super(selectedPageIndex: 1);
}

class LayoutPageChanged extends LayoutState {
  LayoutPageChanged({@required selectedPageIndex})
      : super(selectedPageIndex: selectedPageIndex);
}
