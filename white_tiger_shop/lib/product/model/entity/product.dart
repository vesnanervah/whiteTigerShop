class Product {
  int productId;
  String title;
  int price;
  String? imageUrl;
  String? productDescription;
  String? category;

  Product(this.productId, this.title, this.price,
      {this.imageUrl, this.productDescription, this.category});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      json['productId'],
      json['title'],
      json['price'],
      productDescription: json['productDescription'],
      imageUrl: json['imageUrl'],
      category: json['category'],
    );
  }
}
