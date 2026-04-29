class ApiResponse<T> {
  final int statusCode;
  final bool succeeded;
  final String message;
  final dynamic errorsBag;
  final T? data;

  ApiResponse({
    required this.statusCode,
    required this.succeeded,
    required this.message,
    this.errorsBag,
    this.data,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>)? fromJsonT,
  ) {
    return ApiResponse(
      statusCode: json['statusCode'] as int,
      succeeded: json['succeeded'] as bool,
      message: json['message'] as String,
      errorsBag: json['errorsBag'],
      data: (json['data'] != null && fromJsonT != null)
          ? fromJsonT(json['data'] as Map<String, dynamic>)
          : null,
    );
  }
}
