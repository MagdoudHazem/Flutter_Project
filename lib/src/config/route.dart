import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/src/pages/AddProduct.dart';
import 'package:flutter_ecommerce_app/src/pages/Login.dart';
import 'package:flutter_ecommerce_app/src/pages/ProfilePage%20.dart';
import 'package:flutter_ecommerce_app/src/pages/mainPage.dart';
import 'package:flutter_ecommerce_app/src/pages/myproduct.dart';
import 'package:flutter_ecommerce_app/src/pages/product_detail.dart';
import 'package:flutter_ecommerce_app/src/pages/register.dart';
import 'package:flutter_ecommerce_app/src/widgets/customRoute.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoute() {
    return <String, WidgetBuilder>{
      '/': (_) => MainPage(),
       '/detail': (_) => ProductDetailPage()
    };
  }
}

const String MainPageRoute = "/mainPage";
const String DetailPageRoute="/detail";
const String LoginPageRoute="/login";
const String ProfilePageRoute="/profile";
const String AddProductRoute="/addproduct";
const String RegisterRoute="/regiter";
const String MyproductRoute="/myproduct";
Route<dynamic> onGenerateRoute(RouteSettings settings) {
        if (settings.name.contains('detail')) {
          return CustomRoute<bool>(
              builder: (BuildContext context) => ProductDetailPage());
        } else if(settings.name.contains(LoginPageRoute))
        {
return  CustomRoute<bool>(
              builder: (BuildContext context) => Login());
        }
        else if (settings.name.contains(ProfilePageRoute)){
          return  CustomRoute<bool>(
              builder: (BuildContext context) => ProfilePage());
        }
        else if (settings.name.contains(AddProductRoute))
        {
 return  CustomRoute<bool>(
              builder: (BuildContext context) => AddProduct());
        }
        else if (settings.name.contains(RegisterRoute)){
        
          return  CustomRoute<bool>(
builder: (BuildContext context) => Register());
      
        }
        else if (settings.name.contains(MyproductRoute))
        {
           return  CustomRoute<bool>(
builder: (BuildContext context) => Myproduct());

        }
        
         else{
          return CustomRoute<bool>(
              builder: (BuildContext context) => MainPage());
        }
}