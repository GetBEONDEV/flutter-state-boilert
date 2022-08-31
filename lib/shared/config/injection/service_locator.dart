import 'package:dio/dio.dart';
import 'package:flutter_starter_structure/shared/config/network/dio/dio_client.dart';
import 'package:get_it/get_it.dart';

import '../../../modules/Home/bloc/home_bloc.dart';

class SetupLocator {
  const SetupLocator._();

  static final getIt = GetIt.instance;

  static getItSetUp() {
    getIt.registerSingleton<DioClient>(DioClient(Dio()));
    getIt.registerSingleton<HomeBloc>(HomeBloc());
  }
}
