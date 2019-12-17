import 'package:flutter/material.dart';
import 'package:glacius_mobile/utils/utils.dart';
import 'package:shimmer/shimmer.dart';

class OrderSkeletonLoader extends StatelessWidget {
  final int count;

  OrderSkeletonLoader({this.count = 10});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Shimmer.fromColors(
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[100],
          child: Column(
            children: Helper.buildListByCount(count).map(
              (_) {
                return ListTile(
                  title: Row(
                    children: <Widget>[
                      Container(
                        width: 40.0,
                        height: 16.0,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10.0),
                      Container(
                        width: 80.0,
                        height: 16.0,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  subtitle: Row(
                    children: <Widget>[
                      Container(
                        width: 200.0,
                        height: 16.0,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  trailing: Container(
                    width: 14.0,
                    height: 16.0,
                    color: Colors.white,
                  ),
                );
              },
            ).toList(),
          ),
        ),
      ],
    );
  }
}
