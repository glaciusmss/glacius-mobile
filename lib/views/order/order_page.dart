import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glacius_mobile/bloc/bloc.dart';
import 'package:glacius_mobile/bloc/shop/shop.dart';
import 'package:glacius_mobile/models/models.dart';
import 'package:glacius_mobile/views/order/widgets/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'bloc/bloc.dart';

class OrderPage extends StatefulWidget {
  final WebsocketBloc websocketBloc;
  final ShopBloc shopBloc;
  final OrderBloc orderBloc;
  String channelName;

  OrderPage({
    @required this.websocketBloc,
    @required this.shopBloc,
    @required this.orderBloc,
  });

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    super.initState();

    widget.channelName = 'App.Shop.' + widget.shopBloc.getMyShop().id.toString();

    if (widget.orderBloc.state is! OrdersLoaded) {
      widget.orderBloc.add(LoadOrders());
    }

    if (widget.websocketBloc.state is WebsocketReady) {
      widget.websocketBloc.add(ConnectPrivateChannel(
        channelName: widget.channelName,
        notificationListener: (Map<String, dynamic> data) {
          widget.orderBloc.add(
            StoreOrder(
              order: Order.fromJson(data['order']),
            ),
          );
        },
      ));
    }
  }

  @override
  void dispose() {
    widget.websocketBloc.add(LeaveChannel(channelName: widget.channelName));
    _refreshController.dispose();

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
            return SmartRefresher(
              controller: _refreshController,
              header: ClassicHeader(),
              onRefresh: () {
                widget.orderBloc.add(
                  RefreshOrders(refreshController: _refreshController),
                );
              },
              child: ListView.separated(
                itemCount: state.orders.length,
                separatorBuilder: (context, index) {
                  return Divider(height: 0.0);
                },
                itemBuilder: (context, index) {
                  return Material(
                    color:
                        state.updatedOrderIds.contains(state.orders[index].id)
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
                      subtitle: Text(state.orders[index].createdAt.toString()),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: () {
                        widget.orderBloc.add(
                          MarkOrderAsRead(orderId: state.orders[index].id),
                        );
                      },
                    ),
                  );
                },
              ),
            );
          }

          return OrderSkeletonLoader();
        },
      ),
    );
  }
}
