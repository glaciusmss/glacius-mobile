import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:glacius_mobile/models/models.dart';

abstract class AccountProfileState extends Equatable {
  const AccountProfileState();

  @override
  List<Object> get props => [];
}

class InitialAccountProfileState extends AccountProfileState {}

class AccountProfileLoading extends AccountProfileState {}

class AccountProfileLoaded extends AccountProfileState {
  final UserProfile userProfile;

  const AccountProfileLoaded({@required this.userProfile});

  @override
  List<Object> get props => [userProfile];
}

class AccountProfileSubmitting extends AccountProfileState {}

class AccountProfileSuccess extends AccountProfileLoaded {
  AccountProfileSuccess({@required UserProfile userProfile})
      : super(userProfile: userProfile);
}

class AccountProfileFailure extends AccountProfileLoaded {
  final Exception error;

  const AccountProfileFailure({
    @required this.error,
    @required UserProfile userProfile,
  }) : super(userProfile: userProfile);

  @override
  List<Object> get props => [...super.props, error];
}
