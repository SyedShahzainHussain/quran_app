import 'dart:convert';

import 'package:hive/hive.dart';

import '../surah/ayah.dart';

part 'juzz.g.dart';

@HiveType(typeId: 2)
class Juzz {
  @HiveField(0)
  int? numbers;

  @HiveField(1)
  List<Ayah?>? ayahs;
  Juzz({
    this.numbers,
    this.ayahs,
  });

  Map<String, dynamic> toMap() {
    return {
      'number': numbers,
      'ayahs': ayahs?.map((x) => x?.toMap()).toList(),
    };
  }

  factory Juzz.fromMap(Map<String, dynamic> map) {
    return Juzz(
      numbers: map['number'],
      ayahs: List<Ayah>.from(map['ayahs']?.map((x) => Ayah.fromMap(x))),
    );
  }
  String toJson() => json.encode(toMap());

  factory Juzz.fromJson(String source) => Juzz.fromMap(json.decode(source));

  @override
  String toString() => 'Juz(number: $numbers, ayahs: $ayahs)';
}
