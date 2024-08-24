import 'package:flutter/material.dart';

class ItemData extends ChangeNotifier {
  String _title = '';
  String _description = '';

  String get title => _title;
  String get description => _description;

  void setTitle(String title) {
    _title = title;
    notifyListeners();
  }

  void setDescription(String description) {
    _description = description;
    notifyListeners();
  }
}
