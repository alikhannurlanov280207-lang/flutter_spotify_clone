import 'package:flutter/material.dart';

class BasicAppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final double? height;
  final TextStyle? textStyle; // Новый параметр для текстового стиля

  const BasicAppButton({
    required this.onPressed,
    required this.title,
    this.height,
    this.textStyle, // Инициализация текстового стиля
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(height ?? 80),
      ),
      child: Text(
        title,
        style: textStyle ?? const TextStyle(fontSize: 16), // Использование переданного стиля
      ),
    );
  }
}
