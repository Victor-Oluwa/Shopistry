// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Igbo (`ig`).
class AppLocalizationsIg extends AppLocalizations {
  AppLocalizationsIg([String locale = 'ig']) : super(locale);

  @override
  String get appTitle => 'Shopistry';

  @override
  String get myCart => 'Ngwongwo m';

  @override
  String get subtotal => 'Mkpokọta n\'okpuru';

  @override
  String get delivery => 'Nzipu';

  @override
  String get deliveryFee => 'Ụgwọ nzipu';

  @override
  String get total => 'Mkpokọta';

  @override
  String get proceedToCheckout => 'Gaa n\'ihu n\'ịkwụ ụgwọ';

  @override
  String get cartEmptyTitle => 'Akpa gị tọrọ chakoo';

  @override
  String get cartEmptySubtitle => 'Ọ dị ka ị tinyebeghị ncha n\'akpa gị.';

  @override
  String get startExploring => 'Malite ilegharị anya';

  @override
  String get checkout => 'Ịkwụ ụgwọ';

  @override
  String get deliveryAddress => 'Adreesị nzipu';

  @override
  String get paymentMethod => 'Ụzọ ịkwụ ụgwọ';

  @override
  String get orderSummary => 'Nchịkọta iwu';

  @override
  String get confirmOrder => 'Kwado iwu';

  @override
  String get creditCard => 'Kaadị akụ';

  @override
  String get applePay => 'Apple Pay';

  @override
  String get payPal => 'PayPal';

  @override
  String get orderSuccessTitle => 'Emere iwu nke ọma!';

  @override
  String get orderSuccessSubtitle =>
      'Ngwongwo gị nọ n\'ụzọ. Anyị ga-agwa gị mgbe ọ bịarutere.';

  @override
  String get backToHome => 'Laghachi n\'ụlọ';

  @override
  String get addressHint => 'Tinye adreesị nzipu gị...';

  @override
  String get errorOccurred => 'Njehie mere';

  @override
  String get wishlist => 'Ndepụta ọchịchọ';

