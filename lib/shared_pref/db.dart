import 'package:shared_preferences/shared_preferences.dart';

class ContactHistory{

  Future saveContacts(String input,String output)async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    sharedPreferences.setString("input", input);
    sharedPreferences.setString("output", output);
    return true;
  }
  Future getContacts()async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    String? input=sharedPreferences.getString("input");
    String? output=sharedPreferences.getString("output");
    List data=[input,output];
    return data;
  }
}