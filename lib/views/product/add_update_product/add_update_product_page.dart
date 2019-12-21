import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:glacius_mobile/models/models.dart';
import 'package:glacius_mobile/utils/utils.dart';
import 'package:glacius_mobile/views/product/add_update_product/add_update_product.dart';
import 'package:glacius_mobile/views/product/add_update_product/bloc/bloc.dart';
import 'package:glacius_mobile/views/product/add_update_product/widgets/widgets.dart';
import 'package:glacius_mobile/widgets/widgets.dart';

enum FormGroups { basic, pricing, inventory }

class AddUpdateProductPage extends StatefulWidget {
  final AddUpdateProductBloc addUpdateProductBloc;
  final CrudMode crudMode;
  final Product selectedProduct;

  AddUpdateProductPage({
    @required this.addUpdateProductBloc,
    @required this.crudMode,
    this.selectedProduct,
  });

  @override
  _AddUpdateProductPageState createState() => _AddUpdateProductPageState();
}

class _AddUpdateProductPageState extends State<AddUpdateProductPage> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();
  final FocusNode _priceFocusNode = FocusNode();
  final FocusNode _stockFocusNode = FocusNode();

  FormGroups _currentFocusNode;

  @override
  void initState() {
    super.initState();
    _nameFocusNode.addListener(() {
      if (_nameFocusNode.hasFocus) {
        setState(() {
          _currentFocusNode = FormGroups.basic;
        });
      }
    });

    _descriptionFocusNode.addListener(() {
      if (_descriptionFocusNode.hasFocus) {
        setState(() {
          _currentFocusNode = FormGroups.basic;
        });
      }
    });

    _priceFocusNode.addListener(() {
      if (_priceFocusNode.hasFocus) {
        setState(() {
          _currentFocusNode = FormGroups.pricing;
        });
      }
    });

    _stockFocusNode.addListener(() {
      if (_stockFocusNode.hasFocus) {
        setState(() {
          _currentFocusNode = FormGroups.inventory;
        });
      }
    });
  }

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _priceFocusNode.dispose();
    _stockFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddUpdateProductBloc, AddUpdateProductState>(
      builder: (context, state) {
        return LoadingOverlay(
          show: (state is AddUpdateProductSaving),
          child: Scaffold(
            appBar: AppBar(
              leading: CloseButton(),
              title: Text(
                widget.crudMode == CrudMode.create
                    ? 'Add Product'
                    : 'Update Product',
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.check),
                  onPressed: _onSavePressed,
                )
              ],
            ),
            body: FormBuilder(
              key: _fbKey,
              autovalidate: true,
              initialValue: {
                FormAttribute.name: widget.selectedProduct?.name,
                FormAttribute.description:
                    widget.selectedProduct?.description,
                FormAttribute.images: widget.selectedProduct?.images ?? [],
                FormAttribute.price:
                    widget.selectedProduct?.productVariants?.first?.price,
                FormAttribute.stock: widget
                    .selectedProduct?.productVariants?.first?.stock
                    ?.toString(),
              },
              child: ListView(
                padding: EdgeInsets.all(10.0),
                children: <Widget>[
                  if (state is AddUpdateProductFailure)
                    ErrorPanel(errorTxt: state.error.toString()),
                  _basicFormGroup(),
                  SizedBox(height: 10.0),
                  _imageFormGroup(),
                  SizedBox(height: 10.0),
                  _priceFormGroup(),
                  SizedBox(height: 10.0),
                  _inventoryFormGroup(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _inventoryFormGroup() {
    return Card(
      elevation: _currentFocusNode == FormGroups.inventory ? 5.0 : 1.0,
      child: Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Inventory',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            FormBuilderTextField(
              attribute: FormAttribute.stock,
              validators: [
                FormBuilderValidators.numeric(),
                FormBuilderValidators.min(0),
              ],
              focusNode: _stockFocusNode,
              keyboardType: TextInputType.number,
              maxLines: 1,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(15.0),
                border: OutlineInputBorder(),
                labelText: 'Stock',
                hintText: '0',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _priceFormGroup() {
    return Card(
      elevation: _currentFocusNode == FormGroups.pricing ? 5.0 : 1.0,
      child: Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Pricing',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            FormBuilderTextField(
              attribute: FormAttribute.price,
              validators: [
                FormBuilderValidators.required(),
                FormBuilderValidators.numeric(),
                FormBuilderValidators.min(0.01),
              ],
              focusNode: _priceFocusNode,
              keyboardType: TextInputType.number,
              maxLines: 1,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(15.0),
                border: OutlineInputBorder(),
                prefixText: 'RM',
                labelText: 'Price',
                hintText: '0.00',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _imageFormGroup() {
    return Card(
      child: Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Image',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              padding: EdgeInsets.all(10.0),
              color: Color(0xffDCDCDC),
              child: ImageField(
                imagesName: widget.selectedProduct?.images,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _basicFormGroup() {
    return Card(
      elevation: _currentFocusNode == FormGroups.basic ? 5.0 : 1.0,
      child: Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Basic Info',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            FormBuilderTextField(
              attribute: FormAttribute.name,
              validators: [FormBuilderValidators.required()],
              focusNode: _nameFocusNode,
              maxLines: 1,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(15.0),
                border: OutlineInputBorder(),
                labelText: 'Name',
                hintText: 'Brand New Wallet',
              ),
            ),
            SizedBox(height: 15.0),
            FormBuilderTextField(
              attribute: FormAttribute.description,
              validators: [FormBuilderValidators.required()],
              focusNode: _descriptionFocusNode,
              maxLines: 3,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(15.0),
                border: OutlineInputBorder(),
                labelText: 'Description',
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onSavePressed() {
    if (_fbKey.currentState.saveAndValidate()) {
      Map<String, dynamic> formValue = _fbKey.currentState.value;
      Product product = Product(
          id: widget.selectedProduct?.id,
          name: formValue[FormAttribute.name],
          description: formValue[FormAttribute.description],
          images: List<String>.from(formValue[FormAttribute.images]),
          productVariants: [
            ProductVariant(
              id: widget.selectedProduct?.productVariants?.first?.id,
              price: formValue[FormAttribute.price],
              stock: int.tryParse(
                formValue[FormAttribute.stock],
              ),
            ),
          ]);
      if (widget.crudMode == CrudMode.create) {
        widget.addUpdateProductBloc.add(CreateProduct(product: product));
      } else if (widget.crudMode == CrudMode.update) {
        widget.addUpdateProductBloc.add(UpdateProduct(product: product));
      }
    }
  }
}
