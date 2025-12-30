import 'dart:convert';
import 'package:barcode_label_app/provider/design_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class JsonViewerScreen extends StatelessWidget {
  const JsonViewerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DesignProvider>();

    final templateJson = provider.getTemplateJson();
    final jsonString = JsonEncoder.withIndent('  ').convert(templateJson);

    return Scaffold(
      appBar: AppBar(
        title: Text('Template JSON'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.copy),
            tooltip: 'Copy JSON',
            onPressed: () {
              Clipboard.setData(ClipboardData(text: jsonString));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('JSON copied to clipboard!')),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.grey[900],
              padding: EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: SelectableText(
                  jsonString,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 14,
                    color: Colors.green[300],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
