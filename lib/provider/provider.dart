import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import '../models/hive_model.dart';
class HistoryProvider extends ChangeNotifier{
Box box=Hive.box("history");
List sortedCalculation=[];
addCalculations(HiveModel value)async{
 await  box.add(value);
 // history=box.values.toList();
  notifyListeners();

}
deleteHistory()async{
 if(box.length >10){
  await box.deleteAt(0);
 }
 notifyListeners();
}


}