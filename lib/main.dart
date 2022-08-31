import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'modules/Home/bloc/home_bloc.dart';
import 'modules/Home/bloc/home_event.dart';
import 'modules/Home/bloc/home_state.dart';
import 'shared/config/constants/endpoints.dart';
import 'shared/config/injection/service_locator.dart';
import 'shared/config/network/dio/dio_client.dart';

void main() {
  SetupLocator.getItSetUp();
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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  late DioClient _dioClient;
  late HomeBloc _myBloc;
  Future<void> _incrementCounter() async {
    await getLogin();
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  Future<dynamic> getLogin() async {
    try {
      final res = await _dioClient.post(Endpoints.loginUser,
          data: {"email": "nicodevcode@gmail.com", "password": "123asd456"});
      print(res);
      return res;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dioClient = SetupLocator.getIt<DioClient>();
    _myBloc = SetupLocator.getIt<HomeBloc>();
    getLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocProvider(
              create: (_) => _myBloc,
              child: BlocBuilder<HomeBloc, HomeState>(
                  bloc: _myBloc,
                  builder: (_, state) => Text(
                        'You have pushed the button this many times: ${state.count}',
                        style: Theme.of(context).textTheme.headline4,
                      )),
            ),
            FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                _myBloc.add(CounterIncrementPressed(1));
              },
            ),
            ElevatedButton(
                onPressed: (() => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SecondPage()))),
                child: const Text("Go to 2th page")),
          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  late HomeBloc _myBloc;

  @override
  void initState() {
    _myBloc = SetupLocator.getIt<HomeBloc>();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Segunda pagina")),
      body: Center(
          child: Column(
        children: [
          BlocBuilder<HomeBloc, HomeState>(
              bloc: _myBloc,
              builder: (_, state) => Text(
                    'You have pushed the button this many times: ${state.count}',
                    style: Theme.of(context).textTheme.headline4,
                  )),
          FloatingActionButton(
            child: const Icon(Icons.remove),
            onPressed: () {
              _myBloc.add(CounterDecrementPressed(1));
            },
          ),
        ],
      )),
    );
  }
}
