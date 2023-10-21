import 'package:flutter/foundation.dart';
import 'package:myclock/enums.dart';

class MenuInfo extends ChangeNotifier {
  // MenuType menuType;
  late MenuType menuType;
   String? title;
   String? imagesource;

  MenuInfo(this.menuType,{ this.title, this.imagesource});
}
