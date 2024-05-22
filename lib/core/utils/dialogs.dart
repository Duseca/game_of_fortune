import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogService {
  //singleton instance
  static DialogService get instance => DialogService();

  void showProgressDialog({required BuildContext context}) {
    //showing progress indicator
    showDialog(
        context: context,
        barrierDismissible: false,
        // ignore: deprecated_member_use
        builder: (_) => WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Center(child: CircularProgressIndicator())));
  }

  void hideLoading() {
    Get.back();
  }

  Future<DateTime?> showDatePickerDialog(BuildContext context) {
    return showDatePicker(
        context: context,
        firstDate: DateTime(2024),
        lastDate: DateTime(2052),
        initialDate: DateTime(DateTime.now().year, DateTime.now().month));
  }
}
