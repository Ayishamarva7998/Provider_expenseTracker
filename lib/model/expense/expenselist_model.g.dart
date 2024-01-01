// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expenselist_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpenseListAdapter extends TypeAdapter<ExpenseList> {
  @override
  final int typeId = 2;

  @override
  ExpenseList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExpenseList(
      description: fields[0] as String,
      amount: fields[1] as String,
      image: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ExpenseList obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.description)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
