import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final bool isPassword;
  final Icon? icon;
  const CustomTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.isPassword = false,
    this.icon,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isObsecureText = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        height: 42,
        child: TextField(
          style: TextStyle(fontSize: 14),
          controller: widget.controller,
          obscureText: isObsecureText && widget.isPassword,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 10),
            hint: Text(
              widget.hintText,
              style: TextStyle(color: Colors.grey.shade500),
            ),
            filled: true,
            fillColor: Colors.grey.shade200,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            ),
            prefixIcon: widget.icon,
            suffixIcon: widget.isPassword
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        isObsecureText = !isObsecureText;
                      });
                    },
                    icon: isObsecureText
                        ? Icon(
                            Icons.visibility_off,
                            color: Colors.grey.shade500,
                          )
                        : Icon(Icons.visibility, color: Colors.grey.shade500),
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
