import 'package:flutter/material.dart';

class HawkAvatar extends StatefulWidget {
  final double size;

  const HawkAvatar({
    super.key,
    this.size = 180,
  });

  @override
  State<HawkAvatar> createState() => _HawkAvatarState();
}

class _HawkAvatarState extends State<HawkAvatar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size ,
      height: widget.size ,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Breathing Outer Circle
          AnimatedBuilder(
            animation: _scaleAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: Container(
                  width: widget.size * 1,
                  height: widget.size * 1,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 210, 98).withValues(alpha: 0.25),
                    shape: BoxShape.circle,
                  ),
                ),
              );
            },
          ),

          // Hawk Icon (Abstract Shape)
          ClipOval(
            child: Image.asset(
              'assets/images/Hawk.png',
              width: widget.size,
              height: widget.size,
            ),
          ),
        ],
      ),
    );
  }
}
