import 'dart:math';
import 'dart:ui';

import 'package:catex/src/lookup/context.dart';
import 'package:catex/src/lookup/modes.dart';
import 'package:catex/src/lookup/symbols.dart';
import 'package:catex/src/rendering/character.dart';
import 'package:catex/src/rendering/rendering.dart';
import 'package:flutter/rendering.dart';

class RenderSqrt extends RenderNode with SingleChildRenderNodeMixin {
  RenderSqrt(CaTeXContext context) : super(context);

  late TextPainter _surdPainter;
  late Paint _linePaint;

  @override
  void configure() {
    _linePaint = Paint()
      ..color = context.color!
      ..strokeWidth = context.textSize! / 20
      ..strokeCap = StrokeCap.square;
    _surdPainter = TypesetPainter(
      context.copyWith(input: symbols[CaTeXMode.math]![r'\surd']!.unicode),
    );

    _surdPainter.layout();
    final Size? childSize = sizeChildNode(child),
        surdSize = _surdPainter.size,
        height = max(surdSize!.height as Never, childSize!.height as Never);

    child.positionNode(Offset(surdSize.width, height! - (childSize.height as OffsetBase) as double));
    renderSize = Size(surdSize.width + childSize.width, height as double);
  }

  @override
  void render(Canvas canvas) {
    paintChildNode(child);
    _surdPainter.paint(canvas, Offset.zero);

    // Draws an overline.
    final h =
        (_surdPainter.size.height - context.textSize! + _linePaint.strokeWidth) /
            2;
    canvas.drawLine(
      // todo
      Offset(_surdPainter.size.width, h),
      Offset(renderSize!.width, h),
      _linePaint,
    );
  }
}
