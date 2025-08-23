import 'package:flutter/material.dart';
import 'package:laza/Features/Address/provider/addressProvider.dart';
import 'package:laza/Features/SpalshScreen/SplashScreen.dart';
import 'package:laza/Providers/bottom_buttom_provider.dart';
import 'package:laza/Features/Card/Providers/card-type-provider.dart';
import 'package:laza/Features/Card/Providers/card_form_provider.dart';
import 'package:laza/Features/Card/Providers/card_submitButton_provider.dart';
import 'package:laza/Features/Cart/providers/cart_product_count_provider.dart';
import 'package:laza/Features/Home/provider/home-provider.dart';
import 'package:laza/Features/Product_DetailScreen/provider/product_detail_provider.dart';
import 'package:laza/Features/Reviews/providers/size_selector_provider.dart';
import 'package:laza/Providers/textfeild_tick_provider.dart';
import 'package:laza/Providers/theme_provider.dart';
import 'package:laza/Features/WishList/providers/wishList_provider.dart';
import 'package:laza/Resources/Colors/Colors.dart';
import 'package:provider/provider.dart';
import 'package:laza/Features/Cart/providers/cart_add_product.dart';
import 'package:laza/Features/Cart/providers/cart_item_delete_provider.dart';
import 'package:laza/Features/Home/provider/search_provider.dart';
import 'package:laza/Features/Reviews/providers/star_slider_provider.dart';
import 'package:laza/Providers/timer_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:laza/firebase_options.dart';
import 'Features/ai_bot_module/ai_repo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //  if (FirebaseAuth.instance.currentUser == null) {
  //   await FirebaseAuth.instance.signInAnonymously();
  // }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Existing providers
        // ChangeNotifierProvider(create: (_) => GenderProvider()),
        ChangeNotifierProvider(create: (_) => TimerProvider()),
        // ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => ProductDetailProvider()),
        ChangeNotifierProvider(create: (_) => SizeSelectorProvider()),
        ChangeNotifierProvider(create: (_) => StarSliderProvider()),
        // ChangeNotifierProvider(create: (_) => CardTypeProvider()),
        ChangeNotifierProvider(create: (_) => CartItemDeleteProvider()),
        ChangeNotifierProvider(create: (_) => CartProductcountProvider()),
        ChangeNotifierProvider(create: (_) => TextfeildTickProvider()),
        ChangeNotifierProvider(create: (_) => WishlistProvider()),
        ChangeNotifierProvider(create: (_) => Addressprovider()),
        ChangeNotifierProvider(create: (_) => HomeScreenProvvider()),
        ChangeNotifierProvider(create: (_) => CartAddProductProvider()),
        // ChangeNotifierProvider(create: (_) => ReviewProvider()), // Uncomment if needed
        ChangeNotifierProvider(create: (_) => SearchProvider()),
        ChangeNotifierProvider(create: (_) => BottomButtomProvider()),
        ChangeNotifierProvider(create: (context) => CardTypeProvider()),
        ChangeNotifierProvider(create: (context) => CardFormProvider()),
        ChangeNotifierProvider(create: (context) => SubmitButtonProvider()),
        ChangeNotifierProvider(create: (context) => BottomButtomProvider()),
        // Add other providers here
        // New providers for AI chat functionality
        // Provider<GetStorage>(
        //   create: (_) {
        //     GetStorage.init();
        //     return GetStorage();
        //   },
        // ),
        // Provider<Dio>(
        //   create: (_) => Dio(BaseOptions(
        //     baseUrl: GlobalVariables.baseApiUrl,
        //     connectTimeout: const Duration(seconds: 10),
        //     receiveTimeout: const Duration(seconds: 10),
        //   )),
        // ),
        // Provider<ApiClient>(
        //   create: (context) =>
        //       ApiClient(Provider.of<Dio>(context, listen: false)),
        // ),
        // Provider<AIRepository>(
        //   create: (context) => AIRepository(),
        // ),
        // Add AIChatController as a ChangeNotifierProvider if it needs to persist across screens
        ChangeNotifierProvider(create: (_) => AIChatController()),
      ],
      child: MaterialApp(
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        darkTheme: ThemeData(
          appBarTheme: const AppBarTheme(
            foregroundColor: MyColor.textBlack,
          ),
          brightness: Brightness.dark,
        ),
        theme: ThemeData(
          focusColor: Colors.transparent,
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          appBarTheme: const AppBarTheme(
            backgroundColor: MyColor.white,
            foregroundColor: MyColor.white,
            surfaceTintColor: MyColor.white,
          ),
          scaffoldBackgroundColor: MyColor.white,
          brightness: Brightness.light,
        ),
        // home: ProductUploadPage(),
        home: const Splashscreen(),
        // home: const AIChatView(),
        // home :  const MedCareOnboardingScreen() ,
      ),
    );
  }
}
