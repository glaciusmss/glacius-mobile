import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glacius_mobile/bloc/bloc.dart';
import 'package:glacius_mobile/bloc/shop/shop.dart';
import 'package:glacius_mobile/models/models.dart';
import 'package:glacius_mobile/views/order/widgets/widgets.dart';

import 'bloc/bloc.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final GlobalKey<AnimatedListState> _listAnimationKey = GlobalKey();
  WebsocketBloc _websocketBloc;
  String channelName;

  @override
  void initState() {
    super.initState();

    _websocketBloc = BlocProvider.of<WebsocketBloc>(context);
    final ShopBloc shopBloc = BlocProvider.of<ShopBloc>(context);
    final OrderBloc orderBloc = BlocProvider.of<OrderBloc>(context);

    channelName = 'App.Shop.' + shopBloc.getMyShop().id.toString();

    if (orderBloc.state is! OrdersLoaded) {
      orderBloc.add(LoadOrders());
    }

    if (_websocketBloc.state is WebsocketReady) {
      _websocketBloc.add(ConnectPrivateChannel(
        channelName: channelName,
        notificationListener: (Map<String, dynamic> data) {
          BlocProvider.of<OrderBloc>(context).add(
            StoreOrder(
              order: Order.fromJson(data['order']),
              animationKey: _listAnimationKey,
            ),
          );
        },
      ));
    }
  }

  @override
  void dispose() {
    _websocketBloc.add(LeaveChannel(channelName: channelName));

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          if (state is OrdersLoaded) {
            return AnimatedList(
              key: _listAnimationKey,
              initialItemCount: state.orders.length,
              itemBuilder: (context, index, animation) {
                return SizeTransition(
                  sizeFactor: animation,
                  child: Column(
                    children: <Widget>[
                      Material(
                        color: state.updatedOrderIds
                                .contains(state.orders[index].id)
                            ? Colors.lightBlue[50]
                            : null,
                        child: ListTile(
                          title: Row(
                            children: <Widget>[
                              Text('#' + state.orders[index].id.toString()),
                              SizedBox(width: 10.0),
                              Text(state.orders[index].totalPrice.toString()),
                            ],
                          ),
                          subtitle:
                              Text(state.orders[index].createdAt.toString()),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            BlocProvider.of<OrderBloc>(context).add(
                              MarkOrderAsRead(orderId: state.orders[index].id),
                            );
                          },
                        ),
                      ),
                      Divider(height: 0.0),
                    ],
                  ),
                );
              },
            );
            return ListView.separated(
              itemCount: state.orders.length,
              separatorBuilder: (context, index) {
                return Divider(height: 0.0);
              },
              itemBuilder: (context, index) {
                return ListTile(
                  title: Row(
                    children: <Widget>[
                      Text('#' + state.orders[index].id.toString()),
                      SizedBox(width: 10.0),
                      Text(state.orders[index].totalPrice.toString()),
                    ],
                  ),
                  subtitle: Text(state.orders[index].createdAt.toString()),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {},
                );
              },
            );
          }

          return OrderSkeletonLoader();
        },
      ),
    );
  }
}
