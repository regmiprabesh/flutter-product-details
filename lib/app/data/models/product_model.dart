class Product {
  final String id;
  final String title;
  final String description;
  final String brand;
  final double price;
  final double strikePrice;
  final int offPercent;
  final double ratings;
  final int totalRatings;
  final List<String> images;
  final List<ColorVariant> colorVariants;
  final String ingredient;
  final String howToUse;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.brand,
    required this.price,
    required this.strikePrice,
    required this.offPercent,
    required this.ratings,
    required this.totalRatings,
    required this.images,
    required this.colorVariants,
    required this.ingredient,
    required this.howToUse,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      brand: json['brand']['name'],
      price: json['price'].toDouble(),
      strikePrice: json['strikePrice'].toDouble(),
      offPercent: json['offPercent'],
      ratings: json['ratings'].toDouble(),
      totalRatings: json['totalRatings'],
      images: List<String>.from(json['images']),
      colorVariants: (json['colorVariants'] as List)
          .map((v) => ColorVariant.fromJson(v))
          .toList(),
      ingredient: json['ingredient'],
      howToUse: json['howToUse'],
    );
  }
}

class ColorVariant {
  final String id;
  final String name;
  final String colorValue;
  final String productCode;
  final double price;
  final double strikePrice;
  final int offPercent;
  final int minOrder;
  final int maxOrder;

  ColorVariant(
      {required this.id,
      required this.name,
      required this.colorValue,
      required this.productCode,
      required this.price,
      required this.strikePrice,
      required this.offPercent,
      required this.minOrder,
      required this.maxOrder});

  factory ColorVariant.fromJson(Map<String, dynamic> json) {
    return ColorVariant(
        id: json['color']['_id'],
        name: json['color']['name'],
        colorValue: json['color']['colorValue'][0],
        productCode: json['productCode'],
        price: json['price'].toDouble(),
        strikePrice: json['strikePrice'].toDouble(),
        offPercent: json['offPercent'],
        minOrder: json['minOrder'],
        maxOrder: json['maxOrder']);
  }
}
