// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class CONTAINER extends StatelessWidget {
  final String Title;
  final double? Value;
  final IconData icon;

  const CONTAINER({
    super.key,
    required this.Title,
    required this.Value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Expanded(
        child: Container(
          padding: EdgeInsets.all(8),
          height: 120,
          decoration: BoxDecoration(
              color: Color(0xFF1E1E1E),
              border: Border.all(width: 1),
              borderRadius: BorderRadius.all(Radius.circular(12)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 5,
                  offset: Offset(2, 2),
                )
              ]),
          child: Column(
            children: [
              Icon(icon, size: 35, color: Colors.white),
              SizedBox(height: 5),
              Text(
                Title,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Orbitron',
                    color: Colors.grey[300]),
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                Value?.round().toString() ?? '',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Orbitron',
                    color: Color(0xFFF2DE9B)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
