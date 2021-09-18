import 'dart:async'; //es la libreria que nos permitira utilizar Futures
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ejemplo FutureBuilder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  String calcularListaDeTimestamps(int count){
    StringBuffer sb = StringBuffer();
    for(int i=0;i<count;i++){
      sb.writeln("${ i + 1} : ${DateTime.now()}");
    }
    return sb.toString();
  }
  Future<String> crearCalculacionFutura(int count){
    return Future((){
      return calcularListaDeTimestamps(count);
    });
  }
  const Home({Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _mostrarCalculos = false;

  void _onInvokeFuturePressed(){
    setState(() {
      _mostrarCalculos = !_mostrarCalculos;
    });
  }
  @override
  Widget build(BuildContext context) {
    Widget child = _mostrarCalculos?FutureBuilder(future: widget.crearCalculacionFutura(100),
    builder: (BuildContext ctx, AsyncSnapshot snapshot){
      return Expanded(child: SingleChildScrollView(
        child: Text('${snapshot.data==null?"":snapshot.data}',style: TextStyle(fontSize: 20),),
      ));
    },)
        :Text('Presione el boton para mostrar los calculos');
    return new Scaffold(
      appBar: AppBar(title: Text('Future'),),
      body: Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [child],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onInvokeFuturePressed,tooltip: 'Invocacion futura',
        child: Icon(Icons.refresh),
      ),
    );
  }
}
