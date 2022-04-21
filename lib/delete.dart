import 'package:flutter/material.dart';
import 'package:sqlite/model.dart';

class DeleteData extends StatefulWidget {
  const DeleteData({Key? key}) : super(key: key);

  @override
  State<DeleteData> createState() => _DeleteDataState();
}

class _DeleteDataState extends State<DeleteData> {
  final TextEditingController idController = TextEditingController();
  final SqliteHelper _helper = SqliteHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Delete Data"),),
      body: Container(
        margin: const EdgeInsets.fromLTRB(20, 50, 20, 0),
        child: Column(
          children: [
             TextField(
              controller: idController,
              decoration:  InputDecoration(
                hintText: "Enter id",
                prefixIcon: const Icon(Icons.person_outline_sharp),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                )
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30.0),
              width: double.infinity,
              height: 50.0,
              child: FlatButton(
                onPressed: () async {
                  int i =await _helper.delete(int.parse(idController.text));
                  print("Row has been deleted $i");
                },
                child: const Text("Delete",
                  style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,),),
                color: Colors.yellow,
              ),
            )
          ],
        ),
      ),
    );
  }
}
