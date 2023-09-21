import 'package:flutter/material.dart';

///this class handles the zoom updates throughout the application.
class ZoomProvider extends ChangeNotifier {
  ///Zoom level state objects
  Matrix4? _latestMatrix4, _lastMatrix4;

  ///getter for current zoom level
  Matrix4? get zoomMatrix => _lastMatrix4;

  ///zoom updates from ui.
  void setZoomMatrix(Matrix4? matrix4) {
    _latestMatrix4 = matrix4;
  }

  ///make zoom object/zooming effect identical to all the screens.
  void updateZoomLevelOnSaveClick() {
    _lastMatrix4 = _latestMatrix4;
  }

  ///to notify widget to update the listeners.
  void updateZoomLevel() {
    notifyListeners();
  }

  ///cache removal helper
  void clearCache() {
    _latestMatrix4 = null;
    _lastMatrix4 = null;
  }
}
