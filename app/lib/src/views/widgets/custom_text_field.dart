import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final int maxLines;
  final bool enableSuggestions;
  final bool autocorrect;
  final TextInputAction? textInputAction;
  final VoidCallback? onFieldSubmitted;
  final Function(String)? onChanged;
  final FocusNode? focusNode;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hintText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.suffixIcon,
    this.maxLines = 1,
    this.enableSuggestions = true,
    this.autocorrect = true,
    this.textInputAction,
    this.onFieldSubmitted,
    this.onChanged,
    this.focusNode,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  String? _errorText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 56,
            decoration: const BoxDecoration(
              color: Color(0xFFF7F7F7),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
              ),
            ),
            child: TextFormField(
              controller: widget.controller,
              focusNode: widget.focusNode,
              keyboardType: widget.keyboardType,
              obscureText: widget.obscureText,
              maxLines: widget.maxLines,
              enableSuggestions: widget.enableSuggestions,
              autocorrect: widget.autocorrect,
              textInputAction: widget.textInputAction ?? TextInputAction.next,
              onFieldSubmitted: (_) => widget.onFieldSubmitted?.call(),
              onChanged: widget.onChanged,
              validator: (value) {
                final error = widget.validator?.call(value);
                // Schedule setState for next frame to avoid calling setState during build
                if (error != _errorText) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (mounted) {
                      setState(() {
                        _errorText = error;
                      });
                    }
                  });
                }
                return error; // Return the actual error for form validation
              },
              style: const TextStyle(
                fontSize: 14,
                fontFamily: 'Poppins',
                color: Color(0xFF4D4D4D),
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                labelText: widget.label,
                labelStyle: const TextStyle(
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  color: Color(0xFF666666),
                  fontWeight: FontWeight.w400,
                ),
                hintText: widget.hintText,
                hintStyle: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  color: Color(0xFF4D4D4D),
                  fontWeight: FontWeight.w400,
                ),
                suffixIcon: widget.suffixIcon,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                errorStyle: const TextStyle(
                    height: 0, fontSize: 0), // Hide default error
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
          ),
          Container(
            height: 1,
            width: double.infinity,
            color: const Color(0xFF666666),
          ),
          // Reserved space for error message (always present)
          Container(
            height: 20,
            width: double.infinity,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 16, top: 4),
            child: _errorText != null && _errorText!.isNotEmpty
                ? Text(
                    _errorText!,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                      fontFamily: 'Inter',
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
