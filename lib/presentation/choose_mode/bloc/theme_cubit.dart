import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ThemeCubit extends HydratedCubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system); // начальное состояние

  void updateTheme(ThemeMode themeMode) => emit(themeMode);

  @override
  ThemeMode? fromJson(Map<String, dynamic> json) {
    // Десериализация состояния темы
    final String? themeString = json['theme'];
    if (themeString != null) {
      return ThemeMode.values.firstWhere((e) => e.toString() == themeString, orElse: () => ThemeMode.system);
    }
    return null; // Если нет сохраненного состояния, возвращаем null
  }

  @override
  Map<String, dynamic>? toJson(ThemeMode state) {
    // Сериализация состояния темы
    return {
      'theme': state.toString(), // Сохраняем текущее состояние темы
    };
  }
}
