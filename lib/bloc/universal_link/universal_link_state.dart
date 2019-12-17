import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class UniversalLinkState extends Equatable {
  const UniversalLinkState();

  @override
  List<Object> get props => [];
}

class UniversalLinkInitial extends UniversalLinkState {}

class UniversalLinkCheckCompleted extends UniversalLinkState {
  final bool isCameFromUniversalLink;
  final String action;
  final String path;

  const UniversalLinkCheckCompleted({
    @required this.isCameFromUniversalLink,
    this.action,
    this.path,
  });
}
