import 'package:flutter/material.dart';

class MyFilteringCards extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final Color colors;
  final double widgth;

  const MyFilteringCards({
    super.key,
    required this.label,
    required this.icon,
    required this.colors,
    required this.onTap, required this.widgth,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              SizedBox(width: widgth *.02),
              Icon(
                icon,
                color: colors,
              ),
            ],
          ),
        ),
      ),
    );
  }
}