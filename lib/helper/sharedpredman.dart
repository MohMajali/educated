import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static void storeUserData(String email, String name, String phone,
      String address, int id, String image) async {
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    sharedUser.setInt("userID", id);
    sharedUser.setString("mail", email);
    sharedUser.setString("name", name);
    sharedUser.setString("address", address);
    sharedUser.setString("phone", phone);
    sharedUser.setString("image", image);
    sharedUser.setBool("loggedin", true);
    sharedUser.commit();
  }

// static Future<bool> isUserLoggedIn() async{
//   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//   if(sharedPreferences.getInt("userID") != null){
//     return true;
//   }
//   return false;
// }

  static void userLogOut() async {
    SharedPreferences sharedClear = await SharedPreferences.getInstance();
    sharedClear.setBool("loggedin", false);
    sharedClear.remove("userID");
    sharedClear.remove("mail");
    sharedClear.remove("name");
    sharedClear.remove("address");
    sharedClear.remove("phone");
    sharedClear.remove("image");
  }
}
