import 'package:firebase_auth/firebase_auth.dart';
class Auth{
//1-create an object of class auth
final _auth=FirebaseAuth.instance;
//2-a method for authentcating email and pass
Future<UserCredential>SignUp(String email,String password)async{
  final authResult=await _auth.createUserWithEmailAndPassword(email: email, password: password);
  return authResult;
}
  Future<UserCredential>SignIn(String email,String password)async{
    final authResult=await _auth.signInWithEmailAndPassword(email: email, password: password);
    return authResult;
  }

 Future<void> SignOut()async{
await  _auth.signOut();
  }

}