import 'package:flutter/material.dart';

class ChatHeaderCard extends StatelessWidget {
  const ChatHeaderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: const Color(0xFF171727),

        borderRadius:
            BorderRadius.circular(24),
      ),

      child: const Row(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor:
                Color(0xFF5B55A3),

            child: Icon(
              Icons.group,
              color: Colors.white,
            ),
          ),

          SizedBox(width: 16),

          Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              Text(
                'Mess Group Chat',

                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              SizedBox(height: 4),

              Text(
                'Chat with members',

                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}