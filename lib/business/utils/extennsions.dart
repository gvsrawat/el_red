import 'package:flutter/cupertino.dart';

/// extension on num for accessing sized boxes easily.
extension box on num {
  SizedBox get heightBox => SizedBox(height: toDouble());

  SizedBox get widthBox => SizedBox(width: toDouble());
}
