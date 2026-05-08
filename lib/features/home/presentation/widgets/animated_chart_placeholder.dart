import 'package:flutter/material.dart';

class AnimatedChartPlaceholder extends StatefulWidget {
  const AnimatedChartPlaceholder({super.key});

  @override
  State<AnimatedChartPlaceholder> createState() => _AnimatedChartPlaceholderState();
}

class _AnimatedChartPlaceholderState extends State<AnimatedChartPlaceholder>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bars = [0.45, 0.62, 0.35, 0.78, 0.58, 0.86, 0.65];
    return SizedBox(
      height: 150,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              for (final bar in bars)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                      height: 28 + (bar * 100 * (0.7 + _controller.value * 0.3)),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withValues(alpha: 0.65),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
