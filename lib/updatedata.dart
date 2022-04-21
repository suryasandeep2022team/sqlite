import 'package:flutter/material.dart';

import 'model.dart';

class UpdateData extends StatefulWidget {
  const UpdateData({Key? key}) : super(key: key);

  @override
  State<UpdateData> createState() => _UpdateDataState();
}

class _UpdateDataState extends State<UpdateData> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  late SqliteModel currentTasks;
  final SqliteHelper _helper = SqliteHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Update Data"),),
      body: Container(
        margin: const EdgeInsets.all(20.0),
        child: Column(
          children: [

          TextField(
          controller: idController,
          decoration: InputDecoration(
            hintText: "Enter id",
            prefixIcon: Icon(Icons.person_outline_rounded),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
            )
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        TextField(
          controller: nameController,
          decoration:  InputDecoration(
            hintText: "Enter Name",
            prefixIcon: Icon(Icons.people),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
            )
          ),
        ),
        Container(
            margin: const EdgeInsets.fromLTRB(4, 40, 4, 0),
            width: double.infinity,
            height: 50.0,
            child: FlatButton(
              onPressed: () async {

                currentTasks =
                    SqliteModel(name: nameController.text, id: int.parse(idController.text));
                int i = await _helper.update(currentTasks);
                setState(() {
                  idController.text = "";
                  nameController.text = "";
                });
                print("One has been effected $i");
              },
              child: const Text("Update"),
              color: Colors.green,
            ),
        ),
      ],
    ),)
    ,
    );
  }
}
