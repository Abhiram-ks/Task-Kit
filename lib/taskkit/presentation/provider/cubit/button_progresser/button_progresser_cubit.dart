
import 'package:bloc/bloc.dart';
part 'button_progresser_state.dart';

class ButtonProgressCubit extends Cubit<ButtonProgressState> {
  ButtonProgressCubit() : super(ButtonProgressInitial());

  void startLoading(){
    emit(ButtonProgressLoading());
  }

  void stopLoading(){
    emit(ButtonProgressSuccess());
  }

  void startButtonProgressDone(){
    emit(ButtonProgressDone());
  }

  void bottomSheetStart() {
    emit(BottomSheetButtonLoading());
  }

  void bottomSheetStop() {
    emit(BottomSheetButtonSuccess());
  }

}
