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
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  late DioClient _dioClient;
  late HomeBloc _myBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dioClient = SetupLocator.getIt<DioClient>();
    _myBloc = SetupLocator.getIt<HomeBloc>();
    getLogin();
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
