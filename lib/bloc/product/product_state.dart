part of 'product_bloc.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductSuccess extends ProductState {
  final List<ProductModel> products;

  ProductSuccess(this.products);
}

class ProductFailure extends ProductState {
  final String error;

  ProductFailure(this.error);
}

class ProductDeleteLoading extends ProductState {}

class ProductAdd extends ProductState {
  final ProductModel product;

  ProductAdd(this.product);
}
