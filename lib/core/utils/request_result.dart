import 'package:maelstorm/core/utils/status_code.dart';

///{@category core}

///RequestResult : abstract result of a http request with dio
///<br>contains the data in case of success
///<br>or DioExecption in case of error
abstract class RequestResult<T> {
  const RequestResult();
}

///RequestSuccess : implementation of RequestResult when request succeed
class RequestSuccess<T> extends RequestResult<T> {
  final T data;
  const RequestSuccess({required this.data});
}

///RequestFailed : implementation of RequestResult when request failed
class RequestFailed<T> extends RequestResult<T> {
  final StatusCode code;
  const RequestFailed({required this.code});

  factory RequestFailed.byInt(int? code) => RequestFailed(code: StatusCode.byInt(code));
}
