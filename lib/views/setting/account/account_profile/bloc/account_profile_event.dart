import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:glacius_mobile/models/models.dart';

abstract class AccountProfileEvent extends Equatable {
  const AccountProfileEvent();

  @override
  List<Object> get props => [];
}

class LoadAccountProfile extends AccountProfileEvent {}

class UpdateAccountProfile extends AccountProfileEvent {
  final UserProfile userProfile;

  const UpdateAccountProfile({@required this.userProfile});

  @override
  List<Object> get props => [userProfile];
}

class ResetAccountProfileBloc extends AccountProfileEvent {}
