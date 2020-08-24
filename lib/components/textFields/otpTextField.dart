import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OTPTextField extends StatefulWidget {
  final int length;
  final double fieldWidth;
  final TextInputType keyboardType;
  final TextStyle style;
  final MainAxisAlignment textFieldAlignment;
  final bool obscureText;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onCompleted;
  OTPTextField(
      {Key key,
      this.length = 6,
      this.fieldWidth = 50,
      this.keyboardType = TextInputType.text,
      this.style = const TextStyle(),
      this.textFieldAlignment = MainAxisAlignment.spaceBetween,
      this.obscureText = false,
      this.onChanged,
      this.onCompleted})
      : assert(length > 1);

  @override
  _OTPTextFieldState createState() => _OTPTextFieldState();
}

class _OTPTextFieldState extends State<OTPTextField> {
  List<FocusNode> _focusNodes;
  List<Widget> _textFields;
  List<String> _pin;

  @override
  void initState() {
    super.initState();
    _focusNodes = List<FocusNode>(widget.length);

    _pin = List.generate(widget.length, (int i) {
      return '';
    });
    _textFields = List.generate(widget.length, (int i) {
      return buildTextField(context, i);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: widget.textFieldAlignment,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _textFields,
      ),
    );
  }

  /// This function Build and returns individual TextField item.
  ///
  /// *** Requires a build context
  /// *** Requires Int position of the field
  Widget buildTextField(BuildContext context, int i) {
    if (_focusNodes[i] == null) _focusNodes[i] = new FocusNode();

    return Container(
      width: widget.fieldWidth,
      height: widget.fieldWidth,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(7),
        border: Border.all(
          color: Colors.lightBlueAccent,
          width: 3,
        ),
      ),
      child: Center(
        child: TextField(
          keyboardType: widget.keyboardType,
          textAlign: TextAlign.center,
          maxLength: 1,
          style: GoogleFonts.lexendDeca(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          focusNode: _focusNodes[i],
          obscureText: widget.obscureText,
          decoration: InputDecoration(
            counterText: '',
            border: InputBorder.none,
          ),
          onChanged: (String str) {
            /// Check if the current value at this position is empty
            /// If it is move focus to previous text field.
            if (str.isEmpty) {
              if (i == 0) return;
              _focusNodes[i].unfocus();
              _focusNodes[i - 1].requestFocus();
            }

            /// Update the current pin
            setState(() {
              _pin[i] = str;
            });

            /// Remove focus
            if (str.isNotEmpty) _focusNodes[i].unfocus();

            /// Set focus to the next field if available
            if (i + 1 != widget.length && str.isNotEmpty)
              FocusScope.of(context).requestFocus(_focusNodes[i + 1]);

            String currentPin = "";
            _pin.forEach((String value) {
              currentPin += value;
            });

            /// if there are no null values that means otp is completed
            /// Call the `onCompleted` callback function provided
            if (!_pin.contains(null) &&
                !_pin.contains('') &&
                currentPin.length == widget.length) {
              widget.onCompleted(currentPin);
            }

            /// Call the `onChanged` callback function
            widget.onChanged(currentPin);
          },
        ),
      ),
    );
  }
}
