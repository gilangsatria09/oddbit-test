import 'package:flutter/material.dart';
import 'package:notes_app/gen/fonts.gen.dart';

class AppTextStyle {
  const AppTextStyle._();

  static final paragraphs = _ParagraphsStyle();
  static final headings = _HeadingsStyle();
}

class _ParagraphsStyle {
  const _ParagraphsStyle();

  _AppTextStyle get xxSmall => _AppTextStyle(fontSize: 8);
  _AppTextStyle get xSmall => _AppTextStyle(fontSize: 10);
  _AppTextStyle get small => _AppTextStyle(fontSize: 12);
  _AppTextStyle get medium => _AppTextStyle(fontSize: 14);
  _AppTextStyle get large => _AppTextStyle(fontSize: 16);
  _AppTextStyle get size18 => _AppTextStyle(fontSize: 18);
  _AppTextStyle get xLarge => _AppTextStyle(fontSize: 20);
}

class _HeadingsStyle {
  const _HeadingsStyle();

  _AppTextStyle get displayLarge => _AppTextStyle(fontSize: 52);
  _AppTextStyle get displaySmall => _AppTextStyle(fontSize: 44);
  _AppTextStyle get h1 => _AppTextStyle(fontSize: 40);
  _AppTextStyle get h2 => _AppTextStyle(fontSize: 32);
  _AppTextStyle get h3 => _AppTextStyle(fontSize: 28);
  _AppTextStyle get h4 => _AppTextStyle(fontSize: 24);
  _AppTextStyle get h5 => _AppTextStyle(fontSize: 20);
  _AppTextStyle get h6 => _AppTextStyle(fontSize: 18);
}

class _AppTextStyle {
  final double fontSize;
  final FontWeight fontWeight;
  final FontStyle fontStyle;
  final Color color;

  const _AppTextStyle({
    required this.fontSize,
    this.fontWeight = FontWeight.normal,
    this.fontStyle = FontStyle.normal,
    this.color = Colors.black,
  });

  _AppTextStyle get heavy => copyWith(fontWeight: FontWeight.w900);
  _AppTextStyle get extraBold => copyWith(fontWeight: FontWeight.w800);
  _AppTextStyle get bold => copyWith(fontWeight: FontWeight.bold);
  _AppTextStyle get semiBold => copyWith(fontWeight: FontWeight.w600);
  _AppTextStyle get medium => copyWith(fontWeight: FontWeight.w500);
  _AppTextStyle get regular => copyWith(fontWeight: FontWeight.w400);
  _AppTextStyle get italic => copyWith(fontStyle: FontStyle.italic);

  _AppTextStyle colorize(Color? newColor) => copyWith(color: newColor);

  TextStyle get textStyle => TextStyle(
    fontFamily: FontFamily.montserrat,
    fontSize: fontSize,
    fontWeight: fontWeight,
    fontStyle: fontStyle,
    color: color,
    height: 1.5,
    leadingDistribution: TextLeadingDistribution.even,
  );

  _AppTextStyle copyWith({
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    Color? color,
  }) {
    return _AppTextStyle(
      fontSize: fontSize ?? this.fontSize,
      fontWeight: fontWeight ?? this.fontWeight,
      fontStyle: fontStyle ?? this.fontStyle,
      color: color ?? this.color,
    );
  }
}
