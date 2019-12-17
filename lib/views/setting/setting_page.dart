import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  final Map<String, dynamic> routeArgs;

  SettingPage({@required this.routeArgs});

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.routeArgs['title'])),
      body: Material(
        color: Colors.white,
        child: ListView.separated(
          itemCount: widget.routeArgs['settings'].length,
          itemBuilder: (context, index) {
            Map<String, String> settingItem = widget.routeArgs['settings'][index];
            String itemTitle = settingItem.keys.first;
            String itemPath = settingItem[itemTitle];

            return ListTile(
              title: Text(itemTitle),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () async {
                final result = await Navigator.pushNamed(context, itemPath);

                if (result != null) {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('$result'),
                    ),
                  );
                }
              },
            );
          },
          separatorBuilder: (context, index) {
            return Divider(height: 0.0);
          },
        ),
      ),
    );
  }
}
