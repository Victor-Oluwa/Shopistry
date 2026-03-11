// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hausa (`ha`).
class AppLocalizationsHa extends AppLocalizations {
  AppLocalizationsHa([String locale = 'ha']) : super(locale);

  @override
  String get appTitle => 'Shopistry';

  @override
  String get myCart => 'Kayan saye na';

  @override
  String get subtotal => 'Jimillar ciki';

  @override
  String get delivery => 'Isarwa';

  @override
  String get deliveryFee => 'Kudin isarwa';

  @override
  String get total => 'Jimilla';

  @override
  String get proceedToCheckout => 'Ci gaba da Biya';

  @override
  String get cartEmptyTitle => 'Kayan sayenka babu komai';

  @override
  String get cartEmptySubtitle =>
      'Kamar ba ka saka komai a cikin kayan sayenka ba tukuna.';

  @override
  String get startExploring => 'Fara bincike';

  @override
  String get checkout => 'Biya';

  @override
  String get deliveryAddress => 'Adireshin isarwa';

  @override
  String get paymentMethod => 'Hanyar biya';

  @override
  String get orderSummary => 'Takaitaccen oda';

  @override
  String get confirmOrder => 'Tabbatar da oda';

  @override
  String get creditCard => 'Katin banki';

  @override
  String get applePay => 'Apple Pay';

  @override
  String get payPal => 'PayPal';

  @override
  String get orderSuccessTitle => 'An yi oda cikin nasara!';

  @override
  String get orderSuccessSubtitle =>
      'Kayanka suna kan hanya. Za mu sanar da kai idan sun iso.';

  @override
  String get backToHome => 'Koma Gida';

  @override
  String get addressHint => 'Shigar da adireshin isarwarka...';

  @override
  String get errorOccurred => 'An sami matsala';

  @override
  String get wishlist => 'Abubuwan sha\'awa';

  @override
  String itemsYouLove(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Abubuwa $count da kake so',
      one: 'Abu 1 da kake so',
    );
    return '$_temp0';
  }

  @override
  String get clearWishlistTitle => 'Goge abubuwan sha\'awa?';

  @override
  String get clearWishlistContent =>
      'Ka tabbata kana son goge duk abubuwan da ke cikin jerin sha\'awarka?';

  @override
  String get cancel => 'Soke';

  @override
  String get clearAll => 'Goge duka';

  @override
  String get wishlistEmptyTitle => 'Jerin sha\'awarka babu komai';

  @override
  String get wishlistEmptySubtitle =>
      'Ajiye kayan da kake so a nan don samunsu cikin sauki.';

  @override
  String get discoverProducts => 'Gano kayayyaki';

  @override
  String get welcomeBack => 'Barka da dawowa,';

  @override
  String get discoverStyle => 'Gano Salonka';

  @override
  String get searchHint => 'Nemi kaya...';

  @override
  String get newSeason => 'SABON LOKACI';

  @override
  String get modernLuxuryCollection => 'Kayan Alfarma';

  @override
  String get categories => 'Rukuni';

  @override
  String get popularProducts => 'Kayayyaki sanannu';

  @override
  String get viewAll => 'Duba duka';

  @override
  String get dimensions => 'Girma';

  @override
  String get material => 'Abun da aka yi da shi';

  @override
  String get weight => 'Nauyi';

  @override
  String get addToCart => 'SAKA A KAYAN SAYE';

  @override
  String get description => 'Bayanin kaya';

  @override
  String get selectColor => 'Zabi launi';

  @override
  String get quantity => 'Yawa';

  @override
  String get similarProducts => 'Kayan da suka yi kama';

  @override
  String get readMore => 'Kara karantawa';

  @override
  String get readLess => 'Rage karantawa';

  @override
  String get allProducts => 'Duk kayayyaki';

  @override
  String get noProductsFound => 'Ba a sami kaya ba';

  @override
  String get tryAdjustingFilters => 'Gwada canza matatunka';

  @override
  String get filters => 'Matattu';

  @override
  String get resetAll => 'Sake duka';

  @override
  String get sortBy => 'Tsara ta';

  @override
  String get category => 'Rukuni';

  @override
  String get priceRange => 'Farashi';

  @override
  String get colors => 'Launuka';

  @override
  String get applyFilters => 'Yi amfani da matattu';

  @override
  String get popularity => 'Shahara';

  @override
  String get newest => 'Sababbi';

  @override
  String get priceLowToHigh => 'Farashi: Kadan zuwa Da yawa';

  @override
  String get priceHighToLow => 'Farashi: Da yawa zuwa Kadan';

  @override
  String get categoryAll => 'Duka';

  @override
  String get categorySofas => 'Kujeru';

  @override
  String get categoryChairs => 'Kujeru';

  @override
  String get categoryTables => 'Tebura';

  @override
  String get categoryLamps => 'Fitulu';

  @override
  String get categoryDecor => 'Kayan ado';

  @override
  String get navHome => 'Gida';

  @override
  String get navShop => 'Shago';

  @override
  String get navProfile => 'Bayanan mutum';

  @override
  String addedToCart(String productName) {
    return 'An saka $productName a kayan saye';
  }

  @override
  String get product_1_name => 'Sofa Mai Kyau';

  @override
  String get product_1_description =>
      'Wata kyakkyawar sofa mai laushi wacce ta hada jin dadi da salon zamani.';

  @override
  String get product_2_name => 'Teburin Kofi na Oak';

  @override
  String get product_2_description =>
      'Teburin kofi na katako mai karfi, mai kyau ga kowane dakin zama.';

  @override
  String get product_3_name => 'Kujerar Hutawa ta Zamani';

  @override
  String get product_3_description =>
      'Kujerar hutawa da aka tsara don cikakken shakatawa.';

  @override
  String get product_4_name => 'Fitilar Kasa ta Industrial';

  @override
  String get product_4_description =>
      'Kyakkyawar fitilar kasa ta salon industrial mai daidaitaccen tsayi.';

  @override
  String get product_5_name => 'Zane na Bango';

  @override
  String get product_5_description =>
      'Zanen bango na zamani don kawata cikin gidanka.';

  @override
  String get product_6_name => 'Kujerar Fata';

  @override
  String get product_6_description =>
      'Kujerar fata ta gargajiya mai dauke da salon zamani na karni na tsakiya.';

  @override
  String get product_7_name => 'Teburin Cin Abinci na Marble';

  @override
  String get product_7_description =>
      'Kyakkyawan teburin cin abinci mai saman marmara da kafafun katako.';

  @override
  String get product_8_name => 'Cloud Modular Sofa';

  @override
  String get product_8_description =>
      'Sofa mai dadi sosai wacce kake jin kamar kana zaune akan gajimare.';

  @override
  String get product_9_name => 'Fitilar Tebur ta Ceramic';

  @override
  String get product_9_description =>
      'Fitilar tebur ta ceramic da aka yi da hannu mai kyakkyawan tsari.';

  @override
  String get product_10_name => 'Katifar Wool ta Geometric';

  @override
  String get product_10_description =>
      'Babban katifar wool mai tsarin geometric don dakin zama na zamani.';

  @override
  String get product_11_name => 'Ma\'ajiyar Littattafai ta Walnut';

  @override
  String get product_11_description =>
      'Ma\'ajiyar littattafai ta katako mai fadi tare da kyakkyawan tsari.';

  @override
  String get product_12_name => 'Velvet Ottoman';

  @override
  String get product_12_description =>
      'Ottoman na velvet mai zagaye wanda ke aiki azaman wurin huta kafa ko karin wurin zama.';

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';
}
