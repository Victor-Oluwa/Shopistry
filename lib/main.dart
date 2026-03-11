import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'l10n/app_localizations.dart';
import 'core/theme/app_theme.dart';
import 'core/localization/locale_cubit.dart';
import 'core/localization/fallback_localizations.dart';
import 'features/home/presentation/bloc/products_bloc.dart';
import 'features/home/presentation/bloc/products_event.dart';
import 'features/cart/presentation/bloc/cart_bloc.dart';
import 'features/checkout/presentation/bloc/checkout_bloc.dart';
import 'features/favorites/presentation/bloc/favorites_bloc.dart';
import 'features/home/presentation/pages/main_scaffold.dart';
import 'features/home/data/repositories/product_repository_impl.dart';
import 'features/home/domain/usecases/get_products.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set status bar to transparent
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));

  runApp(
    const ProviderScope(
      child: ShopistryApp(),
    ),
  );
}

class ShopistryApp extends StatelessWidget {
  const ShopistryApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initializing dependencies
    final productRepository = ProductRepositoryImpl();
    final getProducts = GetProducts(productRepository);

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => LocaleCubit()),
            BlocProvider(
              create: (context) => ProductsBloc(getProducts: getProducts)..add(LoadProducts()),
            ),
            BlocProvider(
              create: (context) => CartBloc(),
            ),
            BlocProvider(
              create: (context) => CheckoutBloc(),
            ),
            BlocProvider(
              create: (context) => FavoritesBloc(),
            ),
          ],
          child: BlocBuilder<LocaleCubit, Locale>(
            builder: (context, locale) {
              return MaterialApp(
                locale: locale,
                onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
                debugShowCheckedModeBanner: false,
                theme: AppTheme.darkTheme,
                themeMode: ThemeMode.dark,
                localizationsDelegates: const [
                  ...AppLocalizations.localizationsDelegates,
                  FallbackMaterialLocalizationsDelegate(),
                  FallbackCupertinoLocalizationsDelegate(),
                  FallbackWidgetsLocalizationsDelegate(),
                ],
                supportedLocales: AppLocalizations.supportedLocales,
                home: const MainScaffold(),
              );
            },
          ),
        );
      },
    );
  }
}
