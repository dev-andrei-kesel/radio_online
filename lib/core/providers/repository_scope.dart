import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:radio_online/feature/data/data_sources/local/data_base/radio_data_base.dart';
import 'package:radio_online/feature/data/data_sources/local/radio_local_data_sources.dart';
import 'package:radio_online/feature/data/data_sources/remote/radio_remote_data_source.dart';
import 'package:radio_online/feature/domain/repositories/radio_repository.dart';

import '../../feature/data/api/radio_api.dart';
import '../../feature/data/repositories/radio_repository_impl.dart';
import '../platform/network_info.dart';

class RepositoryScope extends InheritedWidget {
  final RadioRepository repository = RadioRepositoryImpl(
    radioRemoteDataSource: RadioRemoteDataSourceImpl(
      client: RestClient(
        Dio()
          ..options.headers['content-Type'] = 'application/json'
          ..interceptors.add(
            LogInterceptor(),
          ),
      ),
      networkInfo: NetworkInfoImp(),
    ),
    radioLocalDataSource:
        RadioLocalDataSourceImpl(dataBase: RadioDataBase.instance),
  );

  RepositoryScope({super.key, required super.child});

  static RepositoryScope of(BuildContext context) {
    HttpOverrides.global = MyHttpOverrides();
    return context.getInheritedWidgetOfExactType<RepositoryScope>()!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return child != oldWidget.child;
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

