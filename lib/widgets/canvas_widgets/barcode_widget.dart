import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart' as bw;
import '../../models/canvas_widget.dart';

class SimpleBarcodeWidget extends StatelessWidget {
  final CanvasWidget widget;

  const SimpleBarcodeWidget({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    final barcodeType = widget.properties['barcodeType'] ?? 'code128';
    final data = widget.properties['data'] ?? '1234567890';

    if (data.isEmpty) {
      return Container(
        color: Colors.grey[300],
        child: Center(
          child: Text('No Data', style: TextStyle(color: Colors.red)),
        ),
      );
    }

    return bw.BarcodeWidget(
      barcode: _getBarcodeType(barcodeType),
      data: data,
      width: widget.width,
      height: widget.height,
      drawText: true,
      style: TextStyle(fontSize: 10),
    );
  }

  bw.Barcode _getBarcodeType(String type) {
    switch (type) {
      case 'qr':
        return bw.Barcode.qrCode();
      case 'code128':
      default:
        return bw.Barcode.code128();
    }
  }
}
