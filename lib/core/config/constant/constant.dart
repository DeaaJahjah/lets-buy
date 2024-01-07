import 'package:flutter/material.dart';
import 'package:lets_buy/features/home_screen/models/category.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

const Color purple = Color(0xff6C3079);
const Color pink = Color.fromARGB(255, 174, 17, 140);
const Color dark = Color.fromARGB(255, 0, 0, 0);
const Color white = Color(0xffffffff);

const String font = 'Tajawal';

const TextStyle textStyle = TextStyle(color: white, fontFamily: font, fontSize: 12);

const TextStyle itemTextStyle = TextStyle(color: white, fontFamily: font, fontSize: 18);

const TextStyle appBarTextStyle = TextStyle(color: white, fontFamily: font, fontWeight: FontWeight.bold, fontSize: 16);

const TextStyle style1 = TextStyle(color: purple, fontFamily: font, fontSize: 14, fontWeight: FontWeight.bold);

const TextStyle style2 = TextStyle(color: white, fontFamily: font, fontSize: 12, fontWeight: FontWeight.bold);

const sizedBoxSmall = SizedBox(height: 10);

const sizedBoxMedium = SizedBox(height: 20);

const sizedBoxLarge = SizedBox(height: 30);

StreamChatThemeData streamChatTheme = StreamChatThemeData(
  colorTheme: StreamColorTheme.dark(accentPrimary: purple, appBg: dark, barsBg: dark, overlayDark: purple),
  messageInputTheme: const StreamMessageInputThemeData(
    actionButtonColor: purple,
    sendButtonColor: purple,
  ),
  otherMessageTheme: const StreamMessageThemeData(messageBackgroundColor: purple),
  channelListViewTheme: const StreamChannelListViewThemeData(backgroundColor: dark),
);

var categories = {
  'اختر': ['اختر'],
  'ملابس': ['نسائي', 'رجيالي', 'ولادي'],
  'رياضة': ['آلات', 'ملابس', 'ألعاب'],
  'الكترونيات': ['جوالات', 'لابتوبات', 'شاشات', 'غسالات', 'برادات', 'مكيفات هوائية'],
  'أثاث': ['غرفة نوم', 'صالون', 'غرفة معيشة', 'أثاث مطبخ'],
  'أطفال': ['ألعاب', 'ملابس'],
  'اكسسوارات': ['حقائب', 'مجوهرات', 'ساعات'],
  'احزية': ['رجالي', 'نسائي', 'أطفال'],
  'مسلزمات مدرسية': ['حقائب مدرسية', 'ملابس', 'قرطاسية'],
  'كتب': ['كتب علمية', 'كتب دينية', 'روايات', 'كتب ثقافية'],
};

List<String> productStatusList = ['جديد', 'مستعمل'];

List<String> cities = [
  'حمص',
  'حماة',
  'دمشق',
  'ريف دمشق',
  'حلب',
  'الحسكة',
  'دير الزور',
  'القامشلي',
  'طرطوس',
  'اللاذقية',
  'درعا',
];
List<Category> categoriesHome = [
  Category(name: 'الكل', urlImage: 'assets/images/all.png', isSelected: true),
  Category(name: 'ملابس', urlImage: 'assets/images/clothes1.png', isSelected: false),
  Category(name: 'أطفال', urlImage: 'assets/images/kids1.png', isSelected: false),
  Category(name: 'احزية', urlImage: 'assets/images/shoes1.png', isSelected: false),
  Category(name: 'رياضة', urlImage: 'assets/images/sport1.png', isSelected: false),
  Category(name: 'أثاث', urlImage: 'assets/images/furniture1.png', isSelected: false),
  Category(name: 'الكترونيات', urlImage: 'assets/images/electronics1.png', isSelected: false),
  Category(name: 'اكسسوارات', urlImage: 'assets/images/accessories1.png', isSelected: false),
  Category(name: 'مستلزمات مدرسية', urlImage: 'assets/images/school1.png', isSelected: false),
  Category(name: 'كتب', urlImage: 'assets/images/book1.png', isSelected: false),
];
