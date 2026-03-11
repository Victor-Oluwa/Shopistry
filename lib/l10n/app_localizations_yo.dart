// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Yoruba (`yo`).
class AppLocalizationsYo extends AppLocalizations {
  AppLocalizationsYo([String locale = 'yo']) : super(locale);

  @override
  String get appTitle => 'Shopistry';

  @override
  String get myCart => 'Akọ̀wọ́ mi';

  @override
  String get subtotal => 'Àpapọ̀ abẹ́lẹ̀';

  @override
  String get delivery => 'Ìfihàn';

  @override
  String get deliveryFee => 'Owó ìkọ́nilọ́wọ́';

  @override
  String get total => 'Àpapọ̀ tán';

  @override
  String get proceedToCheckout => 'Tẹ̀síwájú sí Ìsanwó';

  @override
  String get cartEmptyTitle => 'Akọ̀wọ́ rẹ ṣòfo';

  @override
  String get cartEmptySubtitle =>
      'Ó dàbí pé o kò tíì fi nǹkan kankan sínú akọ̀wọ́ rẹ.';

  @override
  String get startExploring => 'Bẹ̀rẹ̀ sí ní ṣàyẹ̀wò';

  @override
  String get checkout => 'Ìsanwó';

  @override
  String get deliveryAddress => 'Àdírẹ́sì ìkọ́nilọ́wọ́';

  @override
  String get paymentMethod => 'Ọ̀nà ìsanwó';

  @override
  String get orderSummary => 'Àkópọ̀ àṣẹ';

  @override
  String get confirmOrder => 'Jẹ́rìí sí àṣẹ';

  @override
  String get creditCard => 'Káàdì gbèsè';

  @override
  String get applePay => 'Apple Pay';

  @override
  String get payPal => 'PayPal';

  @override
  String get orderSuccessTitle => 'Àṣẹ rẹ ti tẹ̀ síwájú!';

  @override
  String get orderSuccessSubtitle =>
      'Ohun ọ̀ṣọ́ rẹ ń bọ̀ lọ́nà. A ó sọ fún ọ nígbà tí ó bá ti ń bọ̀.';

  @override
  String get backToHome => 'Padà sí Ilé';

  @override
  String get addressHint => 'Tẹ àdírẹ́sì ìkọ́nilọ́wọ́ rẹ...';

  @override
  String get errorOccurred => 'Àṣìṣe kan ṣẹlẹ̀';

  @override
  String get wishlist => 'Àkójọ ìfẹ́';

