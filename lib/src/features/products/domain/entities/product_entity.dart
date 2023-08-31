import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable{
  final String? photo;
  final String? name;
  final String? price;

  const ProductEntity({
    this.price,
    this.name,
    this.photo,
  });

  @override
  List<Object?> get props => [photo, name, price];
}

class ListProductEntity extends Equatable{
  final List<ProductEntity?>? listProductEntity;

  const ListProductEntity({
    this.listProductEntity,
  });

  @override
  List<Object?> get props => [listProductEntity];
}
