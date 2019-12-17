import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class LayoutEvent extends Equatable {
  const LayoutEvent();

  @override
  List<Object> get props => [];
}

class ChangeTab extends LayoutEvent {
  final int pageIndex;

  const ChangeTab({@required this.pageIndex});

  @override
  List<Object> get props => [pageIndex];
}
