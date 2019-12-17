import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class AddUpdateProductState extends Equatable {
  const AddUpdateProductState();

  @override
  List<Object> get props => [];
}

class AddUpdateProductInitial extends AddUpdateProductState {}

class AddUpdateProductSaving extends AddUpdateProductState {}

class AddUpdateProductSuccess extends AddUpdateProductState {}

class AddUpdateProductFailure extends AddUpdateProductState {
  final Exception error;

  const AddUpdateProductFailure({@required this.error});

  @override
  List<Object> get props => [error];
}
