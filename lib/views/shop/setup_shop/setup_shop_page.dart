import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:glacius_mobile/views/shop/setup_shop/bloc/bloc.dart';

import 'bloc/setup_shop_bloc.dart';

class SetupShopPage extends StatefulWidget {
  @override
  _SetupShopPageState createState() => _SetupShopPageState();
}

class _SetupShopPageState extends State<SetupShopPage> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: SizedBox(
            width: double.infinity,
            child: Card(
              elevation: 5,
              child: Container(
                padding: EdgeInsets.all(20.0),
                child: FormBuilder(
                  key: _fbKey,
                  autovalidate: true,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          'Setup your new shop',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 17.5),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      _nameField(),
                      SizedBox(height: 15.0),
                      _descriptionField(),
                      SizedBox(height: 15.0),
                      SizedBox(
                        width: 120,
                        child: RaisedButton(
                          color: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          child: Text("Let's Go"),
                          onPressed: _createShop,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _createShop() {
    if (_fbKey.currentState.saveAndValidate()) {
      BlocProvider.of<SetupShopBloc>(context).add(
        CreateShop(
          name: _fbKey.currentState.value['name'],
          description: _fbKey.currentState.value['description'],
        ),
      );
    }
  }

  Widget _nameField() {
    return FormBuilderTextField(
      attribute: 'name',
      validators: [
        FormBuilderValidators.required(
          errorText: 'Shop name field cannot be empty',
        ),
      ],
      maxLines: 1,
      decoration: InputDecoration(
        hintText: 'Your new shop name',
        contentPadding: EdgeInsets.all(15.0),
        border: OutlineInputBorder(),
        labelText: 'Shop Name',
      ),
    );
  }

  Widget _descriptionField() {
    return FormBuilderTextField(
      attribute: 'description',
      validators: [
        FormBuilderValidators.required(
          errorText: 'Description field cannot be empty',
        ),
      ],
      maxLines: 3,
      decoration: InputDecoration(
        hintText: 'A wallet shop',
        contentPadding: EdgeInsets.all(15.0),
        border: OutlineInputBorder(),
        labelText: 'Description',
      ),
    );
  }
}
