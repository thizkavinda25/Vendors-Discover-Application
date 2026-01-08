import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String labelText;
  final TextEditingController? controller;
  final bool isPassword;

  const CustomTextField({
    super.key,
    required this.labelText,
    this.controller,
    this.isPassword = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isObsecureText = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.labelText),
          SizedBox(height: 5),
          TextField(
            obscureText: isObsecureText && widget.isPassword,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade200,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10),
              ),
              suffixIcon: widget.isPassword
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          isObsecureText = !isObsecureText;
                        });
                      },
                      icon: isObsecureText
                          ? Icon(Icons.visibility, color: Colors.grey.shade600)
                          : Icon(
                              Icons.visibility_off_outlined,
                              color: Colors.grey.shade600,
                            ),
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
