import 'package:equatable/equatable.dart';

class GenerateSlidesRequest extends Equatable {
  const GenerateSlidesRequest({
    required this.topic,
    required this.email,
    required this.accessId,
    required this.template,
    required this.language,
    required this.slideCount,
    required this.aiImages,
    required this.imageForEachSlide,
    required this.googleImage,
    required this.googleText,
    required this.model,
    required this.presentationFor,
    required this.watermark,
  });

  final String topic;
  final String email;
  final String accessId;
  final String template;
  final String language;
  final int slideCount;
  final bool aiImages;
  final bool imageForEachSlide;
  final bool googleImage;
  final bool googleText;
  final String model;
  final String presentationFor;
  final Map<String, dynamic> watermark;

  GenerateSlidesRequest copyWith({
    String? topic,
    String? extraInfoSource,
    String? email,
    String? accessId,
    String? template,
    String? language,
    int? slideCount,
    bool? aiImages,
    bool? imageForEachSlide,
    bool? googleImage,
    bool? googleText,
    String? model,
    String? presentationFor,
    Map<String, dynamic>? watermark,
  }) {
    return GenerateSlidesRequest(
      topic: topic ?? this.topic,
      email: email ?? this.email,
      accessId: accessId ?? this.accessId,
      template: template ?? this.template,
      language: language ?? this.language,
      slideCount: slideCount ?? this.slideCount,
      aiImages: aiImages ?? this.aiImages,
      imageForEachSlide: imageForEachSlide ?? this.imageForEachSlide,
      googleImage: googleImage ?? this.googleImage,
      googleText: googleText ?? this.googleText,
      model: model ?? this.model,
      presentationFor: presentationFor ?? this.presentationFor,
      watermark: watermark ?? this.watermark,
    );
  }

  factory GenerateSlidesRequest.fromJson(Map<String, dynamic> json) {
    return GenerateSlidesRequest(
      topic: json["topic"] ?? "",
      email: json["email"] ?? "",
      accessId: json["accessId"] ?? "",
      template: json["template"] ?? "",
      language: json["language"] ?? "",
      slideCount: json["slideCount"] ?? 0,
      aiImages: json["aiImages"] ?? false,
      imageForEachSlide: json["imageForEachSlide"] ?? false,
      googleImage: json["googleImage"] ?? false,
      googleText: json["googleText"] ?? false,
      model: json["model"] ?? "",
      presentationFor: json["presentationFor"] ?? "",
      watermark: json["watermark"] ?? {},
    );
  }

  Map<String, dynamic> toJson() => {
    "topic": topic,
    "extraInfoSource": topic,
    "email": email,
    "accessId": accessId,
    "template": template,
    "language": language,
    "slideCount": slideCount.toString(),
    "aiImages": aiImages.toString(),
    "imageForEachSlide": imageForEachSlide.toString(),
    "googleImage": googleImage.toString(),
    "googleText": googleText.toString(),
    "model": model,
    "presentationFor": presentationFor,
    "watermark": watermark.toString(),
  };

  @override
  List<Object?> get props => [
    topic,
    email,
    accessId,
    template,
    language,
    slideCount,
    aiImages,
    imageForEachSlide,
    googleImage,
    googleText,
    model,
    presentationFor,
    watermark,
  ];
}
