part of 'app_cubit.dart';

abstract class AppState {}

class AppInitial extends AppState {}

class InitialCreateDataBase extends AppState{}

class SignInWithGoogleSuccessState extends AppState{}

class SignInWithGoogleLoadingState extends AppState{}


class SignInWithGoogleErrorState extends AppState{
  final String error;
  SignInWithGoogleErrorState(this.error);
}
// class CreateDataBase extends AppState{}
//
// class OpenDataBase extends AppState{}
// class InsertToDataBase extends AppState{}
// class GetFromDataBase extends AppState{}
// class GetFromScheduleTable extends AppState{}
// class DataBaseLoading extends AppState{}
// class ChangeStatus extends AppState{}
// class UpdateUser extends AppState{}
// class DeleteFromDataBase extends AppState{}
// class ChangeAppMode extends AppState{}
// class PlusTransferAmount extends AppState{}
// class MunTransferAmount extends AppState{}
// class ChangeTransferVisibility extends AppState{}
//
// class ChangeCheckBox extends AppState{}
