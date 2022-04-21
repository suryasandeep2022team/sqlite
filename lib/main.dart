import 'package:flutter/material.dart';
import 'package:sqlite/delete.dart';
import 'package:sqlite/model.dart';
import 'package:sqlite/updatedata.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'SQLite'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController nameController = TextEditingController();

  List<SqliteModel> tasks = [];
  late SqliteModel currentTasks;
  final SqliteHelper _helper = SqliteHelper();
  bool textUpdated = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 30.0,left: 15.0,right: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: nameController,
                decoration:  InputDecoration(
                    hintText: "Enter Name", prefixIcon: Icon(Icons.people),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                   SizedBox(
                     width: 150.0,
                     child:  FlatButton(
                       onPressed: () {
                         currentTasks =
                             SqliteModel(name: nameController.text, id: 1);
                         _helper.insert(currentTasks.toMap());

                         setState(() {
                           nameController.text = "";
                         });
                       },
                       child: const Text("Save"),
                       color: Colors.green,
                     ),
                   ),
                    SizedBox(
                      width: 150.0,
                      child: FlatButton(
                        onPressed: () async {
                          List<SqliteModel> list = await _helper.fetchAll();

                          setState(() {
                            tasks = list;
                            textUpdated = true;
                          });
                        },
                        child: textUpdated ?  const Text("Refresh"):const Text("See All"),
                        color: Colors.yellow,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 150.0,
                       child: FlatButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const UpdateData()));
                            // setState(() {
                            // });
                          },
                          child: const Text("Update"),
                          color: Colors.blueAccent,
                        ),
                    ),
                    SizedBox(
                      width: 150.0,
                      child: FlatButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const DeleteData()));
                          // setState(() {
                          // });
                        },
                        child: const Text("Delete"),
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 150.0,
                      child: FlatButton(
                        onPressed: () async{
                          List<SqliteModel> dummy=[];
                          List<SqliteModel> list = await _helper.fetchAll();
                          setState(() {
                            tasks.clear();
                            dummy = list;
                          });
                          dummy.forEach((element) {
                            if(element.id%2!=0){
                              tasks.add(element);
                            }
                          });
                        },
                        child: const Text("Odd Data"),
                        color: Colors.green,
                      ),
                    ),
                    SizedBox(
                      width: 150.0,
                      child: FlatButton(
                        onPressed: () async {
                          List<SqliteModel> dummy=[];
                          List<SqliteModel> list = await _helper.fetchAll();

                          setState(() {
                            tasks.clear();
                            dummy = list;
                          });
                          dummy.forEach((element) {
                            if(element.id%2==0){
                              tasks.add(element);
                            }
                          });
                        },
                        child: const Text("Even Data"),
                        color: Colors.yellow,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                  height: 400.0,
                  child: Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            return Container(
                              padding: const EdgeInsets.fromLTRB(20, 5, 5, 0),
                              child:  ListTile(
                                  leading: Text("${tasks[index].id}"),
                                  title: Text(tasks[index].name),
                                  //subtitle: Text(tasks[index].name),
                                ),
                            );
                          },
                          separatorBuilder: (context, index) => const Divider(),
                          itemCount: tasks.length))
              ),
            ],
          ),
        ),
      ),
    );
  }
}
