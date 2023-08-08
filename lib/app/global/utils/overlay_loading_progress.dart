import 'package:flutter/material.dart';
import 'package:smarter/app/global/widgets/loading_widget.dart';

class OverlayLoadingProgress {
  static OverlayEntry? _overlay;

  start(
    BuildContext context, {
    Color? barrierColor = Colors.black54,
    Widget? widget,
    Color color = Colors.black38,
    String? gifOrImagePath,
    bool barrierDismissible = true,
    double? loadingWidth,
  }) async {
    if (_overlay != null) return;
    _overlay = OverlayEntry(builder: (BuildContext context) {
      return LoadingWidget(
        color: color,
        barrierColor: barrierColor,
        widget: widget,
        gifOrImagePath: gifOrImagePath,
        barrierDismissible: barrierDismissible,
        loadingWidth: loadingWidth,
      );
    });
    Overlay.of(context).insert(_overlay!);
  }

  stop() {
    if (_overlay == null) return;
    _overlay!.remove();
    _overlay = null;
  }
}
