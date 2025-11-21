import 'package:equatable/equatable.dart';

class GenerateSlidesResponse extends Equatable {
  const GenerateSlidesResponse({required this.success, required this.data, required this.message});

  final bool success;
  final String? data;
  final String message;

  GenerateSlidesResponse copyWith({bool? success, String? data, String? message}) {
    return GenerateSlidesResponse(
      success: success ?? this.success,
      data: data ?? this.data,
      message: message ?? this.message,
    );
  }

  factory GenerateSlidesResponse.fromJson(Map<String, dynamic> json) {
    return GenerateSlidesResponse(
      success: json["success"] ?? false,
      data: json["data"]["url"] as String,
      message: json["message"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {"success": success, "data": data, "message": message};

  @override
  List<Object?> get props => [success, data, message];
}
