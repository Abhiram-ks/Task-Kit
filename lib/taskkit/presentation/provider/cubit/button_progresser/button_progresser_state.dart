part of 'button_progresser_cubit.dart';

abstract class ButtonProgressState{}

final class ButtonProgressInitial extends ButtonProgressState {}
final class ButtonProgressLoading extends ButtonProgressState {}
final class ButtonProgressSuccess  extends ButtonProgressState {}
final class ButtonProgressDone extends ButtonProgressState {}


final class BottomSheetButtonLoading extends ButtonProgressState {}
final class BottomSheetButtonSuccess extends ButtonProgressState {}
