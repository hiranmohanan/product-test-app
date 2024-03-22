class ProductModel {
  int? id;
  String? name;
  String? description;
  String? image;
  double? price;
  int? quantity;
  String? measurement;

  ProductModel({
    this.id,
    this.name,
    this.description,
    this.image,
    this.price,
    this.quantity,
    this.measurement,
  });

  factory ProductModel.fromJson(Map<dynamic, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      price: json['price'],
      quantity: json['quantity'],
      measurement: json['measurement'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'price': price,
      'quantity': quantity,
      'measurement': measurement,
    };
  }

  factory ProductModel.fromMap(Map<dynamic, dynamic> map) {
    return ProductModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      image: map['image'],
      price: map['price'],
      quantity: map['quantity'],
      measurement: map['measurement'],
    );
  }

  factory ProductModel.fromFirestore(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      image: map['image'],
      price: map['price'],
      quantity: map['quantity'],
      measurement: map['measurement'],
    );
  }
  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'price': price,
      'quantity': quantity,
      'measurement': measurement,
    };
  }
}
