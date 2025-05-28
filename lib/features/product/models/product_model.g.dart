// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductModelAdapter extends TypeAdapter<ProductModel> {
  @override
  final int typeId = 2;

  @override
  ProductModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductModel(
      id: fields[0] as int?,
      name: fields[1] as String?,
      image: fields[2] as String?,
      price: fields[4] as String?,
      stockQty: fields[6] as int?,
      isFavorite: fields[9] as bool?,
      cartQuantity: fields[10] as int?,
      priceBeforeDiscount: fields[3] as String?,
      createdAt: fields[7] as String?,
      updatedAt: fields[8] as String?,
    )
      ..description = fields[5] as String?
      ..quantity = fields[11] as int;
  }

  @override
  void write(BinaryWriter writer, ProductModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.priceBeforeDiscount)
      ..writeByte(4)
      ..write(obj.price)
      ..writeByte(5)
      ..write(obj.description)
      ..writeByte(6)
      ..write(obj.stockQty)
      ..writeByte(7)
      ..write(obj.createdAt)
      ..writeByte(8)
      ..write(obj.updatedAt)
      ..writeByte(9)
      ..write(obj.isFavorite)
      ..writeByte(10)
      ..write(obj.cartQuantity)
      ..writeByte(11)
      ..write(obj.quantity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
