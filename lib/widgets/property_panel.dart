import 'package:barcode_label_app/provider/design_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PropertyPanel extends StatelessWidget {
  const PropertyPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DesignProvider>(
      builder: (context, provider, child) {
        final selectedWidget = provider.selectedWidget;

        return Container(
          width: 250,
          color: Colors.grey[100],
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                color: Colors.blue,
                child: const Row(
                  children: [
                    Icon(Icons.settings, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      'Properties',
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
                child: selectedWidget == null
                    ? const Center(
                        child: Text(
                          'Select a widget\nto edit properties',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                    : editAllProperties(context, provider, selectedWidget),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget editAllProperties(BuildContext context, provider, widget) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Size', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        editSizeFields(context, provider, widget),
        const SizedBox(height: 16),

        if (widget.type == 'text')
          editTextProperties(context, provider, widget),
        if (widget.type == 'barcode')
          editBarcodeProperties(context, provider, widget),
        const SizedBox(height: 16),

        ElevatedButton.icon(
          onPressed: () => provider.deleteWidget(widget.id),
          icon: const Icon(Icons.delete),
          label: const Text('Delete Widget'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget editSizeFields(BuildContext context, provider, widget) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            key: ValueKey('${widget.id}_width'),
            initialValue: widget.width.toString(),
            decoration: const InputDecoration(
              labelText: 'Width',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              provider.resizeWidget(
                widget.id,
                double.tryParse(value) ?? widget.width,
                widget.height,
              );
            },
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: TextFormField(
            key: ValueKey('${widget.id}_height'),
            initialValue: widget.height.toString(),
            decoration: const InputDecoration(
              labelText: 'Height',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,

            onChanged: (value) {
              provider.resizeWidget(
                widget.id,
                widget.width,
                double.tryParse(value) ?? widget.height,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget editTextProperties(BuildContext context, provider, widget) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Text Properties',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),

        TextFormField(
          key: ValueKey('${widget.id}_content'),
          initialValue: widget.properties['content'],
          decoration: const InputDecoration(
            labelText: 'Content',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            provider.updateProperty(widget.id, 'content', value);
          },
        ),
        const SizedBox(height: 8),

        TextFormField(
          key: ValueKey('${widget.id}_fontSize'),
          initialValue: widget.properties['fontSize'].toString(),
          decoration: const InputDecoration(
            labelText: 'Font Size',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            provider.updateProperty(
              widget.id,
              'fontSize',
              double.tryParse(value) ?? 16.0,
            );
          },
        ),
      ],
    );
  }

  Widget editBarcodeProperties(BuildContext context, provider, widget) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Barcode Properties',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),

        DropdownButtonFormField<String>(
          key: ValueKey('${widget.id}_barcodeType'),
          decoration: const InputDecoration(
            labelText: 'Barcode Type',
            border: OutlineInputBorder(),
          ),
          value: widget.properties['barcodeType'],
          items: const [
            DropdownMenuItem(value: 'code128', child: Text('Code 128')),
            DropdownMenuItem(value: 'qr', child: Text('QR Code')),
          ],
          onChanged: (value) {
            provider.updateProperty(widget.id, 'barcodeType', value);
          },
        ),
        const SizedBox(height: 8),

        TextFormField(
          key: ValueKey('${widget.id}_barcodeData'),
          initialValue: widget.properties['data'],
          decoration: const InputDecoration(
            labelText: 'Barcode Data',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            provider.updateProperty(widget.id, 'data', value);
          },
        ),
      ],
    );
  }
}
