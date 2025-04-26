import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

const _foregroundColor = Color(0xFFFFFDFF);
const _backgroundColor = Color(0xFF212121);

const _animationDuration = 1250;

const _backgroundProgressStart = 980;
const _backgroundProgressEnd = 1150;

const _backgroundOpacityStart = _backgroundProgressStart;
const _backgroundOpacityEnd = _animationDuration;

const _foregroundProgressStart = 366;
const _foregroundProgressEnd = 850;

const _foregroundOffsetStart = 350;
const _foregroundOffsetEnd = 915;

const _foregroundLinesLengthStart = 335;
const _foregroundLinesLengthEnd = 715;

const _foregroundLinesGapStart = 915;
const _foregroundLinesGapEnd = 1185;

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    required this.controller,
    super.key,
  });

  final AnimationController controller;

  static AnimationController createController(TickerProvider vsync) {
    return AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: _animationDuration),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Stack(
        alignment: Alignment.center,
        children: [
          _Background(controller: controller),
          _Foreground(controller: controller),
        ],
      ),
    );
  }
}

class _Background extends StatefulWidget {
  const _Background({required this.controller});

  final AnimationController controller;

  @override
  State<_Background> createState() => _BackgroundState();
}

class _BackgroundState extends State<_Background> {
  static const _curve = Cubic(.26, .05, .78, .61);

  late final _progress = Tween<double>(begin: 0, end: 1)
      .chain(
    CurveTween(
      curve: const Interval(
        _backgroundProgressStart / _animationDuration,
        _backgroundProgressEnd / _animationDuration,
        curve: _curve,
      ),
    ),
  )
      .animate(widget.controller);

  late final _opacity = Tween<double>(begin: 1, end: 0)
      .chain(
    CurveTween(
      curve: const Interval(
        _backgroundOpacityStart / _animationDuration,
        _backgroundOpacityEnd / _animationDuration,
        curve: _curve,
      ),
    ),
  )
      .animate(widget.controller);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _BackgroundPainter(
        color: _backgroundColor,
        progress: _progress,
        opacity: _opacity,
      ),
      child: const SizedBox.expand(),
    );
  }
}

class _BackgroundPainter extends CustomPainter {
  _BackgroundPainter({
    required this.color,
    required this.opacity,
    required this.progress,
  }) : super(
    repaint: Listenable.merge([opacity, progress]),
  );

  final Color color;

  final Animation<double> opacity;

  final Animation<double> progress;

  @override
  void paint(Canvas canvas, Size size) {
    if (opacity.value == 0) {
      return;
    }

    final screenRect = Offset.zero & size;

    final fadingRectWidthProgress = 0.23 + 0.77 * progress.value;
    final fadingRectWidth = fadingRectWidthProgress * screenRect.width;

    final fadingRect = Rect.fromCenter(
      center: screenRect.center,
      width: fadingRectWidth,
      height: screenRect.height,
    );

    final paint = Paint()..color = color.withOpacity(opacity.value);

    canvas.drawRect(fadingRect, paint);

    if (progress.value == 1) {
      return;
    }

    paint.color = color;

    canvas
      ..drawRect(
        Rect.fromLTRB(
          screenRect.left,
          screenRect.top,
          fadingRect.left + 0.5,
          screenRect.bottom,
        ),
        paint,
      )
      ..drawRect(
        Rect.fromLTRB(
          fadingRect.right - 0.5,
          screenRect.top,
          screenRect.right,
          screenRect.bottom,
        ),
        paint,
      );
  }

  @override
  bool shouldRepaint(_BackgroundPainter oldDelegate) {
    return color != oldDelegate.color ||
        progress != oldDelegate.progress ||
        opacity != oldDelegate.opacity;
  }
}

class _Foreground extends StatefulWidget {
  const _Foreground({required this.controller});

  final AnimationController controller;

  @override
  State<_Foreground> createState() => __ForegroundState();
}

