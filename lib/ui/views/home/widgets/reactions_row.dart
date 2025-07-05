import 'package:flutter/material.dart';
import 'package:music_app/ui/common/app_colors.dart';

class Reaction {
  final String key;
  final String emoji;
  final int count;

  Reaction({required this.key, required this.emoji, required this.count});
}

Widget buildReactionRow(List<Reaction> reactions) {
  if (reactions.isEmpty) {
    return const Text(
      "No reactions",
      style: TextStyle(color: kcTextGrey),
      textAlign: TextAlign.right,
    );
  }

  return SizedBox(
    height: 40,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: reactions.length,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      separatorBuilder: (_, __) => const SizedBox(width: 12),
      itemBuilder: (context, index) {
        final reaction = reactions[index];

        return Container(
          width: 45,
          alignment: Alignment.centerRight,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                reaction.emoji,
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
              const SizedBox(width: 2),
              Text(
                '${reaction.count}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}
