import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {
  final String title;

  const CustomHeader({
    super.key,
    required this.title,
    
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
       
        Center(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Color(0xff07294C),
            ),
          ),
        ),
      ],
    );
  }
}
