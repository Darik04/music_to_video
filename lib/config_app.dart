
//APPHUD
import 'package:music_to_video/project_editor/models/editor_model.dart';

class ConfigApp{
  List<EditorModel> editors;
//APPHUD
  // SKProductWrapper? product;
  bool isSubscribe;
  bool firstOpen;

  ConfigApp({required this.editors, this.isSubscribe = false, this.firstOpen = true});
}