class __ForegroundState extends State<_Foreground> {
  late final _opacity = TweenSequence<double>(
    [
      TweenSequenceItem(
        tween: Tween(begin: 0.515, end: 0),
        weight: 18 / 75,
      ),
      TweenSequenceItem(
        tween: ConstantTween(0),
        weight: 3 / 75,
      ),
      TweenSequenceItem(
        tween: ConstantTween(1),
        weight: 54 / 75,
      ),
    ],
  ).animate(widget.controller);

  late final _progress = Tween<double>(begin: 0, end: 1)
      .chain(
    CurveTween(
      curve: const Interval(
        _foregroundProgressStart / _animationDuration,
        _foregroundProgressEnd / _animationDuration,
        curve: Cubic(0.72, 0, 0.59, 0.52),
      ),
    ),
  )
      .animate(widget.controller);

  late final _offset = Tween<double>(begin: 0, end: 1)
      .chain(
    CurveTween(
      curve: const Interval(
        _foregroundOffsetStart / _animationDuration,
        _foregroundOffsetEnd / _animationDuration,
        curve: Curves.easeIn,
      ),
    ),
  )
      .animate(widget.controller);

  late final _linesLength = Tween<double>(begin: 0, end: 1)
      .chain(
    CurveTween(
      curve: const Interval(
        _foregroundLinesLengthStart / _animationDuration,
        _foregroundLinesLengthEnd / _animationDuration,
        curve: Curves.easeInOut,
      ),
    ),
  )
      .animate(widget.controller);

  late final _linesGap = Tween<double>(begin: 0, end: 1)
      .chain(
    CurveTween(
      curve: const Interval(
        _foregroundLinesGapStart / _animationDuration,
        _foregroundLinesGapEnd / _animationDuration,
        curve: Cubic(0.77, -0.1, 0.66, 0.73),
      ),
    ),
  )
      .animate(widget.controller);

  late final _a1Painter = _ALetterPainter(
    color: _foregroundColor,
    maskColor: _backgroundColor,
    opacity: _opacity,
    progress: _progress,
  );

  late final _hPainter = _HLetterPainter(
    color: _foregroundColor,
    maskColor: _backgroundColor,
    opacity: _opacity,
    progress: _progress,
  );

  late final _a2Painter = _ALetterPainter(
    color: _foregroundColor,
    maskColor: _backgroundColor,
    opacity: _opacity,
    progress: _progress,
  );

  late final _vPainter = _VLetterPainter(
    color: _foregroundColor,
    maskColor: _backgroundColor,
    opacity: _opacity,
    progress: _progress,
  );

  late final _a3Painter = _ALetterPainter(
    color: _foregroundColor,
    maskColor: _backgroundColor,
    opacity: _opacity,
    progress: _progress,
  );

  @override
  Widget build(BuildContext context) {
    return CustomMultiChildLayout(
      delegate: _ForegroundLayoutDelegate(
        offset: _offset,
        linesLength: _linesLength,
        linesGap: _linesGap,
      ),
      children: [
        LayoutId(
          id: _ForegroundPart.a1,
          child: CustomPaint(painter: _a1Painter),
        ),
        LayoutId(
          id: _ForegroundPart.h,
          child: CustomPaint(painter: _hPainter),
        ),
        LayoutId(
          id: _ForegroundPart.a2,
          child: CustomPaint(painter: _a2Painter),
        ),
        LayoutId(
          id: _ForegroundPart.v,
          child: CustomPaint(painter: _vPainter),
        ),
        LayoutId(
          id: _ForegroundPart.a3,
          child: CustomPaint(painter: _a3Painter),
        ),
        LayoutId(
          id: _ForegroundPart.leftLine,
          child: const ColoredBox(color: _foregroundColor),
        ),
        LayoutId(
          id: _ForegroundPart.rightLine,
          child: const ColoredBox(color: _foregroundColor),
        ),
      ],
    );
  }
}

enum _ForegroundPart {
  a1,
  h,
  a2,
  v,
  a3,
  leftLine,
  rightLine,
}

