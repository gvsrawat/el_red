import 'package:el_red/business/utils/el_colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

///top level method to show information using toasts.
void showToast({required final String message, bool isPositive = true}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor:
          isPositive ? ElColors.greenColor : ElColors.buttonRedColor,
      textColor: ElColors.whiteColor,
      fontSize: 16.0);
}
