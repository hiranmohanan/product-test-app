class ProductModel {
  String? name;
  String? description;
  String? image;
  double? price;
  int? quantity;

  ProductModel(
      {this.name, this.description, this.image, this.price, this.quantity});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        name: json['name'],
        description: json['description'],
        image: json['image'],
        price: json['price'],
        quantity: json['quantity']);
  }
}
