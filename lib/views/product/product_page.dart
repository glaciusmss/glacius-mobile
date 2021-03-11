import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glacius_mobile/utils/crud_mode.dart';
import 'package:glacius_mobile/views/product/bloc/bloc.dart';
import 'package:glacius_mobile/widgets/widgets.dart';

class ProductPage extends StatefulWidget {
  final ProductBloc productBloc;

  const ProductPage({@required this.productBloc});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    super.initState();

    if (widget.productBloc.state is! ProductLoaded) {
      widget.productBloc.add(LoadProducts());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _navigateToAddUpdateProduct(CrudMode.create);
            },
          ),
        ],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoaded) {
            return ListView.separated(
              itemCount: state.products.length,
              separatorBuilder: (context, index) {
                return Divider(height: 0.0);
              },
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text('#' + state.products[index].id.toString()),
                  ),
                  title: Text(state.products[index].name),
                  subtitle: Text(
                    state.products[index].productVariants[0].price,
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    _navigateToAddUpdateProduct(
                      CrudMode.update,
                      arguments: {'product': state.products[index].clone()},
                    );
                  },
                );
              },
            );
          }
          return Spinner.withScaffold(context);
        },
      ),
    );
  }

  _navigateToAddUpdateProduct(CrudMode mode, {arguments}) async {
    final result = await Navigator.pushNamed(
      context,
      '/product' + (mode == CrudMode.create ? '/add' : '/update'),
      arguments: arguments,
    );

    if (result != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$result'),
        ),
      );
      widget.productBloc.add(LoadProducts());
    }
  }
}
