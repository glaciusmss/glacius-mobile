import 'package:bloc/bloc.dart';
import 'package:glacius_mobile/views/layout/bloc/bloc.dart';

class LayoutBloc extends Bloc<LayoutEvent, LayoutState> {
  @override
  LayoutState get initialState => LayoutInitial();

  @override
  Stream<LayoutState> mapEventToState(LayoutEvent event) async* {
    if (event is ChangeTab) {
      yield LayoutPageChanged(selectedPageIndex: event.pageIndex);
    }
  }
}
