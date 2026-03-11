import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ha.dart';
import 'app_localizations_ig.dart';
import 'app_localizations_yo.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ha'),
    Locale('ig'),
    Locale('yo'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Shopistry'**
  String get appTitle;

  /// No description provided for @myCart.
  ///
  /// In en, this message translates to:
  /// **'My Cart'**
  String get myCart;

  /// No description provided for @subtotal.
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get subtotal;

  /// No description provided for @delivery.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get delivery;

  /// No description provided for @deliveryFee.
  ///
  /// In en, this message translates to:
  /// **'Delivery Fee'**
  String get deliveryFee;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @proceedToCheckout.
  ///
  /// In en, this message translates to:
  /// **'Proceed to Checkout'**
  String get proceedToCheckout;

  /// No description provided for @cartEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Your cart is empty'**
  String get cartEmptyTitle;

  /// No description provided for @cartEmptySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Looks like you haven\'t added\nanything to your cart yet.'**
  String get cartEmptySubtitle;

  /// No description provided for @startExploring.
  ///
  /// In en, this message translates to:
  /// **'Start Exploring'**
  String get startExploring;

  /// No description provided for @checkout.
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get checkout;

  /// No description provided for @deliveryAddress.
  ///
  /// In en, this message translates to:
  /// **'Delivery Address'**
  String get deliveryAddress;

  /// No description provided for @paymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get paymentMethod;

  /// No description provided for @orderSummary.
  ///
  /// In en, this message translates to:
  /// **'Order Summary'**
  String get orderSummary;

  /// No description provided for @confirmOrder.
  ///
  /// In en, this message translates to:
  /// **'Confirm Order'**
  String get confirmOrder;

  /// No description provided for @creditCard.
  ///
  /// In en, this message translates to:
  /// **'Credit Card'**
  String get creditCard;

  /// No description provided for @applePay.
  ///
  /// In en, this message translates to:
  /// **'Apple Pay'**
  String get applePay;

  /// No description provided for @payPal.
  ///
  /// In en, this message translates to:
  /// **'PayPal'**
  String get payPal;

  /// No description provided for @orderSuccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Order Placed Successfully!'**
  String get orderSuccessTitle;

  /// No description provided for @orderSuccessSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your furniture is on its way. We will notify you when it\'s out for delivery.'**
  String get orderSuccessSubtitle;

  /// No description provided for @backToHome.
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get backToHome;

  /// No description provided for @addressHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your delivery address...'**
  String get addressHint;

  /// No description provided for @errorOccurred.
  ///
  /// In en, this message translates to:
  /// **'An error occurred'**
  String get errorOccurred;

  /// No description provided for @wishlist.
  ///
  /// In en, this message translates to:
  /// **'Wishlist'**
  String get wishlist;

  /// No description provided for @itemsYouLove.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 item you love} other{{count} items you love}}'**
  String itemsYouLove(int count);

  /// No description provided for @clearWishlistTitle.
  ///
  /// In en, this message translates to:
  /// **'Clear Wishlist?'**
  String get clearWishlistTitle;

  /// No description provided for @clearWishlistContent.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to remove all items from your wishlist?'**
  String get clearWishlistContent;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @clearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear All'**
  String get clearAll;

  /// No description provided for @wishlistEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Your wishlist is empty'**
  String get wishlistEmptyTitle;

  /// No description provided for @wishlistEmptySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Save your favorite furniture pieces here to keep track of what you love.'**
  String get wishlistEmptySubtitle;

  /// No description provided for @discoverProducts.
  ///
  /// In en, this message translates to:
  /// **'Discover Products'**
  String get discoverProducts;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back,'**
  String get welcomeBack;

  /// No description provided for @discoverStyle.
  ///
  /// In en, this message translates to:
  /// **'Discover Style'**
  String get discoverStyle;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search furniture...'**
  String get searchHint;

  /// No description provided for @newSeason.
  ///
  /// In en, this message translates to:
  /// **'NEW SEASON'**
  String get newSeason;

  /// No description provided for @modernLuxuryCollection.
  ///
  /// In en, this message translates to:
  /// **'Modern Luxury\nCollection'**
  String get modernLuxuryCollection;

  /// No description provided for @categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// No description provided for @popularProducts.
  ///
  /// In en, this message translates to:
  /// **'Popular Products'**
  String get popularProducts;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAll;

  /// No description provided for @dimensions.
  ///
  /// In en, this message translates to:
  /// **'Dimensions'**
  String get dimensions;

  /// No description provided for @material.
  ///
  /// In en, this message translates to:
  /// **'Material'**
  String get material;

  /// No description provided for @weight.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get weight;

  /// No description provided for @addToCart.
  ///
  /// In en, this message translates to:
  /// **'ADD TO CART'**
  String get addToCart;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @selectColor.
  ///
  /// In en, this message translates to:
  /// **'Select Color'**
  String get selectColor;

  /// No description provided for @quantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get quantity;

  /// No description provided for @similarProducts.
  ///
  /// In en, this message translates to:
  /// **'Similar Products'**
  String get similarProducts;

  /// No description provided for @readMore.
  ///
  /// In en, this message translates to:
  /// **'Read More'**
  String get readMore;

  /// No description provided for @readLess.
  ///
  /// In en, this message translates to:
  /// **'Read Less'**
  String get readLess;

  /// No description provided for @allProducts.
  ///
  /// In en, this message translates to:
  /// **'All Products'**
  String get allProducts;

  /// No description provided for @noProductsFound.
  ///
  /// In en, this message translates to:
  /// **'No products found'**
  String get noProductsFound;

  /// No description provided for @tryAdjustingFilters.
  ///
  /// In en, this message translates to:
  /// **'Try adjusting your filters'**
  String get tryAdjustingFilters;

  /// No description provided for @filters.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get filters;

  /// No description provided for @resetAll.
  ///
  /// In en, this message translates to:
  /// **'Reset All'**
  String get resetAll;

  /// No description provided for @sortBy.
  ///
  /// In en, this message translates to:
  /// **'Sort By'**
  String get sortBy;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @priceRange.
  ///
  /// In en, this message translates to:
  /// **'Price Range'**
  String get priceRange;

  /// No description provided for @colors.
  ///
  /// In en, this message translates to:
  /// **'Colors'**
  String get colors;

  /// No description provided for @applyFilters.
  ///
  /// In en, this message translates to:
  /// **'Apply Filters'**
  String get applyFilters;

  /// No description provided for @popularity.
  ///
  /// In en, this message translates to:
  /// **'Popularity'**
  String get popularity;

  /// No description provided for @newest.
  ///
  /// In en, this message translates to:
  /// **'Newest'**
  String get newest;

  /// No description provided for @priceLowToHigh.
  ///
  /// In en, this message translates to:
  /// **'Price: Low to High'**
  String get priceLowToHigh;

  /// No description provided for @priceHighToLow.
  ///
  /// In en, this message translates to:
  /// **'Price: High to Low'**
  String get priceHighToLow;

  /// No description provided for @categoryAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get categoryAll;

  /// No description provided for @categorySofas.
  ///
  /// In en, this message translates to:
  /// **'Sofas'**
  String get categorySofas;

  /// No description provided for @categoryChairs.
  ///
  /// In en, this message translates to:
  /// **'Chairs'**
  String get categoryChairs;

  /// No description provided for @categoryTables.
  ///
  /// In en, this message translates to:
  /// **'Tables'**
  String get categoryTables;

  /// No description provided for @categoryLamps.
  ///
  /// In en, this message translates to:
  /// **'Lamps'**
  String get categoryLamps;

  /// No description provided for @categoryDecor.
  ///
  /// In en, this message translates to:
  /// **'Decor'**
  String get categoryDecor;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navShop.
  ///
  /// In en, this message translates to:
  /// **'Shop'**
  String get navShop;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @addedToCart.
  ///
  /// In en, this message translates to:
  /// **'{productName} added to cart'**
  String addedToCart(String productName);

  /// No description provided for @product_1_name.
  ///
  /// In en, this message translates to:
  /// **'Minimalist Velvet Sofa'**
  String get product_1_name;

  /// No description provided for @product_1_description.
  ///
  /// In en, this message translates to:
  /// **'A luxurious velvet sofa that combines comfort with a modern minimalist aesthetic.'**
  String get product_1_description;

  /// No description provided for @product_2_name.
  ///
  /// In en, this message translates to:
  /// **'Oak Wood Coffee Table'**
  String get product_2_name;

  /// No description provided for @product_2_description.
  ///
  /// In en, this message translates to:
  /// **'Solid oak wood coffee table with a natural finish, perfect for any living room.'**
  String get product_2_description;

  /// No description provided for @product_3_name.
  ///
  /// In en, this message translates to:
  /// **'Modern Lounge Chair'**
  String get product_3_name;

  /// No description provided for @product_3_description.
  ///
  /// In en, this message translates to:
  /// **'Ergonomically designed lounge chair for ultimate relaxation.'**
  String get product_3_description;

  /// No description provided for @product_4_name.
  ///
  /// In en, this message translates to:
  /// **'Industrial Floor Lamp'**
  String get product_4_name;

  /// No description provided for @product_4_description.
  ///
  /// In en, this message translates to:
  /// **'Sleek industrial style floor lamp with adjustable height.'**
  String get product_4_description;

  /// No description provided for @product_5_name.
  ///
  /// In en, this message translates to:
  /// **'Abstract Wall Art'**
  String get product_5_name;

  /// No description provided for @product_5_description.
  ///
  /// In en, this message translates to:
  /// **'Contemporary abstract wall art to elevate your interior space.'**
  String get product_5_description;

  /// No description provided for @product_6_name.
  ///
  /// In en, this message translates to:
  /// **'Leather Accent Chair'**
  String get product_6_name;

  /// No description provided for @product_6_description.
  ///
  /// In en, this message translates to:
  /// **'Classic leather accent chair with a mid-century modern feel.'**
  String get product_6_description;

  /// No description provided for @product_7_name.
  ///
  /// In en, this message translates to:
  /// **'Marble Top Dining Table'**
  String get product_7_name;

  /// No description provided for @product_7_description.
  ///
  /// In en, this message translates to:
  /// **'Elegant dining table with a solid marble top and wooden legs.'**
  String get product_7_description;

  /// No description provided for @product_8_name.
  ///
  /// In en, this message translates to:
  /// **'Cloud Modular Sofa'**
  String get product_8_name;

  /// No description provided for @product_8_description.
  ///
  /// In en, this message translates to:
  /// **'Extremely comfortable modular sofa that feels like sitting on a cloud.'**
  String get product_8_description;

  /// No description provided for @product_9_name.
  ///
  /// In en, this message translates to:
  /// **'Ceramic Table Lamp'**
  String get product_9_name;

  /// No description provided for @product_9_description.
  ///
  /// In en, this message translates to:
  /// **'Handcrafted ceramic table lamp with a textured finish.'**
  String get product_9_description;

  /// No description provided for @product_10_name.
  ///
  /// In en, this message translates to:
  /// **'Geometric Wool Rug'**
  String get product_10_name;

  /// No description provided for @product_10_description.
  ///
  /// In en, this message translates to:
  /// **'Large geometric pattern wool rug for a modern living space.'**
  String get product_10_description;

  /// No description provided for @product_11_name.
  ///
  /// In en, this message translates to:
  /// **'Walnut Bookshelf'**
  String get product_11_name;

  /// No description provided for @product_11_description.
  ///
  /// In en, this message translates to:
  /// **'Spacious walnut wood bookshelf with a sleek open-back design.'**
  String get product_11_description;

  /// No description provided for @product_12_name.
  ///
  /// In en, this message translates to:
  /// **'Velvet Ottoman'**
  String get product_12_name;

  /// No description provided for @product_12_description.
  ///
  /// In en, this message translates to:
  /// **'Round velvet ottoman that works as a footrest or extra seating.'**
  String get product_12_description;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ha', 'ig', 'yo'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ha':
      return AppLocalizationsHa();
    case 'ig':
      return AppLocalizationsIg();
    case 'yo':
      return AppLocalizationsYo();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
