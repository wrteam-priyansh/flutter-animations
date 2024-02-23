import 'package:flutter_bloc/flutter_bloc.dart';

abstract class SettingsState {}

class SettingsInitialState extends SettingsState {}

class SettingsSuccessState extends SettingsState {}

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitialState());
}
