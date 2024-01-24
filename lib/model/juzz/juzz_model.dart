class Juzz {
  int? code;
  String? status;
  Data? data;

  Juzz({this.code, this.status, this.data});

  Juzz.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? number;
  List<Ayahs>? ayahs;
  Surahs? surahs;
  Edition? edition;

  Data({this.number, this.ayahs, this.surahs, this.edition});

  Data.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    if (json['ayahs'] != null) {
      ayahs = <Ayahs>[];
      json['ayahs'].forEach((v) {
        ayahs!.add(Ayahs.fromJson(v));
      });
    }
    surahs = json['surahs'] != null ? Surahs.fromJson(json['surahs']) : null;
    edition =
        json['edition'] != null ? Edition.fromJson(json['edition']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['number'] = number;
    if (ayahs != null) {
      data['ayahs'] = ayahs!.map((v) => v.toJson()).toList();
    }
    if (surahs != null) {
      data['surahs'] = surahs!.toJson();
    }
    if (edition != null) {
      data['edition'] = edition!.toJson();
    }
    return data;
  }
}

class Ayahs {
  int? number;
  String? text;
  Surah? surah;
  int? numberInSurah;
  int? juz;
  int? manzil;
  int? page;
  int? ruku;
  int? hizbQuarter;
  dynamic sajda;

  Ayahs(
      {this.number,
      this.text,
      this.surah,
      this.numberInSurah,
      this.juz,
      this.manzil,
      this.page,
      this.ruku,
      this.hizbQuarter,
      this.sajda});

  Ayahs.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    text = json['text'];
    surah = json['surah'] != null ? Surah.fromJson(json['surah']) : null;
    numberInSurah = json['numberInSurah'];
    juz = json['juz'];
    manzil = json['manzil'];
    page = json['page'];
    ruku = json['ruku'];
    hizbQuarter = json['hizbQuarter'];
    sajda = json['sajda'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['number'] = number;
    data['text'] = text;
    if (surah != null) {
      data['surah'] = surah!.toJson();
    }
    data['numberInSurah'] = numberInSurah;
    data['juz'] = juz;
    data['manzil'] = manzil;
    data['page'] = page;
    data['ruku'] = ruku;
    data['hizbQuarter'] = hizbQuarter;
    data['sajda'] = sajda;
    return data;
  }
}

class Surah {
  int? number;
  String? name;
  String? englishName;
  String? englishNameTranslation;
  String? revelationType;
  int? numberOfAyahs;

  Surah(
      {this.number,
      this.name,
      this.englishName,
      this.englishNameTranslation,
      this.revelationType,
      this.numberOfAyahs});

  Surah.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    name = json['name'];
    englishName = json['englishName'];
    englishNameTranslation = json['englishNameTranslation'];
    revelationType = json['revelationType'];
    numberOfAyahs = json['numberOfAyahs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['number'] = number;
    data['name'] = name;
    data['englishName'] = englishName;
    data['englishNameTranslation'] = englishNameTranslation;
    data['revelationType'] = revelationType;
    data['numberOfAyahs'] = numberOfAyahs;
    return data;
  }
}

class Surahs {
  Surah? s78;
  Surah? s79;
  Surah? s80;
  Surah? s81;
  Surah? s82;
  Surah? s83;
  Surah? s84;
  Surah? s85;
  Surah? s86;
  Surah? s87;
  Surah? s88;
  Surah? s89;
  Surah? s90;
  Surah? s91;
  Surah? s92;
  Surah? s93;
  Surah? s94;
  Surah? s95;
  Surah? s96;
  Surah? s97;
  Surah? s98;
  Surah? s99;
  Surah? s100;
  Surah? s101;
  Surah? s102;
  Surah? s103;
  Surah? s104;
  Surah? s105;
  Surah? s106;
  Surah? s107;
  Surah? s108;
  Surah? s109;
  Surah? s110;
  Surah? s111;
  Surah? s112;
  Surah? s113;
  Surah? s114;

  Surahs(
      {this.s78,
      this.s79,
      this.s80,
      this.s81,
      this.s82,
      this.s83,
      this.s84,
      this.s85,
      this.s86,
      this.s87,
      this.s88,
      this.s89,
      this.s90,
      this.s91,
      this.s92,
      this.s93,
      this.s94,
      this.s95,
      this.s96,
      this.s97,
      this.s98,
      this.s99,
      this.s100,
      this.s101,
      this.s102,
      this.s103,
      this.s104,
      this.s105,
      this.s106,
      this.s107,
      this.s108,
      this.s109,
      this.s110,
      this.s111,
      this.s112,
      this.s113,
      this.s114});

