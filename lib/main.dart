import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:project/models/todo.model.dart';
import 'package:project/stores/todo.store.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

final todoStore = TodoStore();

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.black),
                accountName: Text("Wennys Camilo"),
                accountEmail: Text("user@gmail.com"),
                currentAccountPicture: CircleAvatar(
                  radius: 30.0,
                  backgroundImage: NetworkImage(
                      'https://mpng.subpng.com/20190123/jtv/kisspng-computer-icons-vector-graphics-person-portable-net-myada-baaranmy-teknik-servis-hizmetleri-5c48d5c2849149.051236271548277186543.jpg'),
                  backgroundColor: Colors.black87,
                ),
              ),
              ListTile(
                title: Text('Sair'.toUpperCase()),
                trailing: IconButton(
                  icon: Icon(Icons.logout),
                  onPressed: () {},
                ),
              )
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title: Observer(builder: (_) {
            return Center(child: Text(todoStore.todos.length.toString()));
          }),
        ),
        body: Container(
          child: Observer(
            builder: (_) => ListView.builder(
              itemCount: todoStore.todos.length,
              itemBuilder: (context, index) {
                var todo = todoStore.todos[index];
                return Dismissible(
                  key: Key(todo.toString()),
                  onDismissed: (direction) {
                    todoStore.todos.removeAt(index);
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    padding: const EdgeInsets.all(16),
                    child: Card(
                      elevation: 5,
                      child: Center(child: Text(todo.title)),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                var todo = new Todo(id: 1, title: 'Testando', done: false);
                todoStore.add(todo);
              },
              child: Icon(Icons.add),
              backgroundColor: Colors.black,
            ),
            SizedBox(
              width: 15,
            ),
            FloatingActionButton(
              onPressed: () {
                var todo = new Todo(id: 1, title: 'Testando', done: false);
                todoStore.clear(todo);
              },
              child: Icon(
                Icons.clear_all,
              ),
              backgroundColor: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
