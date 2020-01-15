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
    if (event is LoadOrders || event is RefreshOrders) {
      if (event is LoadOrders) {
        yield OrdersLoading();
      }
      PaginatedData paginatedData = await orderRepository.getOrders(
        shopId: shopBloc.getMyShop().id,
      );

      List<Order> orders = List.from(paginatedData.data)
          .map((model) => Order.fromJson(model))
          .toList();

      //add to updatedOrderIds
      List<int> updatedOrderIds = getUpdatedOrderIds(orders);

      yield OrdersLoaded(
        orders: orders,
        paginationMeta: paginatedData.meta,
        updatedOrderIds: updatedOrderIds,
      );

      //complete refresh controller
      if (event is RefreshOrders) {
        event.refreshController.refreshCompleted();
      }
    }

    if (event is LoadMoreOrders) {
      yield* _mapLoadMoreOrdersToState(event);
    }

    if (event is StoreOrder) {
      yield* _mapStoreOrderToState(event);
    }

    if (event is MarkOrderAsRead) {
      yield* _mapMarkOrderAsReadToState(event);
    }
  }

  List<int> getUpdatedOrderIds(List<Order> newOrders) {
    if (state is OrdersLoaded) {
      OrdersLoaded previousState = getPreviousState<OrdersLoaded>();
      List<int> newUpdatedOrderIds = List<int>.from(
        previousState.updatedOrderIds,
      );

      List<int> newProcessedOrderIds = newOrders
          .where(
            (newOrder) => !previousState.orders
                .map((previousOrder) => previousOrder.id)
                .contains(newOrder.id),
          )
          .map((newOrder) => newOrder.id)
          .toList();

      newProcessedOrderIds.forEach((orderId) {
        if (!newUpdatedOrderIds.contains(orderId)) {
          newUpdatedOrderIds.add(orderId);
        }
      });

      return newUpdatedOrderIds;
    }

    return [];
  }

  Stream<OrderState> _mapLoadMoreOrdersToState(LoadMoreOrders event) async* {
    if (state is OrdersLoaded) {
      OrdersLoaded previousState = getPreviousState<OrdersLoaded>();

      PaginatedData paginatedData = await orderRepository.getOrders(
        shopId: shopBloc.getMyShop().id,
        page: previousState.paginationMeta['current_page'] + 1,
      );

      List<Order> orders = List.from(paginatedData.data)
          .map((model) => Order.fromJson(model))
          .toList();

      yield OrdersLoaded(
        orders: previousState.orders..addAll(orders),
        paginationMeta: paginatedData.meta,
        updatedOrderIds: previousState.updatedOrderIds,
      );

      event.refreshController.loadComplete();
    }
  }

  Stream<OrderState> _mapStoreOrderToState(StoreOrder event) async* {
    if (state is OrdersLoaded) {
      OrdersLoaded previousState = getPreviousState<OrdersLoaded>();

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
      }

      yield OrdersLoaded(
        orders: newOrders,
        paginationMeta: previousState.paginationMeta,
        updatedOrderIds: newUpdatedOrderIds,
      );
    }
  }

  Stream<OrderState> _mapMarkOrderAsReadToState(MarkOrderAsRead event) async* {
    if (state is OrdersLoaded) {
      OrdersLoaded previousState = getPreviousState<OrdersLoaded>();

      List<int> newUpdatedOrderIds = List<int>.from(
        previousState.updatedOrderIds,
      );

      newUpdatedOrderIds.remove(event.orderId);

      yield OrdersLoaded(
        orders: previousState.orders,
        paginationMeta: previousState.paginationMeta,
        updatedOrderIds: newUpdatedOrderIds,
      );
    }
  }

  T getPreviousState<T extends OrderState>() {
    return state as T;
  }
}
