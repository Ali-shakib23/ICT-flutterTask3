class ProductData{
  final String name;
  final String detail;
  final int price;
  final String image;

  ProductData({
    required this.name,
    required this.detail,
    required this.price,
    required this.image});

  factory ProductData.fromJson(Map <String, dynamic> json){
    return ProductData(
      name: json['title'],
      detail: json['description'],
      price: json['price'],
      image:json['thumbnail'],
    );
  }
}