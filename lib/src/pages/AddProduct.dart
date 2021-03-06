import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/src/config/route.dart' as routes;
import 'package:flutter_ecommerce_app/src/data/api_client.dart';
import 'package:flutter_ecommerce_app/src/model/data.dart';
import 'package:flutter_ecommerce_app/src/model/produit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AddProduct extends StatefulWidget {
  @override
  MapScreenState createState() => MapScreenState();
   
}

class MapScreenState extends State<AddProduct>
    with SingleTickerProviderStateMixin {
      File _image;
  final picker = ImagePicker();
  bool _status = true;
  int _value = 0;
  final FocusNode myFocusNode = FocusNode();
  final GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController nameController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    TextEditingController amountController = TextEditingController();


  List<String> categories = [
     "Sneakers","Jacket","Watch",   
              "Phone"
  ];
 
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose(){
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    amountController.dispose();
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Container(
      color: Colors.white,
      child: new ListView(
        children: <Widget>[
          Column(
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
                          children: <Widget>[
                            new IconButton(
                             icon:new Icon( Icons.arrow_back_ios,
                              color: Colors.black,
                              
                              size: 22.0,),
                              
                              onPressed: () => {Navigator.of(context).pushNamedAndRemoveUntil(routes.MainPageRoute, (route) => false)},
                             
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 25.0),
                              child: new Text('Add Product',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                      fontFamily: 'sans-serif-light',
                                      color: Colors.black)),
                            )
                          ]
                          ,
                        )),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: new Stack(fit: StackFit.loose, children: <Widget>[
                        new Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Container(
                                width: 140.0,
                                height: 140.0,
                                decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: _image == null ? Image(image: AssetImage(
                                        'assets/add.png'),fit: BoxFit.cover,) :  Image.file(_image),
                              
                                ),
                          ],
                        ),
                        GestureDetector(onTap: onChangeImage,
                                                  child: Padding(
                              padding: EdgeInsets.only(top: 90.0, right: 100.0),
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
              new Container(
                color: Color(0xffFFFFFF),
                child: Padding(
                  padding: EdgeInsets.only(bottom: 25.0),
                  child: Form(
                    key: formKey,
                      child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 25.0),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    new Text(
                                      'Product Information',
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    _status ? _getEditIcon() : new Container(),
                                  ],
                                )
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 25.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    new Text(
                                      'Name',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 2.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Flexible(
                                  child: new TextFormField(
                                    controller: nameController,
                                    validator: (value) {

                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                      hintText: "Enter Name of Product",
                                    ),
                                    enabled: !_status,
                                    autofocus: !_status,

                                  ),
                                ),
                              ],
                            )),
                            Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 25.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    new Text(
                                      'Category',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 25.0),
                                
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              
                              children: <Widget>[
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                     DropdownButton( 
                                   value: _value,iconSize: 45,
              items: [
                DropdownMenuItem(
                    child: Text("Sneakers"),
                    value: 0,
                ),
                DropdownMenuItem(
                    child: Text("Jacket"),
                    value: 1,
                ),
                DropdownMenuItem(
                    child: Text("Watch"),
                    value: 2
                ),
                DropdownMenuItem(
                      child: Text("Phone"),
                      value: 3
                )
              ],
              onChanged: (value) {
                setState(() {
                    _value = value;
                });
              },
                                    
                                    ),
                                  ],
                                ),
                              ],
                            )),
                       
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 25.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    new Text(
                                      'Description',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 2.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Flexible(
                                  child: new TextFormField(
                                    controller: descriptionController,
                                    decoration: const InputDecoration(
                                        hintText: "Enter Description"),
                                    enabled: !_status,
                                  ),
                                ),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 25.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    child: new Text(
                                      ' Price',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  flex: 2,
                                ),
                                Expanded(
                                  child: Container(
                                    child: new Text(
                                      'Amount',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  flex: 2,
                                ),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 2.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Flexible(
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 10.0),
                                    child: new TextFormField( controller: priceController,

                                      decoration: const InputDecoration(
                                          hintText: "Enter Price"),
                                      enabled: !_status,
                                    ),
                                  ),
                                  flex: 2,
                                ),
                                Flexible(
                                  child: new TextFormField(
                                                                        controller: amountController,

                                    decoration: const InputDecoration(
                                        hintText: "Enter Amount"),
                                    enabled: !_status,
                                  ),
                                  flex: 2,
                                ),
                              ],
                            )),
                        !_status ? _getActionButtons() : new Container(),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    ));
  }



  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text("Save"),
                textColor: Colors.white,
                color: Colors.green,
                onPressed: () async {
                  
                  if(formKey.currentState.validate()){
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    ApiClient apiClient = ApiClient();
                    Map <String,dynamic> product ={
                      "nom": nameController.text.toString(),
                        "description":descriptionController.text.toString(),
                        "prix":priceController.text.toString(),
                        "stock":amountController.text.toString(),
                        "category":categories[_value].toString(),
                        "iduser": prefs.getInt("iduser").toString(),
                        
                        "image":base64Encode(_image.readAsBytesSync()),
                        "filename":_image.path.split('/').last
                    };
                        print(product["filename"]);
                       /* int id =AppData.list.length;
                        print(AppData.list.toString());
                        print(AppData.list[id-1].toString());*/
                        
 Produit pr =  Produit(2,product["nom"],product["category"],product["description"],product["prix"],int.parse(product["stock"]),int.parse(product["iduser"]),product["filename"]);
AppData.list.add(pr);
                       bool isSaved = await apiClient.saveProduct(product, _image);
                    //  print("isSaved :: ${isSaved}");
                  }
                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(new FocusNode());
                  });
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text("Cancel"),
                textColor: Colors.white,
                color: Colors.red,
                onPressed: () {
                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(new FocusNode());
                  });
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Colors.red,
        radius: 14.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
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