import 'package:flutter/material.dart';
class ChatBuble extends StatelessWidget {
  final String mesaage;
  const ChatBuble({super.key, required this.mesaage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.blue,
      ),
      child: Text(
        mesaage ,
        style: const TextStyle(fontSize: 16,color: Colors.white),
      ),
    );
  }
}
