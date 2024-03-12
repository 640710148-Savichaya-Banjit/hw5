// POJO (Plain Old Java Object)
class Beers {
  final String? name;
  final String? price;
  final String? image;
  final int? reviews;

  Beers({
    required this.name,
    required this.price,
    required this.image,
    required this.reviews,
  });

  factory Beers.fromJson(Map<String, dynamic> json) {
    return Beers(
      name: json['name'],
      price: json['price'],
      image: json['image'],
      reviews: json['rating']['reviews'],
    );
  }
}
