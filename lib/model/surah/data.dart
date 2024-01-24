import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:holy_quran_app/model/surah/surahs.dart';

part 'data.g.dart';

@HiveType(typeId: 3)
class Data {
  @HiveField(0)
   List<Surahs?>? surahs;
  Data({
    this.surahs,
  });

  Map<String, dynamic> toMap() {
    return {
      'surahs': surahs?.map((x) => x?.toJson()).toList(),
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      surahs: List<Surahs>.from(map['surahs']?.map((x) => Surahs.fromMap(x))),
    );
  }
  String toJson() => json.encode(toMap());

  factory Data.fromJson(String source) => Data.fromMap(json.decode(source));

}
