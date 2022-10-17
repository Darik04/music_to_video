import 'package:get_it/get_it.dart';
import 'package:music_to_video/config_app.dart';

final sl = GetIt.instance;

void setupInjections() {

  //Main config of system
  sl.registerLazySingleton<ConfigApp>(() => ConfigApp(editors: []));


}
