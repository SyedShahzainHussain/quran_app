// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'juzz.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class JuzzAdapter extends TypeAdapter<Juzz> {
  @override
  final int typeId = 2;

  @override
  Juzz read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Juzz(
      numbers: fields[0] as int?,
      ayahs: (fields[1] as List?)?.cast<Ayah?>(),
    );
  }

  @override
  void write(BinaryWriter writer, Juzz obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.numbers)
      ..writeByte(1)
      ..write(obj.ayahs);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JuzzAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
