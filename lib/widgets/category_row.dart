import 'package:flutter/material.dart';

class CategoryRow extends StatefulWidget {
  final String categoryName;
  final VoidCallback onPressed;
  const CategoryRow({
    super.key,
    required this.categoryName,
    required this.onPressed,
  });

  @override
  State<CategoryRow> createState() => _CategoryRowState();
}

class _CategoryRowState extends State<CategoryRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.categoryName,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
          onPressed: widget.onPressed,
          child: Text(
            'See all',
            style: TextStyle(color: Colors.pink),
          ),
        ),
      ],
    );
  }
}
