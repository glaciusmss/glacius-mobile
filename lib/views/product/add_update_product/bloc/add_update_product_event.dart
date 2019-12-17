import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:glacius_mobile/models/models.dart';

abstract class AddUpdateProductEvent extends Equatable {
  const AddUpdateProductEvent();

  @override
  List<Object> get props => [];
}

class CreateProduct extends AddUpdateProductEvent {
  final Product product;

  const CreateProduct({@required this.product});

  @override
  List<Object> get props => [product];
}

class UpdateProduct extends AddUpdateProductEvent {
  final Product product;

  const UpdateProduct({@required this.product});

  @override
  List<Object> get props => [product];
}
