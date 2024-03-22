import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_app/bloc/product/product_bloc.dart';
import 'package:product_app/model/product_model.dart';
import 'package:product_app/widgets/widgets.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'product_page.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({super.key, required this.pmodel});

  final ProductModel pmodel;
  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    final titletheme = Theme.of(context).textTheme.titleLarge;
    final bodythem = Theme.of(context).textTheme.labelLarge;
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductPageView(pmodel: widget.pmodel),
          ),
        );
      },
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.symmetric(vertical: 10),
            width: MediaQuery.of(context).size.width * 0.9,
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 100),
                  Text(
                    widget.pmodel.name.toString(),
                    style: titletheme,
                  ),
                  const SizedBox(height: 10),
                  Table(
                    columnWidths: const {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(3),
                      2: FlexColumnWidth(1),
                    },
                    children: [
                      TableRow(
                        children: [
                          const SizedBox(),
                          Text(
                            'Product Prise',
                            style: bodythem,
                          ),
                          Text(widget.pmodel.price.toString(), style: bodythem),
                          const SizedBox(),
                        ],
                      ),
                      TableRow(
                        children: [
                          const SizedBox(),
                          Text('Product Measurment', style: bodythem),
                          Text(widget.pmodel.measurement.toString(),
                              style: bodythem),
                          const SizedBox(),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 100,
              width: 100,
              decoration: const BoxDecoration(
                border: Border.fromBorderSide(BorderSide(color: Colors.black)),
                color: Colors.white,
              ),
              child: QrImageView(
                  data:
                      'name:-${widget.pmodel.name}\n  price:-${widget.pmodel.price}\n  measurment:-${widget.pmodel.measurement}',
                  size: 100),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductAddSheet extends StatefulWidget {
  const ProductAddSheet({super.key});

  @override
  State<ProductAddSheet> createState() => _ProductAddSheetState();
}

class _ProductAddSheetState extends State<ProductAddSheet> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController measurementController = TextEditingController();
  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    priceController = TextEditingController();
    quantityController = TextEditingController();
    measurementController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    quantityController.dispose();
    measurementController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
        onClosing: () {},
        builder: (context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 30,
              ),
              child: Form(
                key: _formkey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: ListView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  shrinkWrap: true,
                  children: [
                    Center(
                      child: Text(
                        'Product details',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      decoration: inutDecoration(
                        label: 'Product Name',
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your pin';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: inutDecoration(
                        label: 'Product Price',
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your price';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: quantityController,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: inutDecoration(
                        label: 'Product Quantity',
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your quantity';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: measurementController,
                      textInputAction: TextInputAction.done,
                      keyboardType: const TextInputType.numberWithOptions(
                          decimal: true, signed: true),
                      decoration: inutDecoration(
                        label: 'Product Measurement',
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your measurment';
                        }

                        return null;
                      },
                      onFieldSubmitted: (value) {
                        if (_formkey.currentState!.validate()) {
                          context
                              .read<ProductBloc>()
                              .add(Productadd(ProductModel(
                                name: nameController.text,
                                quantity: int.parse(quantityController.text),
                                price: double.parse(priceController.text),
                                measurement: measurementController.text,
                              )));
                          // context.read<ProductBloc>().add(Productget('all'));
                          // Navigator.of(context, rootNavigator: true).pop();
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/home', (route) => false);
                        } else {
                          showsnackbar(
                              error: 'Please Fill The Fields',
                              context: context);
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            context
                                .read<ProductBloc>()
                                .add(Productadd(ProductModel(
                                  name: nameController.text,
                                  quantity: int.parse(quantityController.text),
                                  price: double.parse(priceController.text),
                                  measurement: measurementController.text,
                                )));
                            context.read<ProductBloc>().add(Productget('all'));
                            Navigator.of(context, rootNavigator: true).pop();
                          } else {
                            showsnackbar(
                                error: 'Please Fill The Fields',
                                context: context);
                          }
                        },
                        child: const Text('Add Product')),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class SerachBox extends StatefulWidget {
  const SerachBox({
    super.key,
  });

  @override
  State<SerachBox> createState() => _SerachBoxState();
}

class _SerachBoxState extends State<SerachBox> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SearchBar(
      controller: searchController,
      hintText: 'Search Product Name',
      onChanged: (value) {
        context.read<ProductBloc>().add(Productget(value));
      },
      trailing: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            context.read<ProductBloc>().add(Productget(searchController.text));
          },
        ),
      ],
    );
  }
}
