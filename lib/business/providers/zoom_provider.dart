import 'package:flutter/material.dart';

///this class handles the zoom updates throughout the application.
class ZoomProvider extends ChangeNotifier {
  ///Zoom level state objects
  Matrix4? _latestMatrix4, _persistedMatrix4;

  ///getter for current zoom level
  Matrix4? get zoomMatrix => _persistedMatrix4;

  ///to determine if temporary zoom should reset.
  bool _shouldResetTemporaryZoom = false;

  ///getter
  bool get shouldRestZoom => _shouldResetTemporaryZoom;

  ///setter
  void setShouldResetZoom(bool shouldReset) {
    _shouldResetTemporaryZoom = shouldReset;
  }

  ///zoom updates from ui.
  void setZoomMatrix(Matrix4? matrix4) {
    _latestMatrix4 = matrix4;
  }

  ///make zoom object/zooming effect identical to all the screens.
  void updateZoomLevelOnSaveClick() {
    _persistedMatrix4 = _latestMatrix4;
  }

  ///to notify widget to update the listeners.
  void updateZoomLevel() {
    notifyListeners();
  }

  ///cache removal helper
  void clearCache() {
    clearCurrentZoomState();
    clearPersistedZoom();
  }

  ///clearing currently/temporary selected zoom.
  void clearCurrentZoomState() {
    _latestMatrix4 = null;
  }

  ///clearing zoom for all the screens.
  void clearPersistedZoom() {
    _persistedMatrix4 = null;
  }
}
