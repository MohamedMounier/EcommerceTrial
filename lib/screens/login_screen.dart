import 'package:accessories_utube/constants.dart';
import 'package:accessories_utube/provider/adminMode.dart';
import 'package:accessories_utube/provider/modelHud.dart';
import 'package:accessories_utube/screens/AdminHomePage.dart';
import 'package:accessories_utube/screens/signup_screen.dart';
import 'package:accessories_utube/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:accessories_utube/customed_widgets/custom_textFields.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'HomePage.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'LoginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _emailLog;

  String _passLog;

  String passAdmin='admin1234';

  bool isAdmin = false;

  final _authLog = Auth();
  bool keepMeLoggedin=false;

  GlobalKey<FormState> formKey2 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: KMainColor,
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModelHud>(context).isLoading,
        child: Form(
          key: formKey2,
          child: ListView(
            children: [
              SizedBox(height: height * .06),
              // icon at the Beginning
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Container(
                  height: MediaQuery.of(context).size.height * .2,
                  child: Column(
                    children: [
                      Image(
                        image: AssetImage('assets/images/icons/baglogin.png'),
                        color: Colors.purple,
                      ),
                      Text(
                        'Dal3ek',
                        style: TextStyle(fontFamily: 'Pacifico', fontSize: 25),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: height * .01),
              //TextField of email
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: CustomTextField(
                  iconField: Icons.email,
                  OnClicked: (value) {
                    _emailLog = value;
                  },
                  hintText: 'Enter Your Email',
                ),
              ),
              SizedBox(height: height * .02),
              //TextField of Passwod
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: CustomTextField(
                  iconField: Icons.lock,
                  OnClicked: (value) {
                    _passLog = value;
                  },
                  hintText: 'Enter Your Password',
                ),
              ),
              SizedBox(height: height * .02),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: width*.04),
                child: Row(
                  children: [
                    Theme(
                      data: ThemeData(
                        unselectedWidgetColor: KSecondaryColor
                      ),
                      child: Checkbox(
                        activeColor: KMainColor,
                          checkColor: Colors.white,
                          value: keepMeLoggedin,
                          onChanged: (value){
                          setState(() {
                            keepMeLoggedin=value;
                          });
                          }),
                    ),
                    Text(
                      'Remember Me',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * .04),

              //Login Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 140),
                child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                      backgroundColor: MaterialStateProperty.all(Colors.black)),
                  onPressed: (){
                    if(keepMeLoggedin==true){
                      KeepUserLoggedin();
                    }
                    valAndLoginAdmUser(context);
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: height * .08),
              //Raw of Texts
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an Account?',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, SignUpScreen.id);
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width * .08, vertical: height * .03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: () {
                            Provider.of<AdminMode>(context, listen: false)
                                .ChangeisAdmin(true);
                          },
                          child: Text(
                            'i\'m an admin',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Provider.of<AdminMode>(context).isadmin
                                    ? KMainColor
                                    : Colors.purple),
                            textAlign: TextAlign.center,
                          )),
                    ),
                    Expanded(
                        child: TextButton(
                      onPressed: () {
                        Provider.of<AdminMode>(context, listen: false)
                            .ChangeisAdmin(false);
                      },
                      child: Text(
                        'i\'m an user',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Provider.of<AdminMode>(context).isadmin
                                ? Colors.purple
                                : KMainColor),
                        textAlign: TextAlign.center,
                      ),
                    )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  valAndLoginAdmUser(context)async{
    final modelHud= Provider.of<ModelHud>(context,listen: false);
    final admMode= Provider.of<AdminMode>(context,listen: false);
    modelHud.ChangeisLoading(true);
    try{
      if(formKey2.currentState.validate()){
        formKey2.currentState.save();
        if(admMode.isadmin==false){
          try{
            await _authLog.SignIn(_emailLog.trim(), _passLog.trim());
            modelHud.ChangeisLoading(false);
            Navigator.pushNamed(context, HomePage.id);
          }catch(e){
            modelHud.ChangeisLoading(false);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${e.message}')));
          }
        }else if(admMode.isadmin==true){
        if(_passLog==passAdmin){
          try{
            //trim Reomves spaces from being saved in user email or pass
            await _authLog.SignIn(_emailLog.trim(), _passLog.trim());
            modelHud.ChangeisLoading(false);
            Navigator.pushNamed(context, AdminHomePage.id);
          }catch(e){
            modelHud.ChangeisLoading(false);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${'${e.message}'}')));

          }
        }else{
          modelHud.ChangeisLoading(false);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('password is not correct ')));
        }

        }

      }
    }catch(e){
      modelHud.ChangeisLoading(false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${e.message}')));
    }
    modelHud.ChangeisLoading(false);
  }

  void KeepUserLoggedin() async{
    SharedPreferences preferences= await SharedPreferences.getInstance();
    preferences.setBool(KeepMeLoggedIn, keepMeLoggedin);
  }
}





/*
 onPressed: () async {
                    final modelH = Provider.of<ModelHud>(context, listen: false);
                    modelH.ChangeisLoading(true);
                    if (formKey2.currentState.validate()) {
                      formKey2.currentState.save();
                      // modelH.ChangeisLoading(false);
                      try {
                        final authresLog =
                            await _authLog.SignIn(_emailLog, _passLog);
                        modelH.ChangeisLoading(false);
                        Navigator.pushNamed(context, HomePage.id);
                        print(
                            'authresLog uid is ${authresLog.user.uid}\n authresLog email is ${authresLog.user.email}');
                      } catch (e) {
                        modelH.ChangeisLoading(false);

                        print(e.toString());
                        //  Scaffold.of(context).showSnackBar(SnackBar(
                        //    content: Text('${e.toString()}')));

                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('${e.message}')));
                        //on PlatformException catch(e){} would get only the error kind of the platform excption
                      }
                      //  final authresLog=await _authLog.SignIn(_emailLog, _passLog);
                      // print('authresLog uid is ${authresLog.user.uid}\n authresLog email is ${authresLog.user.email}');
                    }
                    modelH.ChangeisLoading(false);
                  },
 */