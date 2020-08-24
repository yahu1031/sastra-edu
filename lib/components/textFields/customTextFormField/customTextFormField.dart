import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController textEditingController;
  final bool autofocus;
  final bool isPassword;
  final String hint;
  final bool onDigit;
  final bool isEmail;
  final Function onPressed;
  final FormFieldValidator<String> validator;
  final int textLimit;
  final bool onOtp;
  final TextInputAction textInputAction;
  final Widget suffixIcon;
  final FocusNode focusNode;
  CustomTextField({
    @required this.onChanged,
    @required this.isPassword,
    this.suffixIcon,
    this.focusNode,
    this.validator,
    this.onPressed,
    this.textEditingController,
    this.autofocus = false,
    this.hint,
    this.onDigit = false,
    this.isEmail = false,
    this.textLimit,
    this.onOtp = false,
    this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Material(
        borderRadius: BorderRadius.circular(7),
        child: Container(
          padding: EdgeInsets.only(left: 5.0),
          decoration: BoxDecoration(
            color: Colors.grey[100].withOpacity(1),
            borderRadius: BorderRadius.circular(7),
          ),
          child: TextFormField(
            validator: validator,
            focusNode: focusNode,
            autofocus: autofocus,
            textInputAction: textInputAction,
            controller: textEditingController,
            textAlign: TextAlign.left,
            onChanged: onChanged,
            obscureText: isPassword,
            style: GoogleFonts.lexendDeca(
              fontSize: onOtp ? 25 : 18,
              fontWeight: onOtp ? FontWeight.bold : FontWeight.normal,
            ),
            decoration: InputDecoration(
              contentPadding: onOtp ? EdgeInsets.all(5) : EdgeInsets.all(15),
              hintText: hint,
              border: InputBorder.none,
              suffixIcon: suffixIcon,
            ),
            keyboardType: isEmail
                ? TextInputType.emailAddress
                : onDigit
                    ? TextInputType.number
                    : isPassword
                        ? TextInputType.text
                        : TextInputType.visiblePassword,
            inputFormatters: <TextInputFormatter>[
              LengthLimitingTextInputFormatter(textLimit),
              onDigit
                  ? FilteringTextInputFormatter.digitsOnly
                  : FilteringTextInputFormatter.deny(
                      RegExp("[/\\\\]"),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
