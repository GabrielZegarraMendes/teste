import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:works_app/src/features/products/data/models/product_model.dart';
import 'package:works_app/src/features/products/data/repositorys/product_repository.dart';
import 'package:works_app/src/features/products/domain/entities/product_entity.dart';

class ProductDatasourceImpl implements ProductRepositoryImpl {
  @override
  Future<ListProductEntity?> getProducts() async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    try {
      ListProductModel? result;
      await db.collection("/commerce").doc('1').get().then(
            (value) => result = ListProductModel.fromJson(value.data()!),
          );
      return result;
    } catch (e) {
      print('Erro de login: $e');
    }
    return null;
  }
}
