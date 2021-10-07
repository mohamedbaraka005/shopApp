
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app2/shared/helper.dart';




class AuthProvider with ChangeNotifier{

  var usernameController = TextEditingController();
  var PasswordController = TextEditingController();
  bool showLoading = false;
  bool showPassword = false ;
  bool loggedIn;


  AuthProvider()
      : loggedIn = Helper.getBoolean('preferencesKey')?? false;

  void ChangePasswordVisiblity(context)
  {
    ///this line will close the keyboard and there is no need to put notifyListeners this line change the state:
    FocusScope.of(context).unfocus();
    showPassword=!showPassword;

  }

  dynamic submit (context){
    print("the form sumbitted");
    login(usernameController.text.toString(),PasswordController.text.toString(),context);
  }

  Future<void> login(String username, String password , context) async {
    ///to show the loading
    showLoading=true;
    notifyListeners();

    var response = await http.post(
      Uri.parse('https://fakestoreapi.com/auth/login'),
      headers: {'content-type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    var json = jsonDecode(response.body);

    if (json['token'] != null) {
      ///so if the user lodged out not find his username and password written in the fields.
      usernameController.clear();
      PasswordController.clear();
      print("get the token successfully");

      Helper.putString('token', json['token']);
      Helper.putBoolean('preferencesKey', true);
      loggedIn = true;
      showLoading=false;
      notifyListeners();
    }
    else {
      ///to remove the loading and show submit button
      showLoading=false;
      notifyListeners();

      showDialog(context: context, child: AlertDialog(
        title: Text("Error"),
       // titlePadding: EdgeInsets.fromLTRB(10,10,0,0),
        contentPadding:EdgeInsets.fromLTRB(25, 10, 10, 5),
        content:Container(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("wrong username or password" , style: Theme.of(context).textTheme.caption,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: (){Navigator.pop(context);},
                        child: Text("OK" , style: TextStyle(fontSize:16,color:Colors.blue[800]),))
                  ],)
              ]
          ),
        ),
      ));
    }
  }

  void signOut (){
    Helper.remove('preferencesKey');
    Helper.remove('token');
    loggedIn = false;
    notifyListeners();
  }

}