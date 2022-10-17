

import 'package:music_to_video/flutter_flow/flutter_flow_util.dart';
import 'package:music_to_video/project_editor/models/editor_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const EDITORS_LIST = 'editors_list';
const EDITOR_DETAIL = 'editor_detail_';

Future<void> saveEditorModel(EditorModel editorModel) async{
  SharedPreferences sp = await SharedPreferences.getInstance();
  List<String>? list = sp.getStringList(EDITORS_LIST);
  if(list != null){
    list.remove(editorModel.editorCode);
    list.add(editorModel.editorCode);
    sp.setStringList(EDITORS_LIST, list);
  }else{
    sp.setStringList(EDITORS_LIST, [editorModel.editorCode]);
  }
  sp.setString(EDITOR_DETAIL+editorModel.editorCode, jsonEncode(editorModel.toJson()));
  print('DATA SAVED: ${editorModel.toJson()}');
  
}

Future<List<EditorModel>> getEditorModels() async{
  SharedPreferences sp = await SharedPreferences.getInstance();

  List<String>? list = sp.getStringList(EDITORS_LIST);
  if(list != null){
    List<EditorModel> items = [];
    for(var id in list){
      String? editorString = sp.getString(EDITOR_DETAIL+id);
      if(editorString != null){
        items.add(EditorModel.fromJson(jsonDecode(editorString)));
      }
    }
    items = items.reversed.toList();
    return items;
  }
  return [];
}