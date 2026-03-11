// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Shopistry';

  @override
  String get myCart => 'My Cart';

  @override
  String get subtotal => 'Subtotal';

  @override
  String get delivery => 'Delivery';

  @override
  String get deliveryFee => 'Delivery Fee';

  @override
  String get total => 'Total';

  @override
  String get proceedToCheckout => 'Proceed to Checkout';

  @override
  String get cartEmptyTitle => 'Your cart is empty';

  @override
  String get cartEmptySubtitle =>
      'Looks like you haven\'t added\nanything to your cart yet.';

  @override
  String get startExploring => 'Start Exploring';

  @override
  String get checkout => 'Checkout';

  @override
  String get deliveryAddress => 'Delivery Address';

  @override
  String get paymentMethod => 'Payment Method';

  @override
  String get orderSummary => 'Order Summary';

  @override
  String get confirmOrder => 'Confirm Order';

  @override
  String get creditCard => 'Credit Card';

  @override
  String get applePay => 'Apple Pay';

  @override
  String get payPal => 'PayPal';

  @override
  String get orderSuccessTitle => 'Order Placed Successfully!';

  @override
  String get orderSuccessSubtitle =>
      'Your furniture is on its way. We will notify you when it\'s out for delivery.';

  @override
  String get backToHome => 'Back to Home';

  @override
  String get addressHint => 'Enter your delivery address...';

  @override
  String get errorOccurred => 'An error occurred';

  @override
  String get wishlist => 'Wishlist';

  @override
  String itemsYouLove(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items you love',
      one: '1 item you love',
    );
    return '$_temp0';
  }

  @override
  String get clearWishlistTitle => 'Clear Wishlist?';

  @override
  String get clearWishlistContent =>
      'Are you sure you want to remove all items from your wishlist?';

  @override
  String get cancel => 'Cancel';

  @override
  String get clearAll => 'Clear All';

  @override
  String get wishlistEmptyTitle => 'Your wishlist is empty';

  @override
  String get wishlistEmptySubtitle =>
      'Save your favorite furniture pieces here to keep track of what you love.';

  @override
  String get discoverProducts => 'Discover Products';

  @override
  String get welcomeBack => 'Welcome back,';

  @override
  String get discoverStyle => 'Discover Style';

  @override
  String get searchHint => 'Search furniture...';

  @override
  String get newSeason => 'NEW SEASON';

  @override
  String get modernLuxuryCollection => 'Modern Luxury\nCollection';

  @override
  String get categories => 'Categories';

  @override
  String get popularProducts => 'Popular Products';

  @override
  String get viewAll => 'View All';

  @override
  String get dimensions => 'Dimensions';

  @override
  String get material => 'Material';

  @override
  String get weight => 'Weight';

  @override
  String get addToCart => 'ADD TO CART';

  @override
  String get description => 'Description';

  @override
  String get selectColor => 'Select Color';

  @override
  String get quantity => 'Quantity';

  @override
  String get similarProducts => 'Similar Products';

  @override
  String get readMore => 'Read More';

  @override
  String get readLess => 'Read Less';

  @override
  String get allProducts => 'All Products';

  @override
  String get noProductsFound => 'No products found';

  @override
  String get tryAdjustingFilters => 'Try adjusting your filters';

  @override
  String get filters => 'Filters';

  @override
  String get resetAll => 'Reset All';

  @override
  String get sortBy => 'Sort By';

  @override
  String get category => 'Category';

  @override
  String get priceRange => 'Price Range';

  @override
  String get colors => 'Colors';

  @override
  String get applyFilters => 'Apply Filters';

  @override
  String get popularity => 'Popularity';

  @override
  String get newest => 'Newest';

  @override
  String get priceLowToHigh => 'Price: Low to High';

  @override
  String get priceHighToLow => 'Price: High to Low';

  @override
  String get categoryAll => 'All';

  @override
  String get categorySofas => 'Sofas';

  @override
  String get categoryChairs => 'Chairs';

  @override
  String get categoryTables => 'Tables';

  @override
  String get categoryLamps => 'Lamps';

  @override
  String get categoryDecor => 'Decor';

  @override
  String get navHome => 'Home';

  @override
  String get navShop => 'Shop';

  @override
  String get navProfile => 'Profile';

  @override
  String addedToCart(String productName) {
    return '$productName added to cart';
  }

  @override
  String get product_1_name => 'Minimalist Velvet Sofa';

  @override
  String get product_1_description =>
      'A luxurious velvet sofa that combines comfort with a modern minimalist aesthetic.';

  @override
  String get product_2_name => 'Oak Wood Coffee Table';

  @override
  String get product_2_description =>
      'Solid oak wood coffee table with a natural finish, perfect for any living room.';

  @override
  String get product_3_name => 'Modern Lounge Chair';

  @override
  String get product_3_description =>
      'Ergonomically designed lounge chair for ultimate relaxation.';

  @override
  String get product_4_name => 'Industrial Floor Lamp';

  @override
  String get product_4_description =>
      'Sleek industrial style floor lamp with adjustable height.';

  @override
  String get product_5_name => 'Abstract Wall Art';

  @override
  String get product_5_description =>
      'Contemporary abstract wall art to elevate your interior space.';

  @override
  String get product_6_name => 'Leather Accent Chair';

  @override
  String get product_6_description =>
      'Classic leather accent chair with a mid-century modern feel.';

  @override
  String get product_7_name => 'Marble Top Dining Table';

  @override
  String get product_7_description =>
      'Elegant dining table with a solid marble top and wooden legs.';

  @override
  String get product_8_name => 'Cloud Modular Sofa';

  @override
  String get product_8_description =>
      'Extremely comfortable modular sofa that feels like sitting on a cloud.';

  @override
  String get product_9_name => 'Ceramic Table Lamp';

  @override
  String get product_9_description =>
      'Handcrafted ceramic table lamp with a textured finish.';

  @override
  String get product_10_name => 'Geometric Wool Rug';

  @override
  String get product_10_description =>
      'Large geometric pattern wool rug for a modern living space.';

  @override
  String get product_11_name => 'Walnut Bookshelf';

  @override
  String get product_11_description =>
      'Spacious walnut wood bookshelf with a sleek open-back design.';

  @override
  String get product_12_name => 'Velvet Ottoman';

  @override
  String get product_12_description =>
      'Round velvet ottoman that works as a footrest or extra seating.';

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';
}
