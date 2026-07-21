import 'package:flutter/material.dart';

class StatisticCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final int value;
  final String? subtitle;

  const StatisticCard({
    super.key,
    required this.icon,
    required this.color,
    required this.title,
    required this.value,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: color.withOpacity(.12),
              child: Icon(icon, color: color, size: 28),
            ),

            const SizedBox(width: 18),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                  ),

                  const SizedBox(height: 4),

                  TweenAnimationBuilder<int>(
                    tween: IntTween(begin: 0, end: value),
                    duration: const Duration(milliseconds: 900),
                    builder: (_, value, __) {
                      return Text(
                        value.toString(),
                        style: const TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),

                  if (subtitle != null) ...[
                    const SizedBox(height: 4),

                    Text(
                      subtitle!,
                      style: TextStyle(
                        color: Colors.green.shade700,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
