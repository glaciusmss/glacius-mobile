import 'package:flutter/material.dart';
import 'package:glacius_mobile/utils/utils.dart';
import 'package:shimmer/shimmer.dart';

class ConnectionSkeletonLoader extends StatelessWidget {
  final int count;

  ConnectionSkeletonLoader({@required this.count});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      child: Column(
        children: Helper.buildListByCount(count).map(
          (_) {
            return ListTile(
              title: Row(
                children: <Widget>[
                  Container(
                    width: 100.0,
                    height: 16.0,
                    color: Colors.white,
                  ),
                ],
              ),
              trailing: Container(
                height: 35.0,
                width: 90.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  color: Colors.white,
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
