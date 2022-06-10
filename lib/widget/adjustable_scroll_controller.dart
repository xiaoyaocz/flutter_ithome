import 'dart:io';
import 'dart:math';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

class AdjustableScrollController extends ScrollController {
  AdjustableScrollController([int extraScrollSpeed = 60]) {
    if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
      super.addListener(() {
        ScrollDirection scrollDirection = super.position.userScrollDirection;
        if (scrollDirection != ScrollDirection.idle) {
          double scrollEnd = super.offset +
              (scrollDirection == ScrollDirection.reverse
                  ? extraScrollSpeed
                  : -extraScrollSpeed);
          scrollEnd = min(super.position.maxScrollExtent,
              max(super.position.minScrollExtent, scrollEnd));
          jumpTo(scrollEnd);
        }
      });
    }
  }
}
