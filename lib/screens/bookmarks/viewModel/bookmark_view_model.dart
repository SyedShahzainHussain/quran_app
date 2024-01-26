import 'package:flutter/material.dart';
import 'package:holy_quran_app/global/global.dart';
import 'package:holy_quran_app/model/surah/surahs.dart';

class BookMarkViewModel with ChangeNotifier {
  List<Surahs> _bookmarks = [];
  List<Surahs> get bookmarks => _bookmarks;

  BookMarkViewModel() {
    if (cache.get("bookmarks") != null) {
   
    getBookMarkFromLocalDatabase();
    }
  }

  void addBookmark(Surahs bookmark) async {
    final indexBookMark =
        _bookmarks.indexWhere((element) => element.name == bookmark.name);
    if (indexBookMark == -1) {
      _bookmarks.add(bookmark);
      addToLocalDataBase(_bookmarks);
      notifyListeners();
    } else {
      _bookmarks.removeAt(indexBookMark);
      removeToLocalDataBase(_bookmarks);
      notifyListeners();
    }
  }

  Future<List<Surahs?>?> addToLocalDataBase(List<Surahs> bookmark) async {
    try {
      await cache.put("bookmarks", bookmark);

      return bookmark;
    } catch (e) {
      throw Exception("Internal server error:");
    }
  }

  Future<List<Surahs?>?> removeToLocalDataBase(List<Surahs> bookmark) async {
    try {
      await cache.put("bookmarks", bookmark);

      return bookmark;
    } catch (e) {
      throw Exception("Internal server error:");
    }
  }

  Future getBookMarkFromLocalDatabase() async {
    try {
      List? bookmarks = await cache.get('bookmarks');
      if (bookmarks == null) {
        _bookmarks = [];
      }
      final List<Surahs?> cachedBookmarks = List.from(bookmarks!);
      _bookmarks.addAll(List.from(cachedBookmarks));
      notifyListeners();
      return cachedBookmarks;
    } catch (e) {
      print(e);
      throw Exception("Internal server error:");
    }
  }

  bool isSurahBookmarked(Surahs surahs) {
    return _bookmarks.any((element) => element.name == surahs.name);
  }
}
