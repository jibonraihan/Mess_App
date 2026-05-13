import 'package:flutter/material.dart';

class MemberTile extends StatelessWidget {
  final String name;
  final String role;

  const MemberTile({
    required this.name,
    required this.role,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),

      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: const Color(0xFF0F0F1B),

        borderRadius: BorderRadius.circular(20),
      ),

      child: Row(
        children: [
          CircleAvatar(
            radius: 26,

            backgroundColor: const Color(0xFF5B55A3),

            child: Text(
              name[0],

              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Text(
              name,

              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),

          Text(
            role,

            style: TextStyle(color: Colors.grey.shade400, fontSize: 15),
          ),
        ],
      ),
    );
  }
}