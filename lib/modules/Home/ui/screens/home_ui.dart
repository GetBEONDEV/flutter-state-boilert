import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_starter_structure/main.dart';
import 'package:flutter_starter_structure/modules/Home/bloc/home_bloc.dart';
import 'package:flutter_starter_structure/modules/Home/bloc/home_event.dart';
import 'package:flutter_starter_structure/modules/Home/bloc/home_state.dart';
import 'package:flutter_starter_structure/shared/config/injection/service_locator.dart';

class HomeUi extends StatefulWidget {
  const HomeUi({Key? key}) : super(key: key);

  @override
  State<HomeUi> createState() => _HomeUiState();
}

class _HomeUiState extends State<HomeUi> {
  late HomeBloc _myBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _myBloc = SetupLocator.getIt<HomeBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hola Home")),
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
              onPressed: (() => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const SecondPage()))),
              child: const Text("Go to 2th page")),
        ],
      )),
    );
  }
}
