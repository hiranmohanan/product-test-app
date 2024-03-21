part of 'product_bloc.dart';

abstract class ProductEvent {}

class Productadd extends ProductEvent {
  final ProductModel product;

  Productadd(this.product);
}

class Productdelete extends ProductEvent {
  final ProductModel product;

  Productdelete(this.product);
}

class Productget extends ProductEvent {
  final ProductModel product;

  Productget(this.product);
}
