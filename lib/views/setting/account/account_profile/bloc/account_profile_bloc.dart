import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:glacius_mobile/models/models.dart';
import 'package:glacius_mobile/repositories/repositories.dart';
import './bloc.dart';

class AccountProfileBloc
    extends Bloc<AccountProfileEvent, AccountProfileState> {
  final UserRepository userRepository;

  AccountProfileBloc({@required this.userRepository});

  @override
  AccountProfileState get initialState => InitialAccountProfileState();

  @override
  Stream<AccountProfileState> mapEventToState(
    AccountProfileEvent event,
  ) async* {
    if (event is LoadAccountProfile) {
      yield AccountProfileLoading();

      UserProfile userProfile = await this.userRepository.loadUserProfile();

      yield AccountProfileLoaded(userProfile: userProfile);
    }

    if (event is UpdateAccountProfile) {
      if (state is AccountProfileLoaded) {
        yield AccountProfileSubmitting();
        try {
          await this.userRepository.updateUserProfile(
                userProfile: event.userProfile,
              );

          yield AccountProfileSuccess(userProfile: event.userProfile);
        } catch (error) {
          yield AccountProfileFailure(
            error: error,
            userProfile: event.userProfile,
          );
        }
      }
    }
  }
}
