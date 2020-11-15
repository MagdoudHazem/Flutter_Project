import 'package:flutter_ecommerce_app/src/model/category.dart';
import 'package:flutter_ecommerce_app/src/model/product.dart';
import 'package:flutter_ecommerce_app/src/model/produit.dart';

class AppData {
  static List<Produit>list=[];
  static List<Product> productList = [];
  static List<Product> cartList = [];
  static String image ;
  static List<Category> categoryList = [
    Category(),
    Category(id:1,name: "Sneakers",image: 'assets/shoe_thumb_2.png',isSelected: true),
    Category(id:2,name: "Jacket", image: 'assets/jacket.png'),
    Category(id:3,name: "Watch", image: 'assets/watch.png'),
    Category(id:4,name: "Watch", image: 'assets/watch.png'),
  ];
  static Product product;
  static List<String> showThumbnailList = [
    "assets/shoe_thumb_5.png",
    "assets/shoe_thumb_1.png",
    "assets/shoe_thumb_4.png",
    "assets/shoe_thumb_3.png",
  ];
  static String description = "Clean lines, versatile and timeless—the people shoe returns with the Nike Air Max 90. Featuring the same iconic Waffle sole, stitched overlays and classic TPU accents you come to love, it lets you walk among the pantheon of Air. ßNothing as fly, nothing as comfortable, nothing as proven. The Nike Air Max 90 stays true to its OG running roots with the iconic Waffle sole, stitched overlays and classic TPU details. Classic colours celebrate your fresh look while Max Air cushioning adds comfort to the journey.";
}
