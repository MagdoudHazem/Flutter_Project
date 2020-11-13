import 'package:flutter_ecommerce_app/src/config/route.dart' as routes;
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/src/data/api_client.dart';
import 'package:flutter_ecommerce_app/src/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Login extends StatefulWidget {

 Login({Key key, this.title}) : super(key: key);

  final String title;

  @override
  LoginState createState() => LoginState();




}

class LoginState extends State<Login> {
    
    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
    TextEditingController emailController =TextEditingController();
    TextEditingController passwordController=TextEditingController();
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
    dynamic getuser;

    Widget emailField() {
      return TextFormField(
          controller: emailController,
          obscureText: false,
          style: style,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: "Email",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
        ); 
    }
        Widget passwordField (){
         return TextFormField(
          controller: passwordController,
          obscureText: true,
          style: style,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: "Password",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
        );
        }
      Widget loginButon (){
  return  Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(30.0),
          color: Color(0xffE65829),
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: () async {
                ApiClient apiClient = ApiClient();
                 getuser =await apiClient.getUserByemail("hh@gmail.com");
                 List <dynamic> map =await apiClient.getMyproduct(1);
                 dynamic user =getuser[0];
              if(emailController.text ==user["email"]  && passwordController.text ==user["mdp"]){
                 SharedPreferences prefs = await SharedPreferences.getInstance();
                 prefs.setInt("iduser", user["id"]);
                
 Navigator.of(context).pushNamedAndRemoveUntil(routes.MainPageRoute, (route) => false);

              }
              else {
                scaffoldKey.currentState.showSnackBar(
                  SnackBar(content: Text("verify your email or your password"),
                  backgroundColor: Colors.red,
                  
                ));
              }
             
            },
            child: Text("Login",
                textAlign: TextAlign.center,
                style: style.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        );
}
       
      Widget registerButon (){
        return  Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(30.0),
          color: Color(0xff2890c8),
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: () {
               Navigator.of(context).pushNamedAndRemoveUntil(routes.RegisterRoute, (route) => false);

              
            
                },
            child: Text("Register",
                textAlign: TextAlign.center,
                style: style.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        );
      } 

      @override
      Widget build(BuildContext context) {
        return Scaffold(
          key: scaffoldKey,
          body: Center(
            child: SingleChildScrollView(
                          child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(36.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 155.0,
                        child: Image.asset(
                          "assets/logo.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: 45.0),
                      emailField(),
                      SizedBox(height: 25.0),
                      passwordField(),
                      SizedBox(
                        height: 35.0,
                      ),
                      loginButon(),
                      SizedBox(
                        height: 15.0,
                      ),
                      registerButon(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }
}