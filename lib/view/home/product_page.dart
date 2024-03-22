import 'package:flutter/material.dart';
import 'package:product_app/model/product_model.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ProductPageView extends StatelessWidget {
  const ProductPageView({super.key, required this.pmodel});

  final ProductModel pmodel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Product Page'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  pmodel.name!,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 10),
                QrImageView(
                    data:
                        'name:-${pmodel.name} \n price:-${pmodel.price} \n measurment:-${pmodel.measurement}',
                    size: 300),
                const SizedBox(height: 10),
                Text(
                  'Price: ${pmodel.price}',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                const SizedBox(height: 10),
                Text(
                  'Quantity: ${pmodel.quantity}',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                const SizedBox(height: 10),
                Text(
                  'Measurement: ${pmodel.measurement}',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                const SizedBox(height: 10),
                // TextButton.icon(
                //     onPressed: () {},
                //     icon: const Icon(Icons.highlight_remove_outlined),
                //     label: const Text('Remove Product')),
              ],
            ),
          ),
        ));
  }
}
