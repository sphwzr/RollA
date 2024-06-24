import 'package:flutter/material.dart';

class AnimatedDice extends AnimatedWidget {
  const AnimatedDice({super.key, required Animation<IconData> animation})
      : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<IconData>;
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Icon(
          animation.value,
          size: 100,
        ),
      ),
    );
  }
}
