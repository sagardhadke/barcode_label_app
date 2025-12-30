import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/canvas_widget.dart';

class DesignProvider extends ChangeNotifier {
  final List<CanvasWidget> _widgets = [];

  final double canvasWidth = 400;
  final double canvasHeight = 600;
  String? _selectedWidgetId;
  List<CanvasWidget> get widgets => _widgets;
  String? get selectedWidgetId => _selectedWidgetId;

  CanvasWidget? get selectedWidget {
    if (_selectedWidgetId == null) return null;
    try {
      return _widgets.firstWhere((w) => w.id == _selectedWidgetId);
    } catch (e) {
      return null;
    }
  }

  void addWidget(String type, Offset position) {
    final newWidget = CanvasWidget(
      id: Uuid().v4(),
      type: type,
      x: position.dx,
      y: position.dy,
      width: 120,
      height: 60,
      properties: _getDefaultProperties(type),
    );

    _widgets.add(newWidget);
    _selectedWidgetId = newWidget.id;
    notifyListeners();
  }

  Map<String, dynamic> _getDefaultProperties(String type) {
    switch (type) {
      case 'text':
        return {'content': 'Sample Text', 'fontSize': 16.0, 'color': '#000000'};
      case 'barcode':
        return {'barcodeType': 'code128', 'data': '1234567890'};
      default:
        return {};
    }
  }

  void selectWidget(String? id) {
    _selectedWidgetId = id;
    notifyListeners();
  }

  void moveWidget(String id, Offset delta) {
    final widget = _widgets.firstWhere((w) => w.id == id);
    widget.x += delta.dx;
    widget.y += delta.dy;
    notifyListeners();
  }

  void resizeWidget(String id, double width, double height) {
    final widget = _widgets.firstWhere((w) => w.id == id);
    widget.width = width;
    widget.height = height;
    notifyListeners();
  }

  void updateProperty(String id, String key, dynamic value) {
    final widget = _widgets.firstWhere((w) => w.id == id);
    widget.properties[key] = value;
    notifyListeners();
  }

  void deleteWidget(String id) {
    _widgets.removeWhere((w) => w.id == id);
    if (_selectedWidgetId == id) {
      _selectedWidgetId = null;
    }
    notifyListeners();
  }

  void clearCanvas() {
    _widgets.clear();
    _selectedWidgetId = null;
    notifyListeners();
  }

  Map<String, dynamic> getTemplateJson() {
    return {
      'canvasWidth': canvasWidth,
      'canvasHeight': canvasHeight,
      'widgets': _widgets.map((w) => w.toJson()).toList(),
    };
  }
}