class _ForegroundLayoutDelegate extends MultiChildLayoutDelegate {
  _ForegroundLayoutDelegate({
    required this.offset,
    required this.linesLength,
    required this.linesGap,
  }) : super(
    relayout: Listenable.merge([
      offset,
      linesLength,
      linesGap,
    ]),
  );

  final Animation<double> offset;

  final Animation<double> linesLength;

  final Animation<double> linesGap;

  @override
  void performLayout(Size size) {
    const logoSize = Size(220, 54); // Increased width for 5 letters
    const maxOffset = 32.7;

    final a1Size = layoutChild(
      _ForegroundPart.a1,
      const BoxConstraints.tightFor(width: 40, height: 54),
    );
    final hSize = layoutChild(
      _ForegroundPart.h,
      const BoxConstraints.tightFor(width: 40, height: 54),
    );
    final a2Size = layoutChild(
      _ForegroundPart.a2,
      const BoxConstraints.tightFor(width: 40, height: 54),
    );
    final vSize = layoutChild(
      _ForegroundPart.v,
      const BoxConstraints.tightFor(width: 40, height: 54),
    );
    final a3Size = layoutChild(
      _ForegroundPart.a3,
      const BoxConstraints.tightFor(width: 40, height: 54),
    );

    final screenRect = Offset.zero & size;
    final logoRect = screenRect.center.translate(
      -logoSize.width / 2,
      -logoSize.height / 2,
    ) &
    logoSize;

    var a1Rect = logoRect.topLeft & a1Size;

    if (offset.value > 0) {
      a1Rect = a1Rect.translate(maxOffset * offset.value, 0);
    }

    const letterGap = 5.0; // Space between letters

    final hRect = a1Rect.topRight.translate(letterGap, 0) & hSize;
    final a2Rect = hRect.topRight.translate(letterGap, 0) & a2Size;
    final vRect = a2Rect.topRight.translate(letterGap, 0) & vSize;
    final a3Rect = vRect.topRight.translate(letterGap, 0) & a3Size;

    positionChild(_ForegroundPart.a1, a1Rect.topLeft);
    positionChild(_ForegroundPart.h, hRect.topLeft);
    positionChild(_ForegroundPart.a2, a2Rect.topLeft);
    positionChild(_ForegroundPart.v, vRect.topLeft);
    positionChild(_ForegroundPart.a3, a3Rect.topLeft);

    if (linesLength.value == 0 || linesGap.value == 1) {
      layoutChild(
        _ForegroundPart.leftLine,
        const BoxConstraints.tightFor(width: 0, height: 0),
      );
      layoutChild(
        _ForegroundPart.rightLine,
        const BoxConstraints.tightFor(width: 0, height: 0),
      );
      return;
    }

    const initialLineSize = Size(8.5, 54);
    const maxLineWidth = 50;
    final maxLineHeight = screenRect.height;

    final gap = math.max(0, (screenRect.width - letterGap * 4) * linesGap.value);

        final lineSize = Size(
        initialLineSize.width +
        (maxLineWidth - initialLineSize.width) * linesGap.value,
        initialLineSize.height +
    (maxLineHeight - initialLineSize.height) * linesLength.value,
    );

    layoutChild(_ForegroundPart.leftLine, BoxConstraints.tight(lineSize));
    layoutChild(_ForegroundPart.rightLine, BoxConstraints.tight(lineSize));

    final leftLineRect = a1Rect.centerRight.translate(
    -lineSize.width - gap / 2,
    -lineSize.height / 2,
    ) &
    lineSize;

    positionChild(_ForegroundPart.leftLine, leftLineRect.topLeft);
    positionChild(
    _ForegroundPart.rightLine,
    leftLineRect.topRight.translate(letterGap * 4 + gap, 0),
    );
  }

  @override
  bool shouldRelayout(_ForegroundLayoutDelegate oldDelegate) {
    return offset != oldDelegate.offset ||
        linesLength != oldDelegate.linesLength ||
        linesGap != oldDelegate.linesGap;
  }
}

