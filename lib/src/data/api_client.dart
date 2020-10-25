
import 'dart:convert';


import 'package:dio/dio.dart';
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

  Future<bool> saveProduct(Map<String,dynamic> product) async{
    final url = "/produit/add";

    try {
      print("$product");
      baseDio.options.headers['content-Type'] = 'application/json';
      Response response = await baseDio.post(this.baseUrl+url,data:jsonEncode(product));
      return true;
    }on DioError catch(e){
      print(e);
      return false;
    }
  }
  
  Future<dynamic> getUserByemail(String  email)async {
      JsonCodec codec = new JsonCodec();

    final url ="/user/byemail/";
    try {
      email="hh@gmail.com";
String result;
      baseDio.options.headers['content-Type']='application/json';
      Response response = await baseDio.get(this.baseUrl+url+email);
      
      String data =response.data.toString();
    /*  result = data.substring(0, data.length - 1);  
      result=result.substring(0,0);
      result = data.substring(0, data.length - 1);  
       result=result.substring(0,0);
      print(result);*/
       Map<  String,dynamic>  map=jsonDecode(data.toString()) ;
//var decoded =codec.decode(response.data.toString());
 //map=jsonDecode(response.data.toString());

print (map.toString());
//print(map["nom"]);
//print(map["email"]);
 return map;
    }on DioError catch(e){
      print(e);
      return e.error;
    }

  }
 
  

}