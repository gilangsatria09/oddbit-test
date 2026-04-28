import 'package:dart_frog/dart_frog.dart';

Response apiResponse({
  required int statusCode,
  required String message,
  dynamic data,
}) {
  return Response.json(
    statusCode: statusCode,
    body: {
      'statusCode': statusCode,
      'message': message,
      'data': data,
    },
  );
}
