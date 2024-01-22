// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ModelAdapter extends TypeAdapter<Model> {
  @override
  final int typeId = 0;

  @override
  Model read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Model(
      fields[0] as String,
      fields[1] as String,
    )
      ..kaggaEnglish = fields[2] as String?
      ..meaningKannada = fields[3] as String?
      ..meaningEnglish = fields[4] as String?
      ..vyakhyana = fields[5] as String?
      ..tatparya = fields[6] as String?;
  }

  @override
  void write(BinaryWriter writer, Model obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.kaggaKannada)
      ..writeByte(2)
      ..write(obj.kaggaEnglish)
      ..writeByte(3)
      ..write(obj.meaningKannada)
      ..writeByte(4)
      ..write(obj.meaningEnglish)
      ..writeByte(5)
      ..write(obj.vyakhyana)
      ..writeByte(6)
      ..write(obj.tatparya);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
