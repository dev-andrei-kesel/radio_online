import 'package:audio_service/audio_service.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math' as math;

class WavyTextWidget extends StatefulWidget {
  final AudioHandler? audioHandler;
  final String text;
  final TextAlign textAlign;
  final TextStyle? style;
  final int? maxLines;
  final TextOverflow textOverflow;

  const WavyTextWidget(
      {super.key,
      required this.text,
      required this.textAlign,
      this.style,
      this.maxLines,
      required this.textOverflow,
      this.audioHandler});

  @override
  State<WavyTextWidget> createState() => _WavyTextState();
}

class _WavyTextState extends State<WavyTextWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _animations;
  double _offset = 0.0;

  @override
  void initState() {
    _initAnimation();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.text.length,
        (index) => AnimatedBuilder(
          animation: _animations[index],
          builder: (context, child) {
            double x = _animations[index].value + _offset + index * 1.0;
            return Transform.translate(
              offset: Offset(
                20 * math.sin(x),
                10 * math.cos(x),
              ),
              child: child,
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              textAlign: widget.textAlign,
              overflow: widget.textOverflow,
              maxLines: widget.maxLines,
              style: widget.style,
              widget.text[index],
            ),
          ),
        ),
      ),
    );
  }

  void _initAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _animations = List.generate(
      widget.text.length,
      (index) => Tween<double>(begin: -3.14, end: 3.14).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Curves.easeInOut,
        ),
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _controller.addListener(
          () {
            setState(() {
              _offset += 0.02;
              if (_offset > 3.14) {
                _offset -= 2 * 3.14;
              }
            });
          },
        );
      },
    );
    widget.audioHandler?.playbackState.listen(
      (state) {
        try {
          if (state.playing) {
            _controller.repeat();
          } else {
            _controller.stop();
          }
        } catch (e) {
          debugPrint(e.toString());
        }
      },
    );
  }
}
