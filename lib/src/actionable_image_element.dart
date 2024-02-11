import 'dart:ui_web' as ui;
import 'package:flutter/widgets.dart';
import 'package:universal_html/html.dart' as html;

class ActionableImageElement extends StatefulWidget {
  final String url;
  final double? width;
  final double? height;
  final BoxFit? fit;
  const ActionableImageElement({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.fit,
  });

  @override
  State<ActionableImageElement> createState() => _ActionableImageElementState();
}

class _ActionableImageElementState extends State<ActionableImageElement> {
  @override
  void initState() {
    super.initState();
    ui.platformViewRegistry.registerViewFactory(
      widget.url,
      (int viewId) {
        final element = html.ImageElement()
          ..src = widget.url
          ..style.width = widget.width != null ? '${widget.width}px' : '100%'
          ..style.height = widget.height != null ? '${widget.height}px' : '100%'
          ..style.objectFit = boxFitToObjectFit(widget.fit);
        return element;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: HtmlElementView(viewType: widget.url),
    );
  }
}

String boxFitToObjectFit(BoxFit? fit) => switch (fit) {
      BoxFit.contain => 'contain',
      BoxFit.cover => 'cover',
      BoxFit.fill => 'fill',
      BoxFit.none => 'none',
      BoxFit.scaleDown => 'scale-down',
      BoxFit.fitHeight => 'fill',
      BoxFit.fitWidth => 'fill',
      null => 'cover',
    };
