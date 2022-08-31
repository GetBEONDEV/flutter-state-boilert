import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'modules/Home/bloc/home_bloc.dart';
import 'modules/Home/bloc/home_event.dart';
import 'modules/Home/bloc/home_state.dart';
import 'modules/Home/ui/screens/home_ui.dart';
import 'shared/config/injection/service_locator.dart';

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
      home: const HomeUi(),
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
