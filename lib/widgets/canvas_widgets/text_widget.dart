import 'package:flutter/material.dart';
import '../../models/canvas_widget.dart';

class SimpleTextWidget extends StatelessWidget {
  final CanvasWidget widget;

  const SimpleTextWidget({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    final content = widget.properties['content'] ?? 'Text';
    final fontSize = widget.properties['fontSize'] ?? 16.0;
    final colorHex = widget.properties['color'] ?? '#000000';

    return Container(
      padding: EdgeInsets.all(4),
      alignment: Alignment.center,
      child: Text(
        content,
        style: TextStyle(fontSize: fontSize, color: _hexToColor(colorHex)),
        textAlign: TextAlign.center,
      ),
    );
  }

  Color _hexToColor(String hex) {
    hex = hex.replaceAll('#', '');
    if (hex.length == 6) {
      hex = 'FF$hex';
    }
    return Color(int.parse(hex, radix: 16));
  }
}