  @override
  String itemsYouLove(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Nǹkan $count tí o fẹ́ràn',
      one: 'Nǹkan kan tí o fẹ́ràn',
    );
    return '$_temp0';
  }

  @override
  String get clearWishlistTitle => 'Pa Àkójọ ìfẹ́ rẹ́?';

  @override
  String get clearWishlistContent =>
      'Ṣé o dájú pé o fẹ́ yọ gbogbo nǹkan kúrò nínú àkójọ ìfẹ́ rẹ?';

  @override
  String get cancel => 'Fagilé';

  @override
  String get clearAll => 'Pa gbogbo rẹ̀ rẹ́';

  @override
  String get wishlistEmptyTitle => 'Àkójọ ìfẹ́ rẹ ṣòfo';

  @override
  String get wishlistEmptySubtitle =>
      'Fi àwọn ohun ọ̀ṣọ́ tí o fẹ́ràn pamọ́ síbí láti rí wọn padà.';

  @override
  String get discoverProducts => 'Ṣàwárí àwọn nǹkan';

  @override
  String get welcomeBack => 'Káàbọ̀ padà,';

  @override
  String get discoverStyle => 'Ṣàwárí Ọ̀nà';

  @override
  String get searchHint => 'Wá ohun ọ̀ṣọ́...';

  @override
  String get newSeason => 'ÌDÀSÍLẸ̀ TUNTUN';

  @override
  String get modernLuxuryCollection => 'Àkójọ Ọlá Tuntun';

  @override
  String get categories => 'Àwọn Ìpín';

  @override
  String get popularProducts => 'Àwọn nǹkan tí ènìyàn fẹ́ràn';

  @override
  String get viewAll => 'Wò gbogbo rẹ̀';

  @override
  String get dimensions => 'Ìwọ̀n';

  @override
  String get material => 'Ohun èlò';

  @override
  String get weight => 'Ìwọ̀n';

  @override
  String get addToCart => 'FI SÍBÍ AKỌ̀WÓ';

  @override
  String get description => 'Ìjúwe';

  @override
  String get selectColor => 'Yan Àwọ̀';

  @override
  String get quantity => 'Iye';

  @override
  String get similarProducts => 'Àwọn nǹkan tó jọra';

  @override
  String get readMore => 'Ka síwájú';

  @override
  String get readLess => 'Ka dínkù';

  @override
  String get allProducts => 'Gbogbo nǹkan';

  @override
  String get noProductsFound => 'A kò rí nǹkan kankan';

  @override
  String get tryAdjustingFilters => 'Gbìyànjú láti yí àwọn asẹ́ rẹ padà';

  @override
  String get filters => 'Àwọn asẹ́';

  @override
  String get resetAll => 'Tún gbogbo rẹ̀ bẹ̀rẹ̀';

  @override
  String get sortBy => 'Tò nípasẹ̀';

  @override
  String get category => 'Ìpín';

  @override
  String get priceRange => 'Iye owó';

  @override
  String get colors => 'Àwọn àwọ̀';

  @override
  String get applyFilters => 'Lo asẹ́';

  @override
  String get popularity => 'Ìfẹ́ràn ènìyàn';

  @override
  String get newest => 'Tuntun jùlọ';

  @override
  String get priceLowToHigh => 'Owó: Kékeré sí Púpọ̀';

  @override
  String get priceHighToLow => 'Owó: Púpọ̀ sí Kékeré';

  @override
  String get categoryAll => 'Gbogbo rẹ̀';

  @override
  String get categorySofas => 'Sífà';

  @override
  String get categoryChairs => 'Àpótí';

  @override
  String get categoryTables => 'Tábilì';

  @override
  String get categoryLamps => 'Iná';

  @override
  String get categoryDecor => 'Ohun ọ̀ṣọ́';

  @override
  String get navHome => 'Ilé';

  @override
  String get navShop => 'Ṣọ́ọ̀pù';

  @override
  String get navProfile => 'Ìròyìn mi';

  @override
  String addedToCart(String productName) {
    return 'A ti fi $productName sínú akọ̀wọ́';
  }

  @override
  String get product_1_name => 'Sífà Velvet Kékeré';

  @override
  String get product_1_description =>
      'Sífà velvet tó rẹwà tó darapọ̀ mọ́ ìtùnú pẹ̀lú ọ̀nà ìgbàlódé.';

  @override
  String get product_2_name => 'Tábilì Kọfí Igi Oak';

  @override
  String get product_2_description =>
      'Tábilì kọfí igi oak gidi pẹ̀lú àpẹẹrẹ àdánidá, ó dára fún yàrá ìfọ̀kọ̀sọ̀ kankan.';

  @override
  String get product_3_name => 'Àpótí Ìfọ̀kọ̀sọ̀ Ìgbàlódé';

  @override
  String get product_3_description =>
      'Àpótí ìfọ̀kọ̀sọ̀ tí a ṣe fún ìsinmi tó ga jùlọ.';

  @override
  String get product_4_name => 'Iná Ilẹ̀ Industrial';

  @override
  String get product_4_description =>
      'Iná ilẹ̀ ọ̀nà industrial tó rẹwà pẹ̀lú gíga tí a lè yí padà.';

  @override
  String get product_5_name => 'Iṣẹ́ Ọnà Odi Abstract';

  @override
  String get product_5_description =>
      'Iṣẹ́ ọnà odi abstract ìgbàlódé láti gbé inú ilé rẹ ga.';

  @override
  String get product_6_name => 'Àpótí Accent Aláwo';

  @override
  String get product_6_description =>
      'Àpótí accent aláwo àdánidá pẹ̀lú ìrònú ìgbàlódé ti ọ̀rúndún kọkànlá.';

  @override
  String get product_7_name => 'Tábilì Oúnjẹ Marble';

  @override
  String get product_7_description =>
      'Tábilì oúnjẹ tó rẹwà pẹ̀lú marble gidi lórí rẹ̀ àti ẹsẹ̀ igi.';

  @override
  String get product_8_name => 'Sífà Modular Cloud';

  @override
  String get product_8_description =>
      'Sífà modular tó rọ̀ gan-an tó dàbí pé o jókòó lórí àwọsánmà.';

  @override
  String get product_9_name => 'Iná Tábilì Ceramic';

  @override
  String get product_9_description =>
      'Iná tábilì ceramic tí a fi ọwọ́ ṣe pẹ̀lú àpẹẹrẹ tó rẹwà.';

  @override
  String get product_10_name => 'Rọ́ọ̀gì Wool Geometric';

  @override
  String get product_10_description =>
      'Rọ́ọ̀gì wool àpẹẹrẹ geometric títóbi fún yàrá ìgbàlódé.';

  @override
  String get product_11_name => 'Àpótí Ìwé Walnut';

  @override
  String get product_11_description =>
      'Àpótí ìwé igi walnut títóbi pẹ̀lú ọ̀nà ṣíṣí sílẹ̀ tó rẹwà.';

  @override
  String get product_12_name => 'Ottoman Velvet';

  @override
  String get product_12_description =>
      'Ottoman velvet roboto tó lè ṣiṣẹ́ gẹ́gẹ́ bí ibi ìsinmi ẹsẹ̀ tàbí ibi ìjókòó àfikún.';

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';
}
