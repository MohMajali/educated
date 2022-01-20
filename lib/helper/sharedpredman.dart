import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static void storeUserData(String email, String name, String phone,
      String address, int id, String image) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt("userID", id);
    sharedPreferences.setString("mail", email);
    sharedPreferences.setString("name", name);
    sharedPreferences.setString("address", address);
    sharedPreferences.setString("phone", phone);
    sharedPreferences.setString("image", image);
    sharedPreferences.setBool("loggedin", true);
    sharedPreferences.commit();
  }

// static Future<bool> isUserLoggedIn() async{
//   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//   if(sharedPreferences.getInt("userID") != null){
//     return true;
//   }
//   return false;
// }

  static void userLogOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("loggedin", false);
    sharedPreferences.clear();
  }
}
