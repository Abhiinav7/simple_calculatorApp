import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import '../models/hive_model.dart';
import '../provider/provider.dart';
import 'main_screen.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});
  @override
  Widget build(BuildContext context) {
    var providermodel = Provider.of<HistoryProvider>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                providermodel.box.clear();
                // if(providermodel.box.length >=5){
                //   providermodel.box.deleteAt(0);
                // }
              },
              icon: Icon(Icons.delete))
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: providermodel.box.listenable(),
        builder: (context, value, child) {
          if (providermodel.box.values.isEmpty) {
            return Center(
              child: Text("No Calculations Found"),
            );
          } else {
            providermodel.sortedCalculation = providermodel.box.values.toList();
            providermodel.sortedCalculation
                .sort((a, b) => b.createdAt.compareTo(a.createdAt));

            return ListView.builder(
              itemCount: providermodel.sortedCalculation.length,
              itemBuilder: (context, index) {
                // HiveModel helper=providermodel.box.getAt(index);
                HiveModel helper = providermodel.sortedCalculation[index];
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  height: 65,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.deepPurple.shade50,
                  child: ListTile(
                    onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyCalculator(
                        historyInput: helper.input,
                        historyOutput: helper.output,
                      )
                        ,));
                    },
                    title: Text(
                      helper.output,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(
                      helper.input,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
