import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart' show Color;

import '../../../../core/themes/app_colors.dart';

part 'password_state.dart';

class IconCubit extends Cubit<IconState> {
  IconCubit() : super(IconInitial());

  void updateIcon(bool isMaxLength,){
    emit(
      ColorUpdated(
        color: isMaxLength ? AppPalette.green : AppPalette.hint,)
    );
  }

  void togglePasswordVisibility(bool isVisible){
    emit(PasswordVisibilityUpdated(isVisible: !isVisible));
  }

} 