  Surahs.fromJson(Map<String, dynamic> json) {
    s78 = json['78'] != null ? Surah.fromJson(json['78']) : null;
    s79 = json['79'] != null ? Surah.fromJson(json['79']) : null;
    s80 = json['80'] != null ? Surah.fromJson(json['80']) : null;
    s81 = json['81'] != null ? Surah.fromJson(json['81']) : null;
    s82 = json['82'] != null ? Surah.fromJson(json['82']) : null;
    s83 = json['83'] != null ? Surah.fromJson(json['83']) : null;
    s84 = json['84'] != null ? Surah.fromJson(json['84']) : null;
    s85 = json['85'] != null ? Surah.fromJson(json['85']) : null;
    s86 = json['86'] != null ? Surah.fromJson(json['86']) : null;
    s87 = json['87'] != null ? Surah.fromJson(json['87']) : null;
    s88 = json['88'] != null ? Surah.fromJson(json['88']) : null;
    s89 = json['89'] != null ? Surah.fromJson(json['89']) : null;
    s90 = json['90'] != null ? Surah.fromJson(json['90']) : null;
    s91 = json['91'] != null ? Surah.fromJson(json['91']) : null;
    s92 = json['92'] != null ? Surah.fromJson(json['92']) : null;
    s93 = json['93'] != null ? Surah.fromJson(json['93']) : null;
    s94 = json['94'] != null ? Surah.fromJson(json['94']) : null;
    s95 = json['95'] != null ? Surah.fromJson(json['95']) : null;
    s96 = json['96'] != null ? Surah.fromJson(json['96']) : null;
    s97 = json['97'] != null ? Surah.fromJson(json['97']) : null;
    s98 = json['98'] != null ? Surah.fromJson(json['98']) : null;
    s99 = json['99'] != null ? Surah.fromJson(json['99']) : null;
    s100 = json['100'] != null ? Surah.fromJson(json['100']) : null;
    s101 = json['101'] != null ? Surah.fromJson(json['101']) : null;
    s102 = json['102'] != null ? Surah.fromJson(json['102']) : null;
    s103 = json['103'] != null ? Surah.fromJson(json['103']) : null;
    s104 = json['104'] != null ? Surah.fromJson(json['104']) : null;
    s105 = json['105'] != null ? Surah.fromJson(json['105']) : null;
    s106 = json['106'] != null ? Surah.fromJson(json['106']) : null;
    s107 = json['107'] != null ? Surah.fromJson(json['107']) : null;
    s108 = json['108'] != null ? Surah.fromJson(json['108']) : null;
    s109 = json['109'] != null ? Surah.fromJson(json['109']) : null;
    s110 = json['110'] != null ? Surah.fromJson(json['110']) : null;
    s111 = json['111'] != null ? Surah.fromJson(json['111']) : null;
    s112 = json['112'] != null ? Surah.fromJson(json['112']) : null;
    s113 = json['113'] != null ? Surah.fromJson(json['113']) : null;
    s114 = json['114'] != null ? Surah.fromJson(json['114']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (s78 != null) {
      data['78'] = s78!.toJson();
    }
    if (s79 != null) {
      data['79'] = s79!.toJson();
    }
    if (s80 != null) {
      data['80'] = s80!.toJson();
    }
    if (s81 != null) {
      data['81'] = s81!.toJson();
    }
    if (s82 != null) {
      data['82'] = s82!.toJson();
    }
    if (s83 != null) {
      data['83'] = s83!.toJson();
    }
    if (s84 != null) {
      data['84'] = s84!.toJson();
    }
    if (s85 != null) {
      data['85'] = s85!.toJson();
    }
    if (s86 != null) {
      data['86'] = s86!.toJson();
    }
    if (s87 != null) {
      data['87'] = s87!.toJson();
    }
    if (s88 != null) {
      data['88'] = s88!.toJson();
    }
    if (s89 != null) {
      data['89'] = s89!.toJson();
    }
    if (s90 != null) {
      data['90'] = s90!.toJson();
    }
    if (s91 != null) {
      data['91'] = s91!.toJson();
    }
    if (s92 != null) {
      data['92'] = s92!.toJson();
    }
    if (s93 != null) {
      data['93'] = s93!.toJson();
    }
    if (s94 != null) {
      data['94'] = s94!.toJson();
    }
    if (s95 != null) {
      data['95'] = s95!.toJson();
    }
    if (s96 != null) {
      data['96'] = s96!.toJson();
    }
    if (s97 != null) {
      data['97'] = s97!.toJson();
    }
    if (s98 != null) {
      data['98'] = s98!.toJson();
    }
    if (s99 != null) {
      data['99'] = s99!.toJson();
    }
    if (s100 != null) {
      data['100'] = s100!.toJson();
    }
    if (s101 != null) {
      data['101'] = s101!.toJson();
    }
    if (s102 != null) {
      data['102'] = s102!.toJson();
    }
    if (s103 != null) {
      data['103'] = s103!.toJson();
    }
    if (s104 != null) {
      data['104'] = s104!.toJson();
    }
    if (s105 != null) {
      data['105'] = s105!.toJson();
    }
    if (s106 != null) {
      data['106'] = s106!.toJson();
    }
    if (s107 != null) {
      data['107'] = s107!.toJson();
    }
    if (s108 != null) {
      data['108'] = s108!.toJson();
    }
    if (s109 != null) {
      data['109'] = s109!.toJson();
    }
    if (s110 != null) {
      data['110'] = s110!.toJson();
    }
    if (s111 != null) {
      data['111'] = s111!.toJson();
    }
    if (s112 != null) {
      data['112'] = s112!.toJson();
    }
    if (s113 != null) {
      data['113'] = s113!.toJson();
    }
    if (s114 != null) {
      data['114'] = s114!.toJson();
    }
    return data;
  }
}

class Edition {
  String? identifier;
  String? language;
  String? name;
  String? englishName;
  String? format;
  String? type;
  String? direction;

  Edition(
      {this.identifier,
      this.language,
      this.name,
      this.englishName,
      this.format,
      this.type,
      this.direction});

  Edition.fromJson(Map<String, dynamic> json) {
    identifier = json['identifier'];
    language = json['language'];
    name = json['name'];
    englishName = json['englishName'];
    format = json['format'];
    type = json['type'];
    direction = json['direction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['identifier'] = identifier;
    data['language'] = language;
    data['name'] = name;
    data['englishName'] = englishName;
    data['format'] = format;
    data['type'] = type;
    data['direction'] = direction;
    return data;
  }
}
