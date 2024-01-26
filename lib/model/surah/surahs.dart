import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:holy_quran_app/model/surah/ayah.dart';

part 'surahs.g.dart';

@HiveType(typeId: 1)
class Surahs  {
  @HiveField(0)
  final int? number;
  @HiveField(1)
  final String? name;
  @HiveField(2)
  final String? englishName;
  @HiveField(3)
  final String? englishNameTranslation;
  @HiveField(4)
  final String? revelationType;
  @HiveField(5)
  final List<Ayah?>? ayahs;
  Surahs({
    this.number,
    this.name,
    this.englishName,
    this.englishNameTranslation,
    this.revelationType,
    this.ayahs,
  });

  Map<String, dynamic> toMap() {
    return {
      'number': number,
      'name': name,
      'englishName': englishName,
      'englishNameTranslation': englishNameTranslation,
      'revelationType': revelationType,
      'ayahs': ayahs?.map((x) => x?.toJson()).toList(),
    };
  }

  factory Surahs.fromMap(Map<String, dynamic> map) {
    return Surahs(
      number: map['number'],
      name: map['name'],
      englishName: map['englishName'],
      englishNameTranslation: map['englishNameTranslation'],
      revelationType: map['revelationType'],
      ayahs: List<Ayah>.from(map['ayahs']?.map((x) => Ayah.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Surahs.fromJson(String source) => Surahs.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Surahs(number: $number, name: $name, englishName: $englishName, englishNameTranslation: $englishNameTranslation, revelationType: $revelationType, ayahs: $ayahs)';
  }


}
