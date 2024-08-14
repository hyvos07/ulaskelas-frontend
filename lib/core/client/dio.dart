part of '_client.dart';

Future<Response> getIt(
  String url, {
  Map<String, String>? headers,
}) async {
  if (kDebugMode) {
    Logger().i({'url': url, 'headers': '${Pref.getHeaders()}'});
  }
  final getHeaders = headers ?? Pref.getHeaders();
  final resp = await Dio().get(
    url,
    options: Options(
      headers: getHeaders,
      receiveTimeout: const Duration(milliseconds: 5000),
      sendTimeout: const Duration(milliseconds: 6000),
    ),
  );
  if (kDebugMode) {
    Logger()
        .i({'response': '${resp.data}', 'statusCode': '${resp.statusCode}'});
  }
  return resp;
}

Future<Response> postIt(
  String url, {
  Map<String, String>? headers,
  Map<String, dynamic>? model,
}) async {
  if (kDebugMode) {
    Logger().i({
      'url': url,
      'headers': '${Pref.getHeaders()}',
      'model': '$model',
    });
  }
  final getHeaders = headers ?? Pref.getHeaders();
  final resp = await Dio().post(
    url,
    data: json.encode(model),
    options: Options(
      headers: getHeaders,
      receiveTimeout: const Duration(milliseconds: 5000),
      sendTimeout: const Duration(milliseconds: 6000),
    ),
  );
  if (kDebugMode) {
    Logger()
        .i({'response': '${resp.data}', 'statusCode': '${resp.statusCode}'});
  }
  return resp;
}

Future<Response> putIt(
  String url, {
  Map<String, String>? headers,
  Map<String, dynamic>? model,
}) async {
  if (kDebugMode) {
    Logger().i({
      'url': url,
      'headers': '${Pref.getHeaders()}',
      'model': '$model',
    });
  }
  final getHeaders = headers ?? Pref.getHeaders();
  final resp = await Dio().put(
    url,
    data: model,
    options: Options(
      headers: getHeaders,
      receiveTimeout: const Duration(milliseconds: 5000),
      sendTimeout: const Duration(milliseconds: 6000),
    ),
  );
  if (kDebugMode) {
    Logger()
        .i({'response': '${resp.data}', 'statusCode': '${resp.statusCode}'});
  }
  return resp;
}

Future<Response> deleteIt(
  String url, {
  Map<String, String>? headers,
  Map<String, dynamic>? model,
}) async {
  if (kDebugMode) {
    Logger().i({
      'url': url,
      'headers': '${Pref.getHeaders()}',
      'model': '$model',
    });
  }
  final getHeaders = headers ?? Pref.getHeaders();
  final resp = await Dio().delete(
    url,
    data: model,
    options: Options(
      headers: getHeaders,
      receiveTimeout: const Duration(milliseconds: 5000),
      sendTimeout: const Duration(milliseconds: 6000),
    ),
  );
  if (kDebugMode) {
    Logger()
        .i({'response': '${resp.data}', 'statusCode': '${resp.statusCode}'});
  }
  return resp;
}

Future<Response> sendCustomRequest(
  String url, {
  required String method,
  Map<String, String>? headers,
  Map<String, dynamic>? body,
}) async {
  final getHeaders = headers ?? Pref.getHeaders();

  if (kDebugMode) {
    Logger().i({
      'url': url,
      'headers': '$getHeaders',
      'body': '$body',
    });
  }

  try {
    final resp = await Dio().request(
      url,
      options: Options(
        method: method,
        headers: getHeaders,
      ),
      data: body,
    );
    if (kDebugMode) {
      Logger().i({
        'response': '${resp.data}',
        'statusCode': '${resp.statusCode}',
      });
    }
    return resp;
  } catch (e) {
    if (e is DioException && e.response != null) {
      Logger().e(e.response!.toString());
    }
    Logger().e(e);
  }

  if (kDebugMode) {
    Logger().i({
      'response': "{error: Something's Wrong, I Can Feel It}",
      'statusCode': '500'
    });
  }

  // Fake Error Response (even if it is intended to indicate an error)
  return Response(
    requestOptions: RequestOptions(
      path: url,
      method: method,
    ),
    statusCode: 500,
    statusMessage: 'Error',
    data: {
      'error': "Something's Wrong, I Can Feel It ",
    },
  );
}


Future<Response> postWithFileInIt(
  String url, {
  Map<String, String>? headers,
  Map<String, dynamic>? model,
}) async {
  if (kDebugMode) {
    Logger().i({
      'url': url,
      'headers': '${Pref.getHeaders()}',
      'model': '$model',
    });
  }

  final getHeaders = headers ?? Pref.getHeaders();

  // Convert the model to FormData if it contains a file
  FormData formData = FormData();

  if (model != null) {
    model.forEach((key, value) {
      if (value is File) {
        formData.files.add(MapEntry(
          key,
          MultipartFile.fromFileSync(value.path, filename: value.path.split('/').last),
        ));
      } else {
        formData.fields.add(MapEntry(key, value.toString()));
      }
    });
  }

  final resp = await Dio().post(
    url,
    data: formData,
    options: Options(
      headers: getHeaders,
      receiveTimeout: const Duration(milliseconds: 5000),
      sendTimeout: const Duration(milliseconds: 6000),
    ),
  );

  if (kDebugMode) {
    Logger()
        .i({'response': '${resp.data}', 'statusCode': '${resp.statusCode}'});
  }

  return resp;
}
