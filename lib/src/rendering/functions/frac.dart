import 'dart:math';
import 'dart:ui';

import 'package:catex/src/lookup/context.dart';
import 'package:catex/src/parsing/functions/frac.dart';
import 'package:catex/src/rendering/rendering.dart';

/// [RenderNode] for [FracNode].
class RenderFrac extends RenderNode {
  /// Constructs a [RenderFrac] given a [context].
  RenderFrac(CaTeXContext context) : super(context);

  late Paint _linePaint;

  /// Arranges the children in a column and centers them horizontally.
  @override
  void configure() {
    final Size? upperChildSize = sizeChildNode(children[0]),
        lowerChildSize = sizeChildNode(children[1]),
        width = max(upperChildSize!.width as Never, lowerChildSize!.width as Never);

    // Center the children horizontally.
    children[0].positionNode(Offset((width! - (upperChildSize.width as OffsetBase)) / 2, 0));
    children[1].positionNode(
        Offset((width - (lowerChildSize.width as OffsetBase)) / 2, upperChildSize.height));

    renderSize = Size(width as double, upperChildSize.height + lowerChildSize.height);

    _linePaint = Paint()
      ..strokeWidth = 1.7
      ..color = context.color!;
  }

  @override
  void render(Canvas canvas) {
    paintChildNode(children[0]);
    paintChildNode(children[1]);

    final lineHeight = children[0].renderSize!.height;
    canvas.drawLine(
      // todo: figure out line properties properly.
      Offset(0, lineHeight),
      Offset(renderSize!.width, lineHeight),
      _linePaint,
    );
  }
}
