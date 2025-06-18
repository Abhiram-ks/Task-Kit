import 'package:bloc/bloc.dart';

class LandingCubit extends Cubit<int> {
  LandingCubit() : super(0);

  void switchTab(int index) => emit(index);
}