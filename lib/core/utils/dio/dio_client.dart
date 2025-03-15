///{@category core}
library;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:maelstorm/core/utils/log.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioClient {
  late final Dio instance;

  DioClient() {
    log.d("DioClient > initialize");
    instance = Dio()
      ..interceptors.addAll([
        PrettyDioLogger(
            requestHeader: false,
            requestBody: kDebugMode,
            responseBody: kDebugMode,
            responseHeader: true,
            error: true,
            compact: false,
            maxWidth: 120,
            logPrint: log.d),
        // getIt<NotificationInterceptor>()
      ]);
  }
}
