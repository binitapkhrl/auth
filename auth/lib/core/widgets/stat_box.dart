import 'package:flutter/material.dart';
class StatBox extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final double height;
  final Color? color;

  const StatBox({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    this.height = 120,
    this.color=Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade900.withAlpha(13),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 32,
            color: color,
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade700,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}