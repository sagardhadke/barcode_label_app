import 'package:flutter/material.dart';

class WidgetPalette extends StatelessWidget {
  const WidgetPalette({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      color: Colors.grey[200],
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.blue,
            child: Row(
              children: [
                Icon(Icons.widgets, color: Colors.white),
                SizedBox(width: 8),
                Text(
                  'Widgets',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView(
              padding: EdgeInsets.all(8),
              children: [
                _PaletteItem(
                  icon: Icons.text_fields,
                  label: 'Text',
                  type: 'text',
                ),
                SizedBox(height: 8),
                _PaletteItem(
                  icon: Icons.qr_code,
                  label: 'Barcode',
                  type: 'barcode',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PaletteItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String type;

  const _PaletteItem({
    required this.icon,
    required this.label,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Draggable<String>(
      data: type,
      feedback: Material(
        elevation: 4,
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 40),
        ),
      ),

      childWhenDragging: Opacity(opacity: 0.5, child: itemChild()),

      child: itemChild(),
    );
  }

  Widget itemChild() {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          SizedBox(width: 12),
          Text(label, style: TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
