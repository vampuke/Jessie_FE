import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///颜色
class LamourColors {
  static const String primaryValueString = "#FFC0CB";
  static const String primaryLightValueString = "#42464b";
  static const String primaryDarkValueString = "#121917";
  static const String miWhiteString = "#ececec";
  static const String actionBlueString = "#267aff";
  static const String webDraculaBackgroundColorString = "#282a36";
  static const String nextBtnColor = "#3399ff";

  static const int primaryValue = 0xFFFFC0CB;
  static const int primaryLightValue = 0xFF42464b;
  static const int primaryDarkValue = 0xFF121917;
  static const int nextBtnColorValue = 0xFF80bfff;

  static const int cardWhite = 0xFFFFFFFF;
  static const int textWhite = 0xFFFFFFFF;
  static const int miWhite = 0xffececec;
  static const int white = 0xFFFFFFFF;
  static const int actionBlue = 0xff267aff;
  static const int deleteRed = 0xFFFF4D4F;
  static const int subTextColor = 0xff959595;
  static const int subLightTextColor = 0xffc4c4c4;
  static const int lightGray = 0xFFE0E0E0;
  static const int likeGreen = 0xFF00C853;
  static const int dislikeRed = 0xFFFF6D00;
  static const int actionGreen = 0xFF1890FF;
  static const int happyOrange = 0xFFFF8762;

  static const int mainBackgroundColor = miWhite;

  static const int mainTextColor = primaryDarkValue;
  static const int textColorWhite = white;

  static const MaterialColor primarySwatch = const MaterialColor(
    primaryValue,
    const <int, Color>{
      50: const Color(primaryLightValue),
      100: const Color(primaryLightValue),
      200: const Color(primaryLightValue),
      300: const Color(primaryLightValue),
      400: const Color(primaryLightValue),
      500: const Color(primaryValue),
      600: const Color(primaryDarkValue),
      700: const Color(primaryDarkValue),
      800: const Color(primaryDarkValue),
      900: const Color(primaryDarkValue),
    },
  );
}

class LamourConstant {
  static const lagerTextSize = 30.0;
  static const bigTextSize = 23.0;
  static const normalTextSize = 18.0;
  static const middleTextWhiteSize = 16.0;
  static const smallTextSize = 14.0;
  static const minTextSize = 12.0;

  static const minText = TextStyle(
    color: Color(LamourColors.subLightTextColor),
    fontSize: minTextSize,
  );

  static const smallTextWhite = TextStyle(
    color: Color(LamourColors.textColorWhite),
    fontSize: smallTextSize,
  );

  static const smallText = TextStyle(
    color: Color(LamourColors.mainTextColor),
    fontSize: smallTextSize,
  );

  static const smallTextBold = TextStyle(
    color: Color(LamourColors.mainTextColor),
    fontSize: smallTextSize,
    fontWeight: FontWeight.bold,
  );

  static const smallSubLightText = TextStyle(
    color: Color(LamourColors.subLightTextColor),
    fontSize: smallTextSize,
  );

  static const smallActionLightText = TextStyle(
    color: Color(LamourColors.actionBlue),
    fontSize: smallTextSize,
  );

  static const smallMiLightText = TextStyle(
    color: Color(LamourColors.miWhite),
    fontSize: smallTextSize,
  );

  static const smallSubText = TextStyle(
    color: Color(LamourColors.subTextColor),
    fontSize: smallTextSize,
  );

  static const middleText = TextStyle(
    color: Color(LamourColors.mainTextColor),
    fontSize: middleTextWhiteSize,
  );

  static const middleTextWhite = TextStyle(
    color: Color(LamourColors.textColorWhite),
    fontSize: middleTextWhiteSize,
  );

  static const middleSubText = TextStyle(
    color: Color(LamourColors.subTextColor),
    fontSize: middleTextWhiteSize,
  );

  static const middleSubLightText = TextStyle(
    color: Color(LamourColors.subLightTextColor),
    fontSize: middleTextWhiteSize,
  );

  static const middleTextBold = TextStyle(
    color: Color(LamourColors.mainTextColor),
    fontSize: middleTextWhiteSize,
    fontWeight: FontWeight.bold,
  );

  static const middleTextWhiteBold = TextStyle(
    color: Color(LamourColors.textColorWhite),
    fontSize: middleTextWhiteSize,
    fontWeight: FontWeight.bold,
  );

  static const middleSubTextBold = TextStyle(
    color: Color(LamourColors.subTextColor),
    fontSize: middleTextWhiteSize,
    fontWeight: FontWeight.bold,
  );

  static const normalText = TextStyle(
    color: Color(LamourColors.mainTextColor),
    fontSize: normalTextSize,
  );

  static const normalTextBold = TextStyle(
    color: Color(LamourColors.mainTextColor),
    fontSize: normalTextSize,
    fontWeight: FontWeight.bold,
  );

  static const normalSubText = TextStyle(
    color: Color(LamourColors.subTextColor),
    fontSize: normalTextSize,
  );

  static const normalTextWhite = TextStyle(
    color: Color(LamourColors.textColorWhite),
    fontSize: normalTextSize,
  );

