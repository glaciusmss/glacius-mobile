import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:glacius_mobile/config/config.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Image.asset('assets/images/logo_min.png'),
              Text(
                'Version ' + Application.packageInfo.version,
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 30.0),
              Material(
                color: Colors.white,
                child: ListTile(
                  leading: Icon(MaterialCommunityIcons.github_box),
                  title: Text('Github repository'),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: _launchGithub,
                ),
              ),
              Expanded(
                child: Container(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.copyright),
                  Text(
                    ' Copyright 2019 Glacius MSS',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _launchGithub() async {
    const url = 'https://github.com/glaciusmss/glacius-mobile';
    await InAppBrowser.openWithSystemBrowser(url: url);
  }
}
