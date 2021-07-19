import 'package:flutter/material.dart';
import 'package:accessories_utube/constants.dart';
class CustomTextField extends StatelessWidget {
  CustomTextField({@required this.OnClicked,@required this.hintText,@required this.iconField});

  final IconData iconField;
  final String hintText;
  final Function OnClicked;
  String _errorMessage(String tex){
    switch(hintText){
      case 'Enter Your Name':return 'Name Shouldn\'t be empty !';
      case 'Enter Your Email':return 'Email Shouldn\'t be empty !';
      case 'Enter Your Password':return 'Password Shouldn\'t be empty !';
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator:(value) {
        if(value.isEmpty){
          return _errorMessage(hintText);
        }else{
          return null;
        }
      } ,
      onSaved: OnClicked,
      cursorColor: KMainColor,
      decoration: InputDecoration(
        prefixIcon: Icon(iconField,color: KMainColor,),
        hintText:hintText,
        filled: true,
        fillColor: KSecondaryColor,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: Colors.white
            )
        ),
        focusedBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: Colors.white
            )
        ),
        border:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: Colors.white
            )
        ),
      ),
    );
  }
}
