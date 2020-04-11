import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'utils/database_helper.dart';
import 'model/lang.dart';

List myLang;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var db = new DatabaseHelper();

  myLang = await db.getAllUsers();
  for (int i = 0; i < myLang.length; i++) {
    Lang lang = Lang.map(myLang[i]);
    print(
        'ID: ${lang.id} - lang: ${lang.lang} - description: ${lang.description}');
  }
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      title: new Text(
        'Welcome In SplashScreen',
        style: new TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
          color: Colors.green,
        ),
      ),
      seconds: 3,
      navigateAfterSeconds: AfterSplash(),
      image: new Image.asset('assets/explorer-optimize.gif'),
      loadingText: new Text("Loading..."),
      backgroundColor: Colors.blueGrey,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 200,
      onClick: () => print("Flutter Egypt"),
      loaderColor: Colors.red,
    );
  }
}

class AfterSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: new Text('SQLITE'),
        backgroundColor: Colors.blueAccent,
      ),
      body: new ListView.builder(
          itemCount: myLang.length,
          itemBuilder: (_, int position) {
            return new Card(
              child: new ListTile(
                leading: new Icon(Icons.accessibility,
                    color: Colors.red, size: 33.0),
                title: new Text('${Lang.fromMap(myLang[position]).lang}'),
                subtitle:
                    new Text('${Lang.fromMap(myLang[position]).description}'),
                onTap: () => debugPrint('ontap'),
              ),
              color: Colors.amber,
              elevation: 3.0,
            );
          }),
    );
  }
}
