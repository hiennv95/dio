import 'dart:convert';
import 'options.dart';
import 'headers.dart';
import 'redirect_record.dart';

/// Response describes the http Response info.
class Response<T> {
  Response({
    this.data,
    this.headers,
    this.request,
    this.isRedirect,
    this.statusCode,
    this.statusMessage,
    this.extra,
  });

  /// Response body. may have been transformed, please refer to [ResponseType].
  T data;

  /// Response headers.
  Headers headers;

  /// The corresponding request info.
  RequestOptions request;

  /// Http status code.
  int statusCode;

  /// Returns the reason phrase associated with the status code.
  /// The reason phrase must be set before the body is written
  /// to. Setting the reason phrase after writing to the body.
  String statusMessage;

  /// Custom field that you can retrieve it later in `then`.
  Map<String, dynamic> extra;

  /// Returns the series of redirects this connection has been through. The
  /// list will be empty if no redirects were followed. [redirects] will be
  /// updated both in the case of an automatic and a manual redirect.
  ///
  /// ** Attention **: Whether this field is available depends on whether the
  /// implementation of the adapter supports it or not.
  List<RedirectRecord> redirects;

  /// Whether this response is a redirect.
  /// ** Attention **: Whether this field is available depends on whether the
  /// implementation of the adapter supports it or not.
  final bool isRedirect;

  /// Return the final real request uri (maybe redirect).
  ///
  /// ** Attention **: Whether this field is available depends on whether the
  /// implementation of the adapter supports it or not.
  Uri get realUri => redirects.last?.location ?? request.uri;

  /// We are more concerned about `data` field.
  @override
  String toString() {
    if (data is Map) {
      return json.encode(data);
    }
    return data.toString();
  }
}
