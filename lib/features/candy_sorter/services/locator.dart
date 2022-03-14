import 'package:candy_sorter/features/candy_sorter/shared_prefs/shared_preferences.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;
//
Future<void> setup() async {
  print('setup');
  final _prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferenceHelper>(
      SharedPreferenceHelper(prefs: _prefs));
}
