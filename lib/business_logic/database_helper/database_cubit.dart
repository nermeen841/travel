// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:travel/business_logic/database_helper/app_states.dart';

class DataBaseCubit extends Cubit<AppState> {
  DataBaseCubit() : super(AppInitial());

  static DataBaseCubit get(context) => BlocProvider.of(context);

  Database? database;
  List<Map> userData = [];

  void createDb() {
    openDatabase('user.db', version: 1, onCreate: (database, version) {
      database
          .execute(
              'CREATE TABLE user (id INTEGER PRIMARY KEY , firstName TEXT, lastName TEXT,email TEXT, image TEXT, userId TEXT,userPhone TEXT,birthDate TEXT, userAddress TEXT )')
          .then((value) {})
          .catchError((error) {});
    }, onOpen: (database) {
      getfromDataBase(database);
    }).then((value) {
      database = value;
      emit(CreatedatabaseState());
    });
  }
/////////////////////////////////////////////////////////////////////////

  getfromDataBase(database) {
    emit(LoadingDatafromDatabase());
    database.rawQuery('SELECT * FROM user').then((value) {
      print(value);
      print("valueeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
      userData = value;
      emit(GetdatabaseState());
    });
  }
////////////////////////////////////////////////////////////////////////////////////////////

  // deletaFromDB({required int id}) {
  //   database.rawDelete('DELETE FROM favourite WHERE navyId = ?', ['$id']).then(
  //       (value) {
  //     getfromDataBase(database);
  //     isfavourite["$id"] = false;
  //     emit(DeletedatabaseState());
  //   }).catchError((error) {});
  // }

////////////////////////////////////////////////////////////////////////////////////////////

  void inserttoDatabase({
    required String firstName,
    required String lastName,
    String? image,
    required String email,
    required String userId,
    String? userPhone,
    String? birthDate,
    String? userAddress,
  }) async {
    database?.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO user( firstName , lastName ,email , image , userId ,userPhone,birthDate , userAddress  ) VALUES("$firstName" , "$lastName" ,"$email" , "$image" , "$userId" ,"$userPhone", "$birthDate" , "$userAddress")')
          .then((value) {
        emit(InsertdatabaseState());
        getfromDataBase(database);
        emit(GetdatabaseState());
      }).catchError((error) {});
      return null;
    });
  }
}
////////////////////////////////////////////////////////////////////////////////////////////////////////



