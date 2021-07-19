import 'package:accessories_utube/provider/modelHud.dart';
import 'package:accessories_utube/screens/HomePage.dart';
import 'package:accessories_utube/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:accessories_utube/constants.dart';
import 'package:accessories_utube/customed_widgets/custom_textFields.dart';
import 'package:accessories_utube/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';


class SignUpScreen extends StatelessWidget {
  static String id='SignUpScreen';
  final GlobalKey<FormState> formKey=GlobalKey<FormState>();
   String _email1;
   String _password1;
   final _auth=Auth();
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: KMainColor,
        body: ModalProgressHUD(
          inAsyncCall: Provider.of<ModelHud>(context).isLoading,
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                SizedBox(
                    height:height*.06
                ),
                // icon at the Beginning
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Container(
                    height: MediaQuery.of(context).size.height*.2,
                    child: Column(
                      children: [
                        Image(image: AssetImage('assets/images/icons/baglogin.png'),color: Colors.purple,),
                        Text('Dal3ek',
                          style: TextStyle(
                              fontFamily: 'Pacifico',
                              fontSize: 25
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                    height:height*.01
                ),
                //TextField of Name
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: CustomTextField(iconField: Icons.perm_identity_sharp,hintText:'Enter Your Name' ,),
                ),
                SizedBox(
                    height:height*.02
                ),
                //TextField of Email
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: CustomTextField(iconField: Icons.email,
                    hintText:'Enter Your Email' ,
                  OnClicked: (value){
                    _email1=value;
                    print(_email1);
                  },
                  ),
                ),
                SizedBox(
                    height:height*.02
                ),
                //TextField of Passwod
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: CustomTextField(iconField: Icons.lock,
                    OnClicked: (value){
                      _password1=value;
                      print(_password1);
                    },
                    hintText:'Enter Your Password' ,),
                ),
                SizedBox(
                    height:height*.06
                ),
                //Login Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 140),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                        )),
                        backgroundColor: MaterialStateProperty.all(Colors.black)
                    ),
                    onPressed: ()async{
                      final modelHud=Provider.of<ModelHud>(context,listen: false);
                      modelHud.ChangeisLoading(true);
                      if (formKey.currentState.validate()){
                        formKey.currentState.save();
                        print(' Email entered is $_email1 and Password entered is $_password1');
                        try{
                          final authRes = await _auth.SignUp(_email1.trim(), _password1.trim());
                          modelHud.ChangeisLoading(false);
                          Navigator.pushNamed(context, HomePage.id);
                          print(
                              ' the auth res uid is :-${authRes.user.uid}\n the authres email is ${authRes.user.email} ');
                        }catch(e){
                          modelHud.ChangeisLoading(false);

                          print(e.toString());
                        //  Scaffold.of(context).showSnackBar(SnackBasr(
                          //    content: Text('${e.toString()}')));

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                 content: Text('${e.message}')));
                          modelHud.ChangeisLoading(true);

                          //on PlatformException catch(e){} would get only the error kind of the platform excption
                        }
                      }
                      modelHud.ChangeisLoading(false);
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                  ),
                ),
                SizedBox(
                    height:height*.08
                ),
                //Raw of Texts
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Have an account already?',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, LoginScreen.id);
                      },
                      child: Text('Login',style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
  }
}
