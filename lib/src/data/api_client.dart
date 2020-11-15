
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_ecommerce_app/src/model/data.dart';
import 'package:flutter_ecommerce_app/src/model/product.dart';
import 'package:flutter_ecommerce_app/src/model/produit.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiClient {
  String baseUrl = "http://192.168.1.7:3000";
 
  static final ApiClient _instance = ApiClient.internal();

   Dio baseDio = Dio();

  factory ApiClient() {
    return _instance;
  }

  ApiClient.internal(){
  
  baseDio.interceptors.add(PrettyDioLogger(requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));

  }
  

  Future<dynamic> saveProduct(Map<String,dynamic> product,File image ) async{
    final url = "/produit/add";

    try {
      print("$product");
      baseDio.options.headers['content-Type']='application/json';
      
      Response response = await baseDio.post(this.baseUrl+url,data: product);
      
      return true ;
    }on DioError catch(e){
      print(e.error);
      return false;
    }
  }
Future<bool>deleteProduct(int id) async
{
final url ="/produit/delete/";
try{
        baseDio.options.headers['content-Type']='application/json';
              Response response = await baseDio.delete(this.baseUrl+url+id.toString());
              return true;


}on DioError catch(e){
      print(e.error);
      return false;
    }
}
  Future <bool>saveUser(Map<String,dynamic> user)
  async {

    final url ="/user/add";

 try {
      baseDio.options.headers['content-Type']='application/json';
      
      Response response = await baseDio.post(this.baseUrl+url,data: user);
      
      return true ;
    }on DioError catch(e){
      print(e.error);
      return false;
    }

  }
  Future<dynamic> getMyproduct(int iduser)async {
    final url ="/myproduct/";
    try{
            baseDio.options.headers['content-Type']='application/json';
      Response <String> response = await baseDio.get(this.baseUrl+url+iduser.toString());
      String data =response.data ;
  
       List<dynamic>  map=jsonDecode(data) ;

       print (map.length.toString());
      /* for (var i=0 ;i<map.length;i++){
 dynamic obj1 = map[i];
         print ("//////////////////////////"+obj1["nom"]);
        

       }*/
        for (var u in map)
         {
           Produit pr =  Produit(u["id"],u["nom"],u["category"],u["description"],u["prix"],u["stock"],u["iduser"],u["image"]);
           AppData.list.add(pr);

         }
      
      

 return map;

    }on DioError catch(e){
      print(e);
      return e.error;
    }
  }

  Future<dynamic> getAllProduct()async {
    final url ="/produit/";
    try{
            baseDio.options.headers['Content-Type']='application/json';
                  Response <String> response = await baseDio.get(this.baseUrl+url);
                  List<dynamic> map =jsonDecode(response.data);
                  for (var u in map ){
                    Product p =Product(u["id"],u["nom"],u["category"],u["description"],u["prix"],u["stock"],u["iduser"],u["image"],false,false);
                    AppData.productList.add(p);
                  }
 return map;


    }on DioError catch(e){
      print(e);
      return e.error;
    }
  }
  Future<dynamic> getUserByemail(String  email)async {
      JsonCodec codec = new JsonCodec();

    final url ="/user/byemail/";
    try {
      
String result;
      baseDio.options.headers['Content-Type']='application/json';
      Response <String> response = await baseDio.get(this.baseUrl+url+email);
      
      String data =response.data ;
  
       List<dynamic>  map=jsonDecode(data) ;
       dynamic obj1 = map[0];
       String name = obj1["nom"];

print (name);

 return map;
    }on DioError catch(e){
      print(e);
      return e.error;
    }

  }
 
  

}