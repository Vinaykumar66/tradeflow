import 'package:flutter/material.dart';
import '../../../shared/models/product.dart';

class AddEditProductScreen extends StatelessWidget {
  final Product? product;
  final String? initialBarcode;
  const AddEditProductScreen({
    super.key,
    required this.product,
    required this.initialBarcode,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
            title: Text(product == null ? 'Add Product' : 'Edit Product')),
        body: const Center(child: Text('Coming soon')),
      );
}
