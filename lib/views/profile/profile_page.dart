import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glacius_mobile/bloc/auth/auth.dart';
import 'package:glacius_mobile/config/config.dart';
import 'package:glacius_mobile/widgets/confirm_dialog.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
      ),
      body: ListView(
        children: <Widget>[
          Material(
            color: Colors.white,
            child: Column(
              children: ListTile.divideTiles(
                context: context,
                tiles: <Widget>[
                  ListTile(
                    leading: Icon(Icons.person_outline),
                    title: Text('My Account'),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      Navigator.pushNamed(context, '/settings', arguments: {
                        'title': 'My Account',
                        'settings': [
                          {
                            'Change Password':
                                '/settings/account/change_password',
                          }
                        ]
                      });
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.link),
                    title: Text('Connections'),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      Navigator.pushNamed(context, '/settings', arguments: {
                        'title': 'Connections',
                        'settings': [
                          {
                            'Marketplaces':
                                '/settings/connections/marketplaces',
                          },
                          {
                            'Notifications':
                                '/settings/connections/notifications',
                          },
                        ]
                      });
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.store),
                    title: Text('Marketplaces'),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      Navigator.pushNamed(context, '/settings', arguments: {
                        'title': 'Marketplaces',
                        'settings': [
                          {
                            'Easystore': '/settings/marketplaces/easystore',
                          },
                          {
                            'Shopify': '/settings/marketplaces/shopify',
                          },
                          {
                            'WooCommerce': '/settings/marketplaces/woocommerce',
                          },
                        ]
                      });
                    },
                  ),
                ],
              ).toList(),
            ),
          ),
          SizedBox(height: 20.0),
          Material(
            color: Colors.white,
            child: Column(
              children: ListTile.divideTiles(
                context: context,
                tiles: <Widget>[
                  ListTile(
                    leading: Icon(Icons.info),
                    title: Text('About'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(Application.packageInfo.version),
                        Icon(Icons.keyboard_arrow_right),
                      ],
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/settings/about');
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.exit_to_app,
                      color: Theme.of(context).errorColor,
                    ),
                    title: Text(
                      'Logout',
                      style: TextStyle(color: Theme.of(context).errorColor),
                    ),
                    onTap: _onLogoutPressed,
                  ),
                ],
              ).toList(),
            ),
          )
        ],
      ),
    );
  }

  void _onLogoutPressed() {
    showDialog<AlertDialog>(
        context: context,
        builder: (context) {
          return ConfirmDialog(
            title: Text('Logout'),
            content: Text(
              'You will be returned to the login screen.',
            ),
            onConfirmPressed: () {
              BlocProvider.of<AuthBloc>(context).add(LoggedOut());
            },
            confirmBtnColor: Theme.of(context).errorColor,
            confirmBtnText: 'Logout',
          );
        });
  }
}