  static const normalTextMitWhiteBold = TextStyle(
    color: Color(LamourColors.miWhite),
    fontSize: normalTextSize,
    fontWeight: FontWeight.bold,
  );

  static const normalTextActionWhiteBold = TextStyle(
    color: Color(LamourColors.actionBlue),
    fontSize: normalTextSize,
    fontWeight: FontWeight.bold,
  );

  static const normalTextLight = TextStyle(
    color: Color(LamourColors.primaryLightValue),
    fontSize: normalTextSize,
  );

  static const largeText = TextStyle(
    color: Color(LamourColors.mainTextColor),
    fontSize: bigTextSize,
  );

  static const largeTextBold = TextStyle(
    color: Color(LamourColors.mainTextColor),
    fontSize: bigTextSize,
    fontWeight: FontWeight.bold,
  );

  static const largeTextWhite = TextStyle(
    color: Color(LamourColors.textColorWhite),
    fontSize: bigTextSize,
  );

  static const largeTextWhiteBold = TextStyle(
    color: Color(LamourColors.textColorWhite),
    fontSize: bigTextSize,
    fontWeight: FontWeight.bold,
  );

  static const largeLargeTextWhite = TextStyle(
    color: Color(LamourColors.textColorWhite),
    fontSize: lagerTextSize,
    fontWeight: FontWeight.bold,
  );

  static const largeLargeText = TextStyle(
    color: Color(LamourColors.primaryValue),
    fontSize: lagerTextSize,
    fontWeight: FontWeight.bold,
  );

  static BorderSide defaultRoundedBorderSide = BorderSide(
    color: Color(0x33000000),
    style: BorderStyle.solid,
    width: 0.0,
  );

  static Border defaultRoundedBorder = Border(
    top: defaultRoundedBorderSide,
    bottom: defaultRoundedBorderSide,
    left: defaultRoundedBorderSide,
    right: defaultRoundedBorderSide,
  );

  static BoxDecoration defaultRoundedBorderDecoration = BoxDecoration(
    color: CupertinoColors.white,
    border: defaultRoundedBorder,
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
  );
}

class LamourICons {
  static const String FONT_FAMILY = 'LaIconFont';

  static const String DEFAULT_USER_ICON = 'static/images/logo.png';
  static const String DEFAULT_IMAGE = 'static/images/default_img.png';

  static const IconData NEXT =
      const IconData(0xe62f, fontFamily: LamourICons.FONT_FAMILY);
  static const IconData USER =
      const IconData(0xe7ae, fontFamily: LamourICons.FONT_FAMILY);
  static const IconData LOCK =
      const IconData(0xe7c9, fontFamily: LamourICons.FONT_FAMILY);
  static const IconData FLOWER =
      const IconData(0xe65f, fontFamily: LamourICons.FONT_FAMILY);
  static const IconData CALENDAR =
      const IconData(0xe674, fontFamily: LamourICons.FONT_FAMILY);
  static const IconData FOOD =
      const IconData(0xe600, fontFamily: LamourICons.FONT_FAMILY);
  static const IconData WISH =
      const IconData(0xe81c, fontFamily: LamourICons.FONT_FAMILY);
  static const IconData TOOLS =
      const IconData(0xe655, fontFamily: LamourICons.FONT_FAMILY);
  static const IconData VOUCHER =
      const IconData(0xe690, fontFamily: LamourICons.FONT_FAMILY);
  static const IconData Check =
      const IconData(0xe60a, fontFamily: LamourICons.FONT_FAMILY);
  static const IconData Delete =
      const IconData(0xe601, fontFamily: LamourICons.FONT_FAMILY);
  static const IconData LOGIN_USER =
      const IconData(0xe666, fontFamily: LamourICons.FONT_FAMILY);
  static const IconData LOGIN_PW =
      const IconData(0xe60e, fontFamily: LamourICons.FONT_FAMILY);
  static const IconData LOG_OUT =
      const IconData(0xe608, fontFamily: LamourICons.FONT_FAMILY);

  static const IconData ISSUE_EDIT_H1 = Icons.filter_1;
  static const IconData ISSUE_EDIT_H2 = Icons.filter_2;
  static const IconData ISSUE_EDIT_H3 = Icons.filter_3;
  static const IconData ISSUE_EDIT_BOLD = Icons.format_bold;
  static const IconData ISSUE_EDIT_ITALIC = Icons.format_italic;
  static const IconData ISSUE_EDIT_QUOTE = Icons.format_quote;
  static const IconData ISSUE_EDIT_CODE = Icons.format_shapes;
  static const IconData ISSUE_EDIT_LINK = Icons.insert_link;

  static const IconData NOTIFY_ALL_READ =
      const IconData(0xe62f, fontFamily: LamourICons.FONT_FAMILY);

  static const IconData PUSH_ITEM_EDIT = Icons.mode_edit;
  static const IconData PUSH_ITEM_ADD = Icons.add_box;
  static const IconData PUSH_ITEM_MIN = Icons.indeterminate_check_box;
}
