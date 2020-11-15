import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/src/model/data.dart';

import 'package:flutter_ecommerce_app/src/model/product.dart';
import 'package:flutter_ecommerce_app/src/themes/light_color.dart';
import 'package:flutter_ecommerce_app/src/widgets/title_text.dart';
import 'package:flutter_ecommerce_app/src/widgets/extentions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final ValueChanged<Product> onSelected;
  ProductCard({Key key, this.product, this.onSelected}) : super(key: key);

//   @override
//   _ProductCardState createState() => _ProductCardState();
// }

// class _ProductCardState extends State<ProductCard> {
//   Product product;
//   @override
//   void initState() {
//     product = widget.product;
//     super.initState();
//   }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: LightColor.background,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: <BoxShadow>[
          BoxShadow(color: Color(0xfff8f8f8), blurRadius: 15, spreadRadius: 10),
        ],
      ),
      margin: EdgeInsets.symmetric(vertical: !product.isSelected ? 20 : 0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              left: 0,
              top: 0,
              child: IconButton(
                icon: Icon(
                  product.isliked ? Icons.favorite : Icons.favorite_border,
                  color:
                      product.isliked ? LightColor.red : LightColor.iconColor,
                ),
                onPressed: () {},
              ),
            ),
            Column(
          mainAxisSize : MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(height: product.isSelected ? 15 : 0),
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: LightColor.orange.withAlpha(40),
                      ),
                      Image.network('http://192.168.1.7:3000/'+product.image,fit: BoxFit.contain,
        width: 150)
                    ],
                  ),
                ),
                // SizedBox(height: 5),
                TitleText(
                  text: product.nom,
                  fontSize: product.isSelected ? 16 : 14,
                ),
                TitleText(
                  text: product.category,
                  fontSize: product.isSelected ? 14 : 12,
                  color: LightColor.orange,
                ),
                TitleText(
                  text: product.prix,
                  fontSize: product.isSelected ? 18 : 16,
                ),
              ],
            ),
          ],
        ),
      ).ripple(() async {
        Navigator.of(context).pushNamed('/detail');
        AppData.product =Product(product.id, product.nom, product.category, product.description, product.prix, product.stock, product.iduser, product.image, product.isliked, product.isSelected);
                         SharedPreferences prefs = await SharedPreferences.getInstance();
                         prefs.setString("image", product.image);
                         prefs.setString("prix", product.prix);
                         prefs.setString("nom", product.nom);
                         prefs.setString("description", product.description);


print (product.nom);
        onSelected(product);
      }, borderRadius: BorderRadius.all(Radius.circular(20))),
    );
  }
}
