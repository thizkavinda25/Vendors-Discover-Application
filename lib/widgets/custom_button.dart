import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final bool isOutlineBorder;
  final VoidCallback onTap;
  const CustomButton({
    super.key,
    required this.text,
    this.isOutlineBorder = false,
    required this.onTap,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(
            width: widget.isOutlineBorder ? 1 : 0,
            color: Color.fromARGB(255, 217, 42, 100),
          ),
          color: widget.isOutlineBorder
              ? Colors.white
              : const Color.fromARGB(255, 217, 42, 100),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            widget.text,
            style: TextStyle(
              color: widget.isOutlineBorder
                  ? Color.fromARGB(255, 217, 42, 100)
                  : Colors.white,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
