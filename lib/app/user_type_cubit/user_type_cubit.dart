import 'package:bloc/bloc.dart';

part 'user_type_state.dart';

class UserTypeCubit extends Cubit<UserType> {
  UserTypeCubit() : super(UserType.none);

  void checkTypeOfUser(UserType type) {
    emit(type);
  }
}
