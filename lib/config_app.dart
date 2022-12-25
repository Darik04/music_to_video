
import 'package:apphud/models/sk_product/sk_product_wrapper.dart';
import 'package:music_to_video/project_editor/models/editor_model.dart';

class ConfigApp{
  List<EditorModel> editors;
  SKProductWrapper? product;
  bool isSubscribe;

  ConfigApp({required this.editors, this.product, this.isSubscribe = false});
}