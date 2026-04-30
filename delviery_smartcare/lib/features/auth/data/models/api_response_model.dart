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
  T Function(dynamic)? fromJsonT, // 🔥 dynamic بدل Map
) {
  return ApiResponse(
    statusCode: json['statusCode'],
    succeeded: json['succeeded'],
    message: json['message'],
    errorsBag: json['errorsBag'],
    data: json['data'] != null && fromJsonT != null
        ? fromJsonT(json['data']) // 🔥 مباشرة
        : null,
  );
}
  }

