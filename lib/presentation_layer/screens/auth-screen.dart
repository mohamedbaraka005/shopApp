import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shop_app2/providers/auth-provider.dart';
class AuthScreen extends StatelessWidget {
   AuthScreen({Key key}) : super(key: key);

  final FormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: FormKey,
        child: ListView(
            children: [
         Container(
             height: 250,
             child: Image.asset("assets/images/CartIcon.png")
         ),
         Row(
          children: [
            Expanded(
              flex: 1,
                child: SizedBox()
            ),
            Expanded(
              flex: 18,
              child: TextFormField(
                textAlign: TextAlign.start,
                controller: Provider.of<AuthProvider>(context,listen:true).usernameController,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.email,
                    color:Colors.blue[800],
                  ),
                  prefixIconConstraints: BoxConstraints(
                    minWidth: 40,
                  ),
                  hintText: "Username",
                  enabledBorder: UnderlineInputBorder(
                  ),
                ),
                validator: (value) {
                 if (value.trim().toString().isEmpty)
                   return "Please enter the username";
                 return null;
                },
                //autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
            ),
            Expanded(
                flex: 1,
                child: SizedBox()
            ),
          ],
        ),
         SizedBox(
          height: 10,
           ),
         Row(
            children: [
              Expanded(
                  flex: 1,
                  child: SizedBox()
              ),
              Expanded(
                flex: 18,
                child: TextFormField(
                  textAlign: TextAlign.start,
                  obscureText:!Provider.of<AuthProvider>(context,listen:true).showPassword,
                  controller: Provider.of<AuthProvider>(context,listen:true).PasswordController,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.go,
                  // onFieldSubmitted:Provider.of<AuthProvider>(context,listen:false).submit(context),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.vpn_key,
                      color:Colors.blue[800],
                    ),
                    suffixIcon: InkWell(
                      onTap: (){
                        Provider.of<AuthProvider>(context,listen:false).ChangePasswordVisiblity(context);
                      },
                      child: Icon(
                        Provider.of<AuthProvider>(context,listen:true).showPassword?Icons.visibility:Icons.visibility_off,
                        color: Provider.of<AuthProvider>(context,listen:true).showPassword?Colors.black:Colors.black45,
                      ),
                    ),
                    prefixIconConstraints: BoxConstraints(
                      minWidth: 40,
                    ),
                    hintText: "Password",
                    enabledBorder: UnderlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value.trim().toString().isEmpty)
                      return "Please enter the password";
                    return null;
                  },
                  //autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
              Expanded(
                  flex: 1,
                  child: SizedBox()
              ),
            ],
              ),
         SizedBox(
          height: 20,
           ),
         Row(
          children: [
            Expanded(
              flex: 1,
              child: SizedBox(),
            ),
            context.watch<AuthProvider>().showLoading==false?
            Expanded(
              flex: 2,
              child:
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue[800]),
                ),
                onPressed: () {
                  if(FormKey.currentState.validate()) {
                        print("sumbitted");
                        Provider.of<AuthProvider>(context,listen:false).login(Provider.of<AuthProvider>(context,listen:false).usernameController.text.toString(), Provider.of<AuthProvider>(context,listen:false).PasswordController.text.toString() , context);
                      }
                    },
                child: Text('Submit'),

              )
            )
                :
            CircularProgressIndicator(),
            Expanded(
              flex: 1,
              child: SizedBox(),
            ),
          ],
        )
          ],
        ),

      ),
    );
  }
}
