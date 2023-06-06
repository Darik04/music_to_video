
import 'package:shared_preferences/shared_preferences.dart';

const String FIRST_OPEN = 'first_open'; 

Future<bool> initFirstOpen() async{
  SharedPreferences sp = await SharedPreferences.getInstance();

  bool? first = sp.getBool(FIRST_OPEN);
  sp.setBool(FIRST_OPEN, false);
  if(first == null){
    return true;
  }
  return first;
}