import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Utils {

  static void flushBarErrorMessage(BuildContext context, String message) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          message: message,
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
          forwardAnimationCurve: Curves.decelerate,
          reverseAnimationCurve: Curves.easeInOut,
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          borderRadius: BorderRadius.circular(10),
        )..show(context)
    );
  }

  static void fieldFocusChange(BuildContext context, FocusNode current, FocusNode next) {
    current.unfocus();
    FocusScope.of(context).requestFocus(next);
  }

  static double setAverageRating(List<int> ratings) {
    var avgRating = 0;
    for (int i = 0; i < ratings.length; i++) {
      avgRating = avgRating + ratings[i];
    }
    return double.parse((avgRating / ratings.length).toStringAsFixed(1));
  }

}