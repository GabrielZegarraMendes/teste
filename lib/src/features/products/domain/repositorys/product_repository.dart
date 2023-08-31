import 'package:works_app/src/features/products/domain/entities/product_entity.dart';

abstract class ProductRepository {
  Future<ListProductEntity?> getProducts();
}