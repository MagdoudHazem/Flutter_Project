import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/src/config/route.dart' as routes;
import 'package:flutter_ecommerce_app/src/pages/mainPage.dart';
import 'package:flutter_ecommerce_app/src/pages/product_detail.dart';
import 'package:flutter_ecommerce_app/src/widgets/customRoute.dart';
import 'package:google_fonts/google_fonts.dart';


import 'src/themes/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Commerce ',
      theme: AppTheme.lightTheme.copyWith(
        textTheme: GoogleFonts.muliTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      debugShowCheckedModeBanner: false,
      routes: routes.Routes.getRoute(),
      onGenerateRoute: routes.onGenerateRoute,
      initialRoute: routes.LoginPageRoute,
    );
  }
}
