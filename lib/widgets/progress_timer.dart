import 'package:flutter/material.dart';
import '../utils/constants.dart';

class ProgressTimer extends StatefulWidget {
  final int totalTimeInSeconds;
  final VoidCallback onTimeUp;

  const ProgressTimer({
    super.key,
    required this.totalTimeInSeconds,
    required this.onTimeUp,
  });

  @override
  State<ProgressTimer> createState() => _ProgressTimerState();
}

class _ProgressTimerState extends State<ProgressTimer> with TickerProviderStateMixin {
  late AnimationController _controller;
  late int _remainingSeconds;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.totalTimeInSeconds;
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.totalTimeInSeconds),
    )..addListener(() {
        setState(() {
          _remainingSeconds = (widget.totalTimeInSeconds * (1 - _controller.value)).ceil();
        });
        if (_controller.isCompleted) {
          widget.onTimeUp();
        }
      });
    _controller.forward();
  }

  String _formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final remainingSeconds = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$remainingSeconds';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _remainingSeconds < 60 ? AppColors.error : AppColors.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.timer, size: 16, color: Colors.white),
          const SizedBox(width: 4),
          Text(
            _formatTime(_remainingSeconds),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
              fontFamily: 'Nunito',
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}