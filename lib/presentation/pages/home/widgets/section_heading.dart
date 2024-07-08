import 'package:flutter/material.dart';

class SectionHeading extends StatelessWidget {
  const SectionHeading({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 4,
              height: 25,
              color: Colors.redAccent,
              margin: EdgeInsets.symmetric(horizontal: 10),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Text(
                title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        const IconButton(
            onPressed: null,
            icon: Icon(
              Icons.arrow_forward,
              size: 20,
            ))
      ],
    );
  }
}
