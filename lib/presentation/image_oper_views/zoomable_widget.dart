import 'package:el_red/business/providers/zoom_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

///common zoomable widget
class ZoomWidget extends StatefulWidget {
  const ZoomWidget({super.key, required this.child, required this.isZoomAble});

  final bool isZoomAble;
  final Widget child;

  @override
  State<ZoomWidget> createState() => _ZoomWidgetState();
}

class _ZoomWidgetState extends State<ZoomWidget>
    with SingleTickerProviderStateMixin {
  ///to get and set zoom updates to the widget.
  late TransformationController _transformationController;

  ///[ZoomProvider] for handling the state of current zoom levels.
  late ZoomProvider _zoomProvider;

  @override
  void initState() {
    _zoomProvider = Provider.of<ZoomProvider>(context, listen: false);
    _transformationController = TransformationController(
        _zoomProvider.zoomMatrix ?? Matrix4.identity());
    _zoomProvider.addListener(_updateZoomLevel);
    super.initState();
  }

  @override
  void dispose() {
    _zoomProvider.removeListener(_updateZoomLevel);
    super.dispose();
  }

  ///this method updates the zoom level which it receives from zoom provider that user saves, for all the screens.
  void _updateZoomLevel() {
    if (mounted &&
        (_zoomProvider.shouldRestZoom || _zoomProvider.zoomMatrix != null)) {
      setState(() {
        var matrix4Ins = Matrix4.identity();
        if (_zoomProvider.shouldRestZoom) {
          _zoomProvider.setZoomMatrix(matrix4Ins);
        }
        _transformationController.value = _zoomProvider.shouldRestZoom
            ? matrix4Ins
            : _zoomProvider.zoomMatrix!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
        minScale: 1,
        maxScale: 4,
        panEnabled: widget.isZoomAble,
        scaleEnabled: widget.isZoomAble,
        trackpadScrollCausesScale: widget.isZoomAble,
        transformationController: _transformationController,
        onInteractionEnd: (details) {
          ///saving last zoom level.
          _zoomProvider.setZoomMatrix(_transformationController.value);
        },
        child: widget.child);
  }
}
