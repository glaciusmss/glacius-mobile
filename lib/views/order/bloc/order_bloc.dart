import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:glacius_mobile/bloc/bloc.dart';
import 'package:glacius_mobile/models/models.dart';
import 'package:glacius_mobile/repositories/repositories.dart';
import 'package:glacius_mobile/views/order/bloc/bloc.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository orderRepository;
  final ShopBloc shopBloc;

  OrderBloc({@required this.orderRepository, @required this.shopBloc});

  @override
  OrderState get initialState => OrderInitial();

  @override
  Stream<OrderState> mapEventToState(OrderEvent event) async* {
    if (event is LoadOrders) {
      yield OrdersLoading();
      List<Order> orders = await orderRepository.getOrders(
        shopId: shopBloc.getMyShop().id,
      );
      yield OrdersLoaded(orders: orders.reversed.toList());
    }

    if (event is StoreOrder) {
      if (state is OrdersLoaded) {
        OrdersLoaded previousState = (state as OrdersLoaded);
        
        List<Order> previousOrders = previousState.orders;
        List<int> newUpdatedOrderIds = List<int>.from(
          previousState.updatedOrderIds,
        );
        bool isOrderFound = false;

        List<Order> newOrders = previousOrders.map((Order order) {
          if (order.id == event.order.id) {
            isOrderFound = true;
            return event.order;
          }
          return order;
        }).toList();

        if (!isOrderFound) {
          newUpdatedOrderIds.add(event.order.id);
          newOrders.insert(0, event.order);
          //animate the item added if key present
          event.animationKey?.currentState?.insertItem(0);
        }

        yield OrdersLoaded(
          orders: newOrders,
          updatedOrderIds: newUpdatedOrderIds,
        );
      }
    }

    if (event is MarkOrderAsRead) {
      if (state is OrdersLoaded) {
        OrdersLoaded previousState = (state as OrdersLoaded);

        List<int> newUpdatedOrderIds = List<int>.from(
          previousState.updatedOrderIds,
        );

        newUpdatedOrderIds.remove(event.orderId);

        yield OrdersLoaded(
          orders: previousState.orders,
          updatedOrderIds: newUpdatedOrderIds,
        );
      }
    }
  }
}
