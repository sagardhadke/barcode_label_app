class CanvasWidget {
  final String id;
  final String type;
  double x;
  double y;

  double width;
  double height;

  Map<String, dynamic> properties;

  CanvasWidget({
    required this.id,
    required this.type,
    this.x = 0,
    this.y = 0,
    this.width = 100,
    this.height = 50,
    required this.properties,
  });

  // Convert widget to JSON format
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'x': x,
      'y': y,
      'width': width,
      'height': height,
      'properties': properties,
    };
  }

  // Create widget from JSON format
  factory CanvasWidget.fromJson(Map<String, dynamic> json) {
    return CanvasWidget(
      id: json['id'],
      type: json['type'],
      x: json['x']?.toDouble() ?? 0,
      y: json['y']?.toDouble() ?? 0,
      width: json['width']?.toDouble() ?? 100,
      height: json['height']?.toDouble() ?? 50,
      properties: Map<String, dynamic>.from(json['properties'] ?? {}),
    );
  }
}
