import 'package:flutter/material.dart';

extension SizedBoxExtension on num {
  SizedBox get height => SizedBox(height: toDouble());
  SizedBox get width => SizedBox(width: toDouble());
  SizedBox get space => SizedBox(width: toDouble(), height: toDouble());
}
