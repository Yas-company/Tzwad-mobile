// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 0;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      id: fields[0] as int?,
      name: fields[1] as String?,
      email: fields[2] as String?,
      phone: fields[3] as String?,
      role: fields[4] as String?,
      isVerified: fields[5] as bool?,
      businessName: fields[6] as String?,
      address: fields[8] as String?,
      licenseAttachment: fields[9] as String?,
      commercialRegisterAttachment: fields[10] as String?,
      image: fields[11] as String?,
      status: fields[12] as String?,
      fieldId: fields[13] as String?,
      createdAt: fields[14] as String?,
      updatedAt: fields[15] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.phone)
      ..writeByte(4)
      ..write(obj.role)
      ..writeByte(5)
      ..write(obj.isVerified)
      ..writeByte(6)
      ..write(obj.businessName)
      ..writeByte(8)
      ..write(obj.address)
      ..writeByte(9)
      ..write(obj.licenseAttachment)
      ..writeByte(10)
      ..write(obj.commercialRegisterAttachment)
      ..writeByte(11)
      ..write(obj.image)
      ..writeByte(12)
      ..write(obj.status)
      ..writeByte(13)
      ..write(obj.fieldId)
      ..writeByte(14)
      ..write(obj.createdAt)
      ..writeByte(15)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
