import 'package:works_app/src/features/products/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
   const ProductModel({
    super.photo,
    super.name,
    super.price,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    name : json['name'] ?? '',
    photo : json['photo'] ?? '',
    price : json['price'] ?? '',
  );

}

class ListProductModel extends ListProductEntity {
  const ListProductModel({
    super.listProductEntity,
  });

  factory ListProductModel.fromJson(Map<String, dynamic> json) => ListProductModel(
    listProductEntity: json['items'] != null
          ? (json['items'] as List<dynamic>)
        .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
        .toList()
        : [],
  );
}
