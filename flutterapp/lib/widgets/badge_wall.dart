import 'package:flutter/material.dart';

class BadgeWall extends StatefulWidget {
  final List<Map<String, dynamic>> badges;
  const BadgeWall({super.key, required this.badges});

  @override
  State<BadgeWall> createState() => _BadgeWallState();
}

class _BadgeWallState extends State<BadgeWall>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 500));

  @override
  void initState() {
    super.initState();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemCount: widget.badges.length,
      itemBuilder: (context, index) {
        final badge = widget.badges[index];
        return FadeTransition(
          opacity: _controller,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.emoji_events, size: 40, color: Colors.amber),
              Text(badge['name'] ?? ''),
            ],
          ),
        );
      },
    );
  }
}
