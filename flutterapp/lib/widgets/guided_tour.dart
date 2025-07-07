import 'package:flutter/material.dart';
import '../services/guide_service.dart';

class GuidedTour extends StatefulWidget {
  final List<GuideStepModel> steps;
  final VoidCallback? onFinished;

  const GuidedTour({super.key, required this.steps, this.onFinished});

  @override
  State<GuidedTour> createState() => _GuidedTourState();
}

class _GuidedTourState extends State<GuidedTour>
    with SingleTickerProviderStateMixin {
  int _index = 0;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _controller.forward();
  }

  void _next() {
    if (_index < widget.steps.length - 1) {
      setState(() {
        _index++;
        _controller.forward(from: 0);
      });
    } else {
      widget.onFinished?.call();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final step = widget.steps[_index];
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Center(
        child: FadeTransition(
          opacity: _controller,
          child: Container(
            padding: const EdgeInsets.all(24),
            margin: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(step.title, style: Theme.of(context).textTheme.headline6),
                const SizedBox(height: 8),
                Text(step.content),
                const SizedBox(height: 16),
                ElevatedButton(onPressed: _next, child: const Text('Next')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
