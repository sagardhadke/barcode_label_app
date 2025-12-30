// lib/screens/editor_screen.dart

import 'package:barcode_label_app/provider/design_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/widget_palette.dart';
import '../widgets/canvas_area.dart';
import '../widgets/property_panel.dart';
import 'json_viewer_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text('Label Designer'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.code, color: Colors.white),
            tooltip: 'View JSON',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => JsonViewerScreen()),
              );
            },
          ),

          IconButton(
            icon: Icon(Icons.delete_outline),
            tooltip: 'Delete Selected',
            onPressed: () {
              final provider = context.read<DesignProvider>();
              if (provider.selectedWidgetId != null) {
                provider.deleteWidget(provider.selectedWidgetId!);
              }
            },
          ),

          IconButton(
            icon: Icon(Icons.clear_all),
            tooltip: 'Clear Canvas',
            onPressed: () {
              showClearDialog(context);
            },
          ),
        ],
      ),
      body: Row(
        children: [
          WidgetPalette(),
          Expanded(
            child: Container(
              color: Colors.grey[300],
              child: Center(child: CanvasArea()),
            ),
          ),
          PropertyPanel(),
        ],
      ),
    );
  }

  void showClearDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Clear Canvas?'),
        content: Text('This will remove all widgets from the canvas.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<DesignProvider>().clearCanvas();
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }
}
