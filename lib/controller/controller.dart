import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:riverpod_practise/model/model.dart';
import 'package:riverpod_practise/service/service.dart';

class Controller extends ChangeNotifier {
  Controller() {
    getData();
  }

  PageController pageController = PageController(initialPage: 0);
  bool? isLoading;
  List<Data>? users = [];
  List<Data>? saved = [];

  void getData() {
    Service.fetchUser().then((value) {
      if (value != null) {
        users = value.data;
        isLoading = true;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
  }

  void addSaved(Data model) {
    saved?.add(model);
    users?.remove(model);
    notifyListeners();
  }

  void notSavedButton() {
    pageController.animateToPage(0,
        duration: Duration(milliseconds: 500), curve: Curves.easeInExpo);
  }

  void savedButton() {
    pageController.animateToPage(1,
        duration: Duration(milliseconds: 500), curve: Curves.easeInExpo);
  }

  static final controller = ChangeNotifierProvider(
    (ref) => Controller(),
  );
}