  @override
  String itemsYouLove(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Ihe $count ị hụrụ n\'anya',
      one: 'Ihe 1 ị hụrụ n\'anya',
    );
    return '$_temp0';
  }

  @override
  String get clearWishlistTitle => 'Ihichapụ ndepụta ọchịchọ?';

  @override
  String get clearWishlistContent =>
      'Ị doro anya na ị chọrọ iwepụ ihe niile na ndepụta ọchịchọ gị?';

  @override
  String get cancel => 'Kagbuo';

  @override
  String get clearAll => 'Hichapụ ihe niile';

  @override
  String get wishlistEmptyTitle => 'Ndepụta ọchịchọ gị tọrọ chakoo';

  @override
  String get wishlistEmptySubtitle =>
      'Chekwaa ihe ndị ị hụrụ n\'anya ebe a iji hụ ha ọzọ.';

  @override
  String get discoverProducts => 'Chọpụta ngwaahịa';

  @override
  String get welcomeBack => 'Nnọọ ọzọ,';

  @override
  String get discoverStyle => 'Chọpụta ụdị';

  @override
  String get searchHint => 'Chọọ ngwongwo...';

  @override
  String get newSeason => 'OGE ỌHỤRỤ';

  @override
  String get modernLuxuryCollection => 'Nchịkọta Ọmarịcha';

  @override
  String get categories => 'Ụdị dị iche iche';

  @override
  String get popularProducts => 'Ngwaahịa ndị mmadụ hụrụ n\'anya';

  @override
  String get viewAll => 'Lee ihe niile';

  @override
  String get dimensions => 'Akụkụ';

  @override
  String get material => 'Ihe eji mee ya';

  @override
  String get weight => 'Arọ';

  @override
  String get addToCart => 'TINYE N\'AKPA';

  @override
  String get description => 'Nkọwa';

  @override
  String get selectColor => 'Họrọ agba';

  @override
  String get quantity => 'Iye';

  @override
  String get similarProducts => 'Ngwaahịa yiri ya';

  @override
  String get readMore => 'Gụkwuo';

  @override
  String get readLess => 'Gụọ obere';

  @override
  String get allProducts => 'Ngwaahịa niile';

  @override
  String get noProductsFound => 'Ahụghị ngwaahịa ọ bụla';

  @override
  String get tryAdjustingFilters => 'Gbalịa gbanwee asacha gị';

  @override
  String get filters => 'Asacha';

  @override
  String get resetAll => 'Tọgharịa ihe niile';

  @override
  String get sortBy => 'Hazie site na';

  @override
  String get category => 'Ụdị';

  @override
  String get priceRange => 'Ọnụ ahịa';

  @override
  String get colors => 'Agba';

  @override
  String get applyFilters => 'Tinye asacha';

  @override
  String get popularity => 'Ọkachasị';

  @override
  String get newest => 'Nke kachasị ọhụrụ';

  @override
  String get priceLowToHigh => 'Ọnụ ahịa: Obere gaa na Nnukwu';

  @override
  String get priceHighToLow => 'Ọnụ ahịa: Nnukwu gaa na Obere';

  @override
  String get categoryAll => 'Niile';

  @override
  String get categorySofas => 'Sofa';

  @override
  String get categoryChairs => 'Oche';

  @override
  String get categoryTables => 'Tebụl';

  @override
  String get categoryLamps => 'Oriọna';

  @override
  String get categoryDecor => 'Ihe ịchọ mma';

  @override
  String get navHome => 'Ụlọ';

  @override
  String get navShop => 'Ụlọ ahịa';

  @override
  String get navProfile => 'Profaịlụ';

  @override
  String addedToCart(String productName) {
    return 'Atinyela $productName n\'akpa';
  }

  @override
  String get product_1_name => 'Sofa Velvet Kacha Obere';

  @override
  String get product_1_description =>
      'Sofa velvet mara mma nke jikọtara ntụsara ahụ na ụdị ọgbara ọhụrụ.';

  @override
  String get product_2_name => 'Tebụl Kọfị Igi Oak';

  @override
  String get product_2_description =>
      'Tebụl kọfị osisi oak siri ike nwere ọdịdị okike, zuru oke maka yàrá ọ bụla.';

  @override
  String get product_3_name => 'Oche Ezumike Ọgbara Ọhụrụ';

  @override
  String get product_3_description =>
      'Oche ezumike emebere nke ọma maka izu ike kachasị elu.';

  @override
  String get product_4_name => 'Oriọna Ala Industrial';

  @override
  String get product_4_description =>
      'Oriọna ala ụdị industrial mara mma nke nwere ike ịgbanwe gịga ya.';

  @override
  String get product_5_name => 'Ihe Ọnà Odi Abstract';

  @override
  String get product_5_description =>
      'Ihe ọnà odi abstract ọgbara ọhụrụ iji gbe ihu ụlọ gị elu.';

  @override
  String get product_6_name => 'Oche Accent Akpụkpọ Anụ';

  @override
  String get product_6_description =>
      'Oche accent akpụkpọ anụ mara mma nke nwere mmetụta ọgbara ọhụrụ nke narị afọ gara aga.';

  @override
  String get product_7_name => 'Tebụl Nri Marble';

  @override
  String get product_7_description =>
      'Tebụl nri mara mma nwere marble siri ike n\'elu ya na ụkwụ osisi.';

  @override
  String get product_8_name => 'Sofa Modular Cloud';

  @override
  String get product_8_description =>
      'Sofa modular nwere ntụsara ahụ nke ukwuu nke na-adị ka ịnọ n\'elu igwe ojii.';

  @override
  String get product_9_name => 'Oriọna Tebụl Ceramic';

  @override
  String get product_9_description =>
      'Oriọna tebụl ceramic ejiri aka mee nke nwere ụdị mara mma.';

  @override
  String get product_10_name => 'Rọọgì Wool Geometric';

  @override
  String get product_10_description =>
      'Nnukwu rọọgì wool nwere ụdị geometric maka ụlọ ọgbara ọhụrụ.';

  @override
  String get product_11_name => 'Akpa Ìwé Walnut';

  @override
  String get product_11_description =>
      'Akpa ìwé osisi walnut nwere oghere zuru oke na ụdị mara mma.';

  @override
  String get product_12_name => 'Ottoman Velvet';

  @override
  String get product_12_description =>
      'Ottoman velvet gburugburu nke nwere ike ịbụ ebe ntụsara ahụ ụkwụ ma ọ bụ oche ọzọ.';

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';
}
