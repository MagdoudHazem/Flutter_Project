import 'dart:convert';
import 'dart:io';

import 'package:flutter_ecommerce_app/src/config/route.dart' as routes;
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/src/data/api_client.dart';
import 'package:flutter_ecommerce_app/src/model/user.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Register extends StatefulWidget {

 Register({Key key, this.title}) : super(key: key);

  final String title;

  @override
  RegisterState createState() => RegisterState();




}

class RegisterState extends State<Register> {
        File _image;
  final picker = ImagePicker();
  bool _status = true;
    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
    TextEditingController emailController =TextEditingController();
    TextEditingController passwordController=TextEditingController();
        TextEditingController nomController=TextEditingController();
            TextEditingController mobileController=TextEditingController();
            TextEditingController countryController=TextEditingController();


    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
    dynamic getuser;

 Widget nomField()  {
      return TextFormField(
          controller: nomController,
          obscureText: false,
          style: style,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: "Nom",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
        ); 
    }
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
            Widget mobileField (){
         return TextFormField(
          controller: mobileController,
          obscureText: true,
          style: style,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: "Mobile",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
        );
        }
           Widget countryField (){
         return TextFormField(
          controller: countryController,
          obscureText: true,
          style: style,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: "Country",
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
              Map <String,dynamic> user ={
                    "nom":nomController.text,
                    "email":emailController.text,
                    "mobile":mobileController.text,
                    "mdp":passwordController.text,
                    "country":countryController.text,
                    "image":base64Encode(_image.readAsBytesSync()),
                    "filename":_image.path.split('/').last
              };
                ApiClient apiClient = ApiClient();
              if(emailController.text != null && passwordController.text !=null){
bool iSsaved =await apiClient.saveUser(user);
                
 Navigator.of(context).pushNamedAndRemoveUntil(routes.LoginPageRoute, (route) => false);

              }
              else {
                scaffoldKey.currentState.showSnackBar(
                  SnackBar(content: Text("verify your email or your password"),
                  backgroundColor: Colors.red,
                  
                ));
              }
             
            },
            child: Text("Save",
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
                     
                     new Container(
                height: 250.0,
                color: Colors.white,
                child: new Column(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(left: 20.0, top: 20.0),
                        child: new Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                       
                        )),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: new Stack(fit: StackFit.loose, children: <Widget>[
                        new Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Container(
                                width: 300.0,
                                height: 200.0,
                                decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: _image == null ? Image(image: AssetImage(
                                        'assets/logo.png'),fit: BoxFit.cover,) :  Image.file(_image),
                              
                                ),
                          ],
                        ),
                        GestureDetector(onTap: onChangeImage,
                                                  child: Padding(
                              padding: EdgeInsets.only(top: 150.0, right: 100.0),
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new CircleAvatar(
                                    backgroundColor: Colors.red,
                                    radius: 25.0,
                                    child: new Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              )),
                        ),
                      ]),
                    )
                  ],
                ),
              ),
                      SizedBox(height: 45.0),
                      nomField(),
                      SizedBox(height: 25.0),
                      emailField(),
                      SizedBox(height: 25.0),
                      passwordField(),
                     
                       SizedBox(height: 25.0),
                      mobileField(),
                      SizedBox(height: 25.0),
                        countryField(),
                       SizedBox(
                        height: 35.0,
                      ),
                      loginButon(),
                      SizedBox(
                        height: 15.0,
                      ),
                     
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
       
      }
       onChangeImage(){
           showModalBottomSheet(
      context: context,
      builder: (BuildContext bc){
          return Container(
            child: new Wrap(
            children: <Widget>[
new ListTile(
            leading: new Icon(Icons.image),
            title: new Text('Gallery'),
            onTap: ()   async {
              Navigator.of(context).pop();
                final pickedFile = await picker.getImage(source: ImageSource.gallery);

                setState(() {
                  if (pickedFile != null) {
                    _image = File(pickedFile.path);
                  } else {
                    print('No image selected.');
                  }
                });

            }         
          ),
          new ListTile(
            leading: new Icon(Icons.camera_alt),
            title: new Text('Camera'),
            onTap: ()  async {
              Navigator.of(context).pop();
                final pickedFile = await picker.getImage(source: ImageSource.camera);

                setState(() {
                  if (pickedFile != null) {
                    _image = File(pickedFile.path);
                  } else {
                    print('No image selected.');
                  }
                });
            },          
          ),
            ],
          ),
          );
      }
    );

        }
}