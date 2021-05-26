import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class Fonts {
  static String get sourceSansPro => 'SourceSansPro';
}

abstract class TextStyles {
  static TextStyle get small => TextStyle(fontSize: 12, fontWeight: FontWeight.w500);
  static TextStyle get medium => TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
  static TextStyle get large => TextStyle(fontSize: 26, fontWeight: FontWeight.w700);
}

extension TextStyleHelper on TextStyle {
  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);
  TextStyle get underlined => copyWith(decoration: TextDecoration.underline);
  TextStyle colour(Color value) => copyWith(color: value);
  TextStyle weight(FontWeight value) => copyWith(fontWeight: value);
  TextStyle get bold => copyWith(fontWeight: FontWeight.w700);
  TextStyle size(double value) => copyWith(fontSize: value);
}

abstract class MyColors {
  static Color get orange => const Color(0xfffe0000);
  static Color get green => const Color(0xff0a5e2a);
  static Color get lightGreen => const Color(0xff6dac4f);
  static Color get darkRed => const Color(0xffBB000E);
  static Color get alphaDarkRed => const Color(0xcc000000);
  static Color get link => const Color(0xff0000CD);
  static Color get grey => const Color(0xff000000);
  static Color get aboutContainer => const Color(0xFFFFBBBB);
}

abstract class InputDecorations {
  static InputDecoration get textField => InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.all(3),
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: Colors.grey[700], width: 2)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: MyColors.green, width: 2)),
      );
}

class MyTextField extends StatelessWidget {
  final String initialValue;
  final TextInputAction textInputAction;
  final Function(String) onChanged;
  final Function onEditingComplete;

  MyTextField({@required Key key, this.initialValue, this.textInputAction, this.onChanged, this.onEditingComplete})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 90,
        alignment: Alignment.center,
        child: TextFormField(
          initialValue: initialValue,
          textAlign: TextAlign.center,
          style: TextStyles.large.weight(FontWeight.w500),
          decoration: InputDecorations.textField,
          cursorColor: MyColors.darkRed,
          cursorRadius: Radius.circular(10),
          enableInteractiveSelection: false,
          inputFormatters: [LengthLimitingTextInputFormatter(5), FilteringTextInputFormatter.allow(RegExp(r'[\d]'))],
          keyboardType: TextInputType.number,
          textInputAction: textInputAction,
          onChanged: onChanged,
          onEditingComplete: onEditingComplete,
        ));
  }
}
