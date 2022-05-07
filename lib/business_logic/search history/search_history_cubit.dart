// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';
part 'search_history_state.dart';

class SearchHistoryCubit extends Cubit<SearchHistoryState> {
  SearchHistoryCubit() : super(SearchHistoryInitial());

  static SearchHistoryCubit get(context) => BlocProvider.of(context);

  Database? database;
  List<Map> searchHistory = [];
  Map<int, bool> isEsist = {};

  void createDb() {
    openDatabase('searchHistory.db', version: 1, onCreate: (database, version) {
      database
          .execute(
              'CREATE TABLE searchHistory (id INTEGER PRIMARY KEY , placeID INTEGER, nameEn TEXT,nameAr TEXT, image TEXT, addressEn TEXT,addressAr TEXT)')
          .then((value) {})
          .catchError((error) {});
    }, onOpen: (database) {
      getfromDataBase(database);
    }).then((value) {
      database = value;
      emit(SearchHistoryCreatedatabaseState());
    });
  }
/////////////////////////////////////////////////////////////////////////

  getfromDataBase(database) {
    emit(SearchHistoryLoadingDatafromDatabase());
    database.rawQuery('SELECT * FROM searchHistory').then((value) {
      print(value);
      print("valueeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
      searchHistory = value;
      emit(SearchHistoryGetdatabaseState());
    });
  }
////////////////////////////////////////////////////////////////////////////////////////////

  void inserttoDatabase(
      {required int placeID,
      required String nameEn,
      required String nameAr,
      required String image,
      required String addressEn,
      required String addressAr}) async {
    database?.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO searchHistory(placeID , nameEn ,nameAr , image , addressEn ,addressAr ) VALUES("$placeID" , "$nameEn" ,"$nameAr" , "$image" , "$addressEn" ,"$addressAr" )')
          .then((value) {
        isEsist[placeID] = true;
        emit(SearchHistoryInsertdatabaseState());
        getfromDataBase(database);
        emit(SearchHistoryGetdatabaseState());
      }).catchError((error) {});
      return null;
    });
  }

  //////////////////////////////////////////////////////////////////////////////

  deleteTableContent() {
    database!.delete("searchHistory").then((value) {
      searchHistory = [];
      isEsist = {};
      emit(SearchHistoryDeleteTablecontentDatabase());
      print("table content deleted successfulllllllllly");
    }).catchError((error) {
      print("error deletind table content" + error.toString());
    });
  }
}
