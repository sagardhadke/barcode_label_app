import 'package:barcode_label_app/provider/design_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/canvas_widget.dart';
import 'canvas_widgets/text_widget.dart';
import 'canvas_widgets/barcode_widget.dart';

class CanvasArea extends StatelessWidget {
  const CanvasArea({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DesignProvider>(
      builder: (context, provider, child) {
        return DragTarget<String>(
          onAcceptWithDetails: (details) {
            final RenderBox renderBox = context.findRenderObject() as RenderBox;
            final localPosition = renderBox.globalToLocal(details.offset);

            provider.addWidget(details.data, localPosition);
          },

          builder: (context, candidateData, rejectedData) {
            return Container(
              width: provider.canvasWidth,
              height: provider.canvasHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: candidateData.isNotEmpty ? Colors.blue : Colors.grey,
                  width: candidateData.isNotEmpty ? 3 : 1,
                ),
              ),
              child: Stack(
                children: provider.widgets.map((widget) {
                  return _CanvasWidgetWrapper(widget: widget);
                }).toList(),
              ),
            );
          },
        );
      },
    );
  }
}

class _CanvasWidgetWrapper extends StatelessWidget {
  final CanvasWidget widget;

  const _CanvasWidgetWrapper({required this.widget});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DesignProvider>();
    final isSelected = provider.selectedWidgetId == widget.id;

    return Positioned(
      left: widget.x,
      top: widget.y,
      child: GestureDetector(
        onTap: () {
          provider.selectWidget(widget.id);
        },
        onPanUpdate: (details) {
          provider.moveWidget(widget.id, details.delta);
        },

        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            border: isSelected
                ? Border.all(color: Colors.blue, width: 2)
                : null,
          ),
          child: buildWidgetContent(context),
        ),
      ),
    );
  }

  Widget buildWidgetContent(BuildContext context) {
    switch (widget.type) {
      case 'text':
        return SimpleTextWidget(widget: widget);
      case 'barcode':
        return SimpleBarcodeWidget(widget: widget);
      default:
        return Container(color: Colors.grey);
    }
  }
}
