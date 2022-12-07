import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_signin/provider/google_sign_in.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of(context);
    // final googleSignIn=GoogleSignIn();
    // GoogleSignInAccount?_user;


//   late Database database;
//   late int userId;
//   bool isChecked = false;
//   int initAmount = 0;
//   late List<int> initAmountList;
//   bool showTransfer = false;
//   List<Map> allUsers = [];
//   List<Map> allUsersWithoutFirstItem = [];
//   List<Map> completeTasks = [];
//   List<Map> unCompleteTasks = [];
//   List<Map> favouriteTasks = [];
//   List<Map> scheduleTasks = [];
//
//   void changeCheckBox(bool checked) {
//     isChecked = checked;
//     emit(ChangeCheckBox());
//   }
//
//   void createDataBase() {
//     openDatabase(
//       'user.db',
//       version: 1,
//       onCreate: (database, version) {
//         debugPrint("database has created");
//         database
//             .execute(
//                 'CREATE TABLE UserTable (id INTEGER PRIMARY KEY,name TEXT,date TEXT,email TEXT,status TEXT,transfersAmount INTEGER,phone TEXT,balance NUMERIC)')
//             .then((value) {
//           debugPrint("Table has created");
//         }).catchError((error) {
//           debugPrint("error is : ${error.toString()}");
//         });
//       },
//       onOpen: (database) {
//         getDataFromDataBase(database);
//         debugPrint("database has opened");
//       },
//     ).then((value) {
//       database = value;
//       emit(CreateDataBase());
//     });
//   }
//
//   insertToDataBase({
//     required String name,
//     required String date,
//     required String email,
//     required int transfersAmount,
//     required String phone,
//     required double balance,
//   }) async {
//     await database.transaction((txn) {
//       return txn
//           .rawInsert(
//               'INSERT INTO UserTable(name, date, email, status, transfersAmount, phone, balance) VALUES( "$name", "$date", "$email", "all", "$transfersAmount", "$phone", "$balance")')
//           .then((value) {
//         debugPrint("$value inserted successfully");
//         debugPrint("$value [id]");
//         getDataFromDataBase(database);
//
//         emit(InsertToDataBase());
//       }).catchError((onError) {
//         debugPrint('The Error while insert is ${onError.toString()}');
//       });
//     });
//   }
//
//   void getDataFromDataBase(dataBase) {
//     allUsersWithoutFirstItem = [];
//     completeTasks = [];
//     favouriteTasks = [];
//     unCompleteTasks = [];
//     allUsers = [];
//     dataBase.rawQuery('SELECT * FROM UserTable').then((value) {
//       value.forEach((element) {
//         // debugPrint(element['status']);
//         print(element['data'].toString() + '   data');
//         if (element['id'] != 1) {
//           allUsersWithoutFirstItem.add(element);
//         }
//
//         if (element['id'] == 1) {
//           userId = element['id'];
//         }
//         // allUsersWithoutFirstItem.add(element);
//         allUsers.add(element);
//         // debugPrint('${element['id']}   this is Id');
//
//         debugPrint('$userId   this is taskId');
//         if (element['status'] == 'complete') {
//           completeTasks.add(element);
//         } else if (element['status'] == 'unComplete') {
//           unCompleteTasks.add(element);
//         } else if (element['status'] == 'favourite') {
//           favouriteTasks.add(element);
//         } else if (element['status'] == 'all') {
//           unCompleteTasks.add(element);
//         }
//         // debugPrint(element['status']);
//       });
//       emit(GetFromDataBase());
//     });
//   }
//
//   void updateData(
//       {required String name,
//       required double balance,
//       required int transfersAmount,
//       required String endTime,
//       required String phone,
//       required String date,
//       required int id}) {
//     database.rawUpdate(
//         'UPDATE UserTable SET name = ?, balance = ?, transfersAmount = ?, email = ?, phone = ? , date = ? WHERE id = ?',
//         [
//           name,
//           balance,
//           transfersAmount,
//           endTime,
//           phone,
//           date,
//           id
//         ]).then((value) {
//       showTransfer = !showTransfer;
//       debugPrint(value.toString());
//       getDataFromDataBase(database);
//       emit(UpdateUser());
//     });
//   }
//
//   void changeBalanceAmount({
//     required int balance,
//     required int id,
//     required int transferAmount,
//     required String data,
//   }) {
//     //update User balance
//     database.rawUpdate('UPDATE UserTable SET balance = ?, date = ? WHERE id = ?',
//         [balance,data, id]).then((value) {
//       //update My balance
//       database.rawUpdate('UPDATE UserTable SET balance = ?, date = ? WHERE id = ?',
//           [allUsers[0]['balance'] - transferAmount,data, userId]).then((value) {
//
//         getDataFromDataBase(database);
//         emit(UpdateUser());
//       }).catchError((error) {});
//       debugPrint(value.toString());
//       emit(UpdateUser());
//     });
//   }
//
//   void deleteData({required int id}) {
//     database
//         .rawDelete('DELETE FROM UserTable WHERE id = ?', [id]).then((value) {
//       getDataFromDataBase(database);
//       emit(DeleteFromDataBase());
//     });
//   }
//
//   void changeTransferVisibility() {
//     showTransfer = !showTransfer;
//     emit(ChangeTransferVisibility());
//   }
//
//   void plusTransferAmount() {
//     initAmount = initAmount + 1;
//
//     // initAmount=  allUsers[initAmount]['transfersAmount'];
//     // initAmount=allUsers[initAmount]['transfersAmount']+1;
//
//     // getDataFromDataBase(database);
//     emit(PlusTransferAmount());
//   }
//
//   // void getDateToScheduleTable (dataBase,{required String date})
//   // {
//   //   scheduleTasks.clear();
//   //   dataBase.rawQuery('SELECT * FROM UserTable WHERE date = ?', [date]).then((value) {
//   //     value.forEach((element) {
//   //       // debugPrint(element['date']+'abbbbbbbbbbbbbbbbbbbbb');
//   //       if(element['date']==date){
//   //         scheduleTasks.add(element);
//   //         // debugPrint(element['schedule table']);
//   //
//   //       }
//   //     });
//   //
//   //     emit(GetFromScheduleTable());
//   //   });
//   // }
//   //
//   void changeTransferAmount({required int transfersAmount, required int id}) {
//     database.rawUpdate('UPDATE UserTable SET transfersAmount = ? WHERE id = ?',
//         [transfersAmount, id]).then((value) {
//       debugPrint(value.toString());
//       getDataFromDataBase(database);
//       // getDateToScheduleTable(database, date: DateFormat.yMMMd().format(DateTime.now()));
//       emit(ChangeStatus());
//     });
//   }
// // bool isDark= false;
// // void changeDarkMode({bool? fromShared})
// // {
// //   if(fromShared!=null){
// //
// //     isDark=fromShared;
// //
// //     emit(ChangeAppMode());
// //   }
// //   else
// //   {
// //     isDark=!isDark;
// //     CashHelper.putBool(key: 'isDark', value: isDark).
// //     then((value) {
// //       debugPrint(isDark.toString());
// //       emit(ChangeAppMode());
// //     });}
// //
// // }

}
