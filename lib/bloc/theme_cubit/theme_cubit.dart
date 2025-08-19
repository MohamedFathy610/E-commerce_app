import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  bool isDark = false;
  void toggleTheme() {
    isDark = !isDark;
    emit(isDark ? ThemeDark() : ThemeLight());
  }
  ThemeCubit() : super(ThemeInitial());
}
