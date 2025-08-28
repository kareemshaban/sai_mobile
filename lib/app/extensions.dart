import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

extension NumberParsing on num {
  double w(BuildContext context) => this * MediaQuery.sizeOf(context).width;

  double h(BuildContext context) => this * MediaQuery.sizeOf(context).height;
}

extension SizeBoxExtension on num {
  SizedBox verticalSpace() {
    return SizedBox(height: toDouble());
  }

  SizedBox horizontalSpace() {
    return SizedBox(width: toDouble());
  }
}

extension DateTimeExtension on DateTime {
  String formatForApi() => DateFormat('yyyy-MM-dd', 'en').format(this);
}

extension StringExtension on String {
  String capitalize() => this[0].toUpperCase() + substring(1);
}

extension NumberMapper on num {
  String formatCurrency(BuildContext context) => NumberFormat.currency(
        locale: context.locale.languageCode,
        decimalDigits: this is double && this != toInt() ? 2 : 0,
        name: "QAR",
        symbol: '',
      ).format(this);
  String get formatCurrencyWithoutSymbol => NumberFormat.currency(
        decimalDigits: this is double && this != toInt() ? 2 : 0,
        symbol: '',
      ).format(this);
}

extension WidgetSliver on Widget {
  SingleChildRenderObjectWidget toSliver() => SliverToBoxAdapter(child: this);
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
