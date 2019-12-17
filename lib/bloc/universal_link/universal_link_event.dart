import 'package:equatable/equatable.dart';

abstract class UniversalLinkEvent extends Equatable {
  const UniversalLinkEvent();

  @override
  List<Object> get props => [];
}

class CheckIfAppCameFromLinks extends UniversalLinkEvent {}
