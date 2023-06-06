import 'package:flutter/material.dart';
import 'package:music_to_video/config_app.dart';
import 'package:music_to_video/locator.dart';
import 'package:music_to_video/project_editor/helpers/editor_cache.dart';
import 'package:music_to_video/project_editor/models/editor_model.dart';

class MainProvider extends ChangeNotifier {
  List<EditorModel> _items = [];

  List<EditorModel> get editors => _items;

  int get totalPrice => _items.length * 42;


  void fetchData() async{
    print('GETTING PROVIDER');
    _items = await getEditorModels();
    sl<ConfigApp>().editors = _items;
    notifyListeners();
  }
}