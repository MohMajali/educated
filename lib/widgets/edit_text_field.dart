import 'package:flutter/material.dart';

class EditTextFild extends StatefulWidget {
  final int maxLines;
  final String label;
  final String text;
  final ValueChanged<String> onChanged;
  TextEditingController controller = TextEditingController();

  EditTextFild({
    Key key,
    this.maxLines = 1,
    this.label,
    this.text,
    this.controller,
    this.onChanged,
  }) : super(key: key);

  @override
  _EditTextFildtState createState() => _EditTextFildtState();
}

class _EditTextFildtState extends State<EditTextFild> {
  @override
  void initState() {
    super.initState();

    widget.controller = TextEditingController(text: widget.text);
  }

  @override
  void dispose() {
    widget.controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: widget.controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            maxLines: widget.maxLines,
          ),
        ],
      );
}
