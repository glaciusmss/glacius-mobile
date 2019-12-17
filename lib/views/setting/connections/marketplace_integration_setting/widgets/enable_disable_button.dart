import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:glacius_mobile/models/models.dart';
import 'package:glacius_mobile/views/setting/connections/marketplace_integration_setting/bloc/bloc.dart';
import 'package:glacius_mobile/widgets/widgets.dart';

class EnableDisableButton extends StatefulWidget {
  final List<Marketplace> integrations;
  final String marketplace;
  final String requiredFieldOnConnect;
  final String requiredFieldTitle;

  EnableDisableButton({
    @required this.integrations,
    @required this.marketplace,
    this.requiredFieldOnConnect,
    this.requiredFieldTitle,
  });

  @override
  _EnableDisableButtonState createState() => _EnableDisableButtonState();
}

class _EnableDisableButtonState extends State<EnableDisableButton> {
  bool isLoading = false;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<OAuthBloc, OAuthState>(
      listener: (context, state) {
        if (state is OAuthUpdating) {
          if (widget.marketplace == state.marketplace) {
            this.setState(() {
              isLoading = true;
            });
          }
        }
      },
      child: BlocBuilder<OAuthBloc, OAuthState>(
        builder: (context, state) {
          return RaisedButton(
            color:
                _isMarketplaceEnabled() ? Theme.of(context).errorColor : null,
            onPressed: (state is OAuthUpdating) ? null : _onPressed,
            child: buttonText(context),
          );
        },
      ),
    );
  }

  Widget buttonText(context) {
    if (isLoading == true) {
      return SizedBox(
        height: 20.0,
        width: 20.0,
        child: Spinner.configured(
          context,
          color: Colors.white,
          lineWidth: 2.0,
        ),
      );
    }

    if (_isMarketplaceEnabled()) {
      return Text(
        'Disable',
        style: TextStyle(color: Colors.white),
      );
    }

    return Text('Enable');
  }

  bool _isMarketplaceEnabled() {
    var integrations = widget.integrations
        .where((integration) => integration.name == widget.marketplace);

    return integrations.isNotEmpty;
  }

  void _onPressed() {
    final oAuthBloc = BlocProvider.of<OAuthBloc>(context);

    if (_isMarketplaceEnabled()) {
      //this is disable action
      showDialog(
        context: context,
        builder: (context) {
          return ConfirmDialog(
            content: Text(
              'You will be disconnect from ' +
                  StringUtils.capitalize(widget.marketplace),
            ),
            confirmBtnColor: Theme.of(context).errorColor,
            confirmBtnText: 'Disable',
            onConfirmPressed: () {
              oAuthBloc.add(
                DisconnectOAuth(marketplace: widget.marketplace),
              );
            },
          );
        },
      );
    } else {
      //show dialog first if there's required field
      if (widget.requiredFieldOnConnect != null) {
        showDialog(
            context: context,
            builder: (context) {
              return ConfirmDialog(
                content: FormBuilder(
                  key: _fbKey,
                  autovalidate: true,
                  child: FormBuilderTextField(
                    attribute: widget.requiredFieldOnConnect,
                    validators: [FormBuilderValidators.required()],
                    autovalidate: true,
                    decoration: InputDecoration(
                      labelText: widget.requiredFieldTitle,
                    ),
                  ),
                ),
                title: null,
                confirmBtnText: 'Connect',
                onConfirmPressed: () {
                  if (_fbKey.currentState.saveAndValidate()) {
                    oAuthBloc.add(
                      ConnectOAuth(
                        marketplace: widget.marketplace,
                        data: {
                          widget.requiredFieldOnConnect: _fbKey
                              .currentState.value[widget.requiredFieldOnConnect]
                        },
                      ),
                    );

                    return true;
                  }

                  return false;
                },
              );
            });
      } else {
        oAuthBloc.add(ConnectOAuth(marketplace: widget.marketplace));
      }
    }
  }
}