abstract class _LetterPainter extends CustomPainter {
  _LetterPainter({
    required this.color,
    required this.maskColor,
    required this.opacity,
    required this.progress,
  }) : super(repaint: Listenable.merge([opacity, progress]));

  final Color color;

  final Color maskColor;

  final Animation<double> opacity;

  final Animation<double> progress;

  Path? _letterPath;

  List<PathMetric>? _maskPathMetrics;

  Path buildLetterPath();

  Path buildMaskPath();

  @override
  void paint(Canvas canvas, Size size) {
    var letterPath = _letterPath;
    var maskPathMetrics = _maskPathMetrics;

    if (letterPath == null || maskPathMetrics == null) {
      letterPath = buildLetterPath();
      _letterPath = letterPath;

      maskPathMetrics = buildMaskPath().computeMetrics().toList();
      _maskPathMetrics = maskPathMetrics;
    }

    if (progress.value == 1) {
      return;
    }

    canvas.drawPath(
      letterPath,
      Paint()
        ..style = PaintingStyle.fill
        ..color = color.withOpacity(opacity.value),
    );

    if (progress.value == 0) {
      return;
    }

    for (final metric in maskPathMetrics) {
      final maskPath = metric.extractPath(
        0,
        metric.length * progress.value,
      );

      canvas.drawPath(
        maskPath,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 8.5
          ..color = maskColor,
      );
    }
  }

  @override
  bool shouldRepaint(_LetterPainter oldDelegate) {
    return color != oldDelegate.color ||
        maskColor != oldDelegate.maskColor ||
        opacity != oldDelegate.opacity ||
        progress != oldDelegate.progress;
  }
}

class _ALetterPainter extends _LetterPainter {
  _ALetterPainter({
    required super.color,
    required super.maskColor,
    required super.opacity,
    required super.progress,
  });

  @override
  Path buildLetterPath() {
    return Path()
      ..moveTo(20, 0)
      ..lineTo(40, 54)
      ..lineTo(30, 54)
      ..lineTo(25, 40)
      ..lineTo(15, 40)
      ..lineTo(10, 54)
      ..lineTo(0, 54)
      ..lineTo(20, 0)
      ..moveTo(17, 30)
      ..lineTo(23, 30)
      ..lineTo(20, 20);
  }

  @override
  Path buildMaskPath() {
    return Path()
      ..moveTo(10, 54)
      ..lineTo(20, 20)
      ..lineTo(30, 54);
  }
}

class _HLetterPainter extends _LetterPainter {
  _HLetterPainter({
    required super.color,
    required super.maskColor,
    required super.opacity,
    required super.progress,
  });

  @override
  Path buildLetterPath() {
    return Path()
      ..moveTo(0, 0)
      ..lineTo(10, 0)
      ..lineTo(10, 24)
      ..lineTo(30, 24)
      ..lineTo(30, 0)
      ..lineTo(40, 0)
      ..lineTo(40, 54)
      ..lineTo(30, 54)
      ..lineTo(30, 30)
      ..lineTo(10, 30)
      ..lineTo(10, 54)
      ..lineTo(0, 54)
      ..close();
  }

  @override
  Path buildMaskPath() {
    return Path()
      ..moveTo(5, 54)
      ..lineTo(5, 27)
      ..lineTo(35, 27)
      ..lineTo(35, 54);
  }
}

class _VLetterPainter extends _LetterPainter {
  _VLetterPainter({
    required super.color,
    required super.maskColor,
    required super.opacity,
    required super.progress,
  });

  @override
  Path buildLetterPath() {
    return Path()
      ..moveTo(0, 0)
      ..lineTo(10, 0)
      ..lineTo(20, 35)
      ..lineTo(30, 0)
      ..lineTo(40, 0)
      ..lineTo(25, 54)
      ..lineTo(15, 54)
      ..close();
  }

  @override
  Path buildMaskPath() {
    return Path()
      ..moveTo(10, 0)
      ..lineTo(20, 27)
      ..lineTo(30, 0);
  }
}