import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/src/data/api_client.dart';
import 'package:flutter_ecommerce_app/src/model/data.dart';
import 'package:flutter_ecommerce_app/src/model/product.dart';
import 'package:flutter_ecommerce_app/src/model/produit.dart';
import 'package:flutter_ecommerce_app/src/themes/light_color.dart';
import 'package:flutter_ecommerce_app/src/themes/theme.dart';
import 'package:flutter_ecommerce_app/src/widgets/title_text.dart';
import 'package:flutter_ecommerce_app/src/config/route.dart' as routes;


class Myproduct extends StatelessWidget {
  const Myproduct({Key key}) : super(key: key);

  Widget _cartItems()  {
                    ApiClient apiClient = ApiClient();

                 

    return Column(children: AppData.list.map((x) => _item(x)).toList());
  }
 /* Widget _cartItems()  {
    ApiClient apiClient = ApiClient();
    
    return FutureBuilder<dynamic>(
      future: apiClient.getMyproduct(1),
      
      builder: (BuildContext context, AsyncSnapshot <dynamic>  snapshot) {
        if(snapshot.hasData){

     
         for (var u in jsonDecode(snapshot.data))
         {
           Produit pr =  Produit(u["id"],u["nom"],u["category"],u["description"],u["prix"],u["stock"],u["iduser"],u["image"]);
           AppData.list.add(pr);

         }

         
          return Column(children:  AppData.list.map((x) => _item(x)).toList());
        }else {
          return Container();
        }
      },
    );
}*/

  Widget _item(Produit model) {
    return Container(
      height: 80,
      child: Row(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1.2,
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    height: 70,
                    width: 70,
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            decoration: BoxDecoration(
                                color: LightColor.lightGrey,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: -20,
                  bottom: -20,
                  child: Image.network('http://192.168.1.7:3000/'+model.image,fit: BoxFit.contain,
        width: 150),
                )
              ],
            ),
          ),
          Expanded(
              child: ListTile(
                onLongPress: ()
                async { 
                                  ApiClient apiClient = ApiClient();
bool isdeleted = await apiClient.deleteProduct(model.id) ;
                  for (var u in AppData.list)
                {if (u.id ==model.id)
                {
                  AppData.list.remove(u);

                }

                }

              _cartItems();
                  print("deleted");
                },
                  title: TitleText(
                    text: model.nom,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                  subtitle: Row(
                    children: <Widget>[
                      TitleText(
                        text: '\$ ',
                        color: LightColor.red,
                        fontSize: 12,
                      ),
                      TitleText(
                        text: model.prix.toString(),
                        fontSize: 14,
                      ),
                    ],
                  ),
                  trailing: Container(
                    width: 35,
                    height: 35,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: LightColor.lightGrey.withAlpha(150),
                        borderRadius: BorderRadius.circular(10)),
                    child: TitleText(
                      text: 'Delete',
                      color: LightColor.red,
                      fontSize: 10,
                      
                    ),
                  )))
        ],
      ),
    );
  }

  Widget _price() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        TitleText(
          text: '${AppData.list.length} Items',
          color: LightColor.grey,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        TitleText(
          text: '\$${getPrice()}',
          fontSize: 18,
        ),
      ],
    );
  }

 
  double getPrice() {
    double price = 0;
    AppData.list.forEach((x) {
      price +=double.parse(x.prix)  * x.stock;
    });
    return price;
  }

  @override
  Widget build(BuildContext context){
    return Container(
      padding: AppTheme.padding,
      child: SingleChildScrollView(
        child: Column(
          children:  <Widget>[
            
            _cartItems(),
            Divider(
              thickness: 1,
              height: 70,
            ),
            _price(),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
  
}
