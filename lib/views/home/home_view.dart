import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:magic_slides/client_service/http_service.dart';
import 'package:magic_slides/client_service/storage_keys.dart';
import 'package:magic_slides/controller/home/home_controller.dart';
import 'package:magic_slides/main.dart';
import 'package:magic_slides/model/generate_slides/generate_slides_request.dart';
import 'package:magic_slides/model/user/user_model.dart';
import 'package:magic_slides/routes/routes.dart';
import 'package:magic_slides/utils/assets_path.dart';
import 'package:magic_slides/utils/extenstions/integer_extenstion.dart';
import 'package:magic_slides/utils/theme-text/text-style.dart';
import 'package:magic_slides/utils/widgets/common_button.dart';
import 'package:magic_slides/utils/widgets/custom_snack_bar.dart';
import 'package:magic_slides/utils/widgets/label_text_fields.dart';
import 'package:magic_slides/utils/widgets/loader.dart';

enum TemplateType {
  defaultTemplate(value: "Default Template"),
  editableTemplate(value: "Editable Template");

  final String value;

  const TemplateType({required this.value});
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final TextEditingController topicController;
  late final HomeController homeController;
  UserModel? userModel;
  List<String> modelsList = ['gpt-4', 'gpt-3.5'],
      presentationForList = ['business', 'student', 'teacher', 'marketing', 'sales', 'technology', 'other'],
      defaultTemplate = [
        "bullet-point1",
        "bullet-point2",
        "bullet-point4",
        "bullet-point5",
        "bullet-point6",
        "bullet-point7",
        "bullet-point8",
        "bullet-point9",
        "bullet-point10",
        "custom2",
        "custom3",
        "custom4",
        "custom5",
        "custom6",
        "custom7",
        "custom8",
        "custom9",
        "verticalBulletPoint1",
        "verticalCustom1",
      ],
      editableTemplate = [
        "ed-bullet-point9",
        "ed-bullet-point7",
        "ed-bullet-point6",
        "ed-bullet-point5",
        "ed-bullet-point2",
        "ed-bullet-point4",
        "Custom gold 1",
        "custom Dark 1",
        "custom sync 5",
        "custom sync 4",
        "custom sync 6",
        "custom sync 1",
        "custom sync 2",
        "custom sync 3",
        "custom-ed-7",
        "custom-ed-8",
        "custom-ed-9",
        "pitchdeckorignal",
        "pitch-deck-3",
        "pitch-deck-2",
        "custom-ed-10",
        "custom-ed-11",
        "custom-ed-12",
        "ed-bullet-point1",
      ];
  String? defaultTem, editableTem, model, error, presentation;
  TemplateType template = TemplateType.defaultTemplate;
  bool aiImages = false,
      imageForEachSlide = false,
      googleText = false,
      googleImages = false,
      loader = false,
      logoutLoader = false;
  int slideCount = 1;

  @override
  void initState() {
    homeController = Get.find<HomeController>();
    topicController = TextEditingController();
    model = modelsList.first;
    presentation = presentationForList.first;
    defaultTem = defaultTemplate.first;
    editableTem = editableTemplate.first;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      String? user = await initializers.getStorage.read(StorageKeys.user);
      if (user != null && user.isNotEmpty) {
        userModel = UserModel.fromJson(jsonDecode(user));
      }
    });
    super.initState();
  }

  void _generate() async {
    final topic = topicController.text.trim();
    if (topic.isEmpty) {
      setState(() {
        error = 'Topic cannot be empty';
      });
      return;
    }
    setState(() {
      loader = true;
      error = null;
    });
    try {
      await HttpService.postAPI(
        request: GenerateSlidesRequest(
          topic: topic,
          email: 'chandwanisahil10@gmail.com',
          accessId: "bafae78d-e6e0-45a0-897c-e4ddd6ef3ceb",
          template: template == TemplateType.editableTemplate ? (editableTem ?? '') : (defaultTem ?? ''),
          language: 'en',
          slideCount: slideCount,
          aiImages: aiImages,
          imageForEachSlide: imageForEachSlide,
          googleImage: googleImages,
          googleText: googleText,
          model: model != null ? model! : '',
          presentationFor: presentation ?? '',
          watermark: {
            "brandURL": "https://upload.wikimedia.org/wikipedia/commons/7/79/Flutter_logo.svg",
            "width": "48",
            "height": "48",
            "position": "BottomRight",
          },
        ),
        onSuccess: (response) async {
          print("response: ${jsonEncode(response.toJson())}");
          setState(() {
            loader = false;
          });
          await Future.delayed(Duration(milliseconds: 500));
          if (response.data != null && response.data!.isNotEmpty) {
            Get.toNamed(Routes.pdfView, arguments: response.data);
          }
        },
        onError: (error) {
          print("error: $error");
          errorSnackBar(context: context, title: error);
          setState(() {
            loader = false;
          });
        },
      );
      setState(() {
        loader = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        print("error: $error");
        loader = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: SvgPicture.asset(SvgPaths.googleSlides, height: 30, width: 30),
        actions: [
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () async {
              await Future.delayed(Duration(milliseconds: 500));
              setState(() {
                homeController.isDarkMode.value = !homeController.isDarkMode.value;
              });
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Icon(
                homeController.isDarkMode.value ? Icons.light_mode_rounded : Icons.nightlight_round_rounded,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),

          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () async {
              setState(() {
                logoutLoader = true;
              });
              await Future.delayed(Duration(seconds: 1));
              await initializers.getStorage.remove(StorageKeys.user);
              await Future.delayed(Duration(seconds: 1));
              setState(() {
                logoutLoader = false;
              });
              await Future.delayed(Duration(milliseconds: 500));
              Get.offAllNamed(Routes.login);
            },
            child: Padding(
              padding: EdgeInsets.only(right: 24),
              child: logoutLoader ? Loader() : Icon(Icons.logout, color: Theme.of(context).colorScheme.onSurfaceVariant),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppTextFormFieldsWithLabel(
                textEditingController: topicController,
                hintText: 'Enter your topic...',
                isError: error != null && topicController.text.trim().isEmpty,
                onChanged: (value) {},
                onFieldSubmitted: (value) {},
              ),
              30.height,
              Row(
                children: [
                  AppTextTheme.text('Template: ', color: Theme.of(context).colorScheme.onSurface, fontSize: 14),
                  12.width,
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Theme.of(context).colorScheme.onSecondaryContainer, width: 0.5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: DropdownButton<TemplateType>(
                        value: template,
                        isExpanded: true,
                        underline: SizedBox(),
                        items: TemplateType.values
                            .map<DropdownMenuItem<TemplateType>>(
                              (e) => DropdownMenuItem<TemplateType>(
                                onTap: () {
                                  setState(() {
                                    template = e;
                                  });
                                },
                                value: e,
                                child: AppTextTheme.text(e.value, color: Theme.of(context).colorScheme.onSurface),
                              ),
                            )
                            .toList(),
                        onChanged: (v) => setState(() {
                          if (v != null) {
                            template = v;
                          }
                        }),
                      ),
                    ),
                  ),
                ],
              ),
              15.height,
              if (template == TemplateType.defaultTemplate)
                Row(
                  children: [
                    AppTextTheme.text('Default Template: ', color: Theme.of(context).colorScheme.onSurface, fontSize: 14),
                    12.width,
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Theme.of(context).colorScheme.onSecondaryContainer, width: 0.5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: DropdownButton<String>(
                          value: defaultTem,
                          isExpanded: true,
                          underline: SizedBox(),
                          menuMaxHeight: MediaQuery.heightOf(context) * 0.4,
                          items: defaultTemplate
                              .map<DropdownMenuItem<String>>(
                                (e) => DropdownMenuItem<String>(
                                  onTap: () {
                                    setState(() {
                                      defaultTem = e;
                                    });
                                  },
                                  value: e,
                                  child: AppTextTheme.text(e, color: Theme.of(context).colorScheme.onSurface),
                                ),
                              )
                              .toList(),
                          onChanged: (v) => setState(() {
                            if (v != null) {
                              defaultTem = v;
                            }
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              if (template == TemplateType.editableTemplate)
                Row(
                  children: [
                    AppTextTheme.text('Editable Template: ', color: Theme.of(context).colorScheme.onSurface, fontSize: 14),
                    12.width,
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Theme.of(context).colorScheme.onSecondaryContainer, width: 0.5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: DropdownButton<String>(
                          value: editableTem,
                          isExpanded: true,
                          underline: SizedBox(),
                          menuMaxHeight: MediaQuery.heightOf(context) * 0.4,
                          items: editableTemplate
                              .map<DropdownMenuItem<String>>(
                                (e) => DropdownMenuItem<String>(
                                  onTap: () {
                                    setState(() {
                                      editableTem = e;
                                    });
                                  },
                                  value: e,
                                  child: AppTextTheme.text(e, color: Theme.of(context).colorScheme.onSurface),
                                ),
                              )
                              .toList(),
                          onChanged: (v) => setState(() {
                            if (v != null) {
                              editableTem = v;
                            }
                          }),
                        ),
                      ),
                    ),
                  ],
                ),

              Row(
                children: [
                  AppTextTheme.text('Slide Count: ', color: Theme.of(context).colorScheme.onSurface, fontSize: 14),
                  Expanded(
                    child: Slider(
                      value: slideCount.toDouble(),
                      min: 1,
                      max: 50,
                      divisions: 49,
                      label: '$slideCount',
                      onChanged: (v) => setState(() => slideCount = v.toInt()),
                    ),
                  ),
                  AppTextTheme.text('$slideCount', color: Theme.of(context).colorScheme.onSurface, fontSize: 14),
                ],
              ),
              15.height,
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        AppTextTheme.text('AI Images', color: Theme.of(context).colorScheme.onSurface, fontSize: 14),
                        Switch(value: aiImages, onChanged: (v) => setState(() => aiImages = v)),
                      ],
                    ),
                  ),
                  10.width,
                  Expanded(
                    child: Row(
                      children: [
                        AppTextTheme.text('Image per slide', color: Theme.of(context).colorScheme.onSurface, fontSize: 14),
                        Switch(value: imageForEachSlide, onChanged: (v) => setState(() => imageForEachSlide = v)),
                      ],
                    ),
                  ),
                ],
              ),
              15.height,
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        AppTextTheme.text('Google Text', color: Theme.of(context).colorScheme.onSurface, fontSize: 14),
                        Switch(value: googleText, onChanged: (v) => setState(() => googleText = v)),
                      ],
                    ),
                  ),
                  10.width,
                  Expanded(
                    child: Row(
                      children: [
                        AppTextTheme.text('Google Images', color: Theme.of(context).colorScheme.onSurface, fontSize: 14),
                        Switch(value: googleImages, onChanged: (v) => setState(() => googleImages = v)),
                      ],
                    ),
                  ),
                ],
              ),
              15.height,
              Row(
                children: [
                  AppTextTheme.text('Model:', color: Theme.of(context).colorScheme.onSurface, fontSize: 14),
                  12.width,
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Theme.of(context).colorScheme.onSecondaryContainer, width: 0.5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: DropdownButton<String>(
                        value: model,
                        isExpanded: true,
                        underline: SizedBox(),
                        items: modelsList
                            .map<DropdownMenuItem<String>>(
                              (e) => DropdownMenuItem<String>(
                                onTap: () {
                                  setState(() {
                                    model = e;
                                  });
                                },
                                value: e,
                                child: AppTextTheme.text(e, color: Theme.of(context).colorScheme.onSurface),
                              ),
                            )
                            .toList(),
                        onChanged: (v) => setState(() => model = v ?? 'gpt-4'),
                      ),
                    ),
                  ),
                ],
              ),
              15.height,
              Row(
                children: [
                  AppTextTheme.text('Presentation For', color: Theme.of(context).colorScheme.onSurface, fontSize: 14),
                  12.width,
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Theme.of(context).colorScheme.onSecondaryContainer, width: 0.5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: DropdownButton<String>(
                        value: presentation,
                        isExpanded: true,
                        underline: SizedBox(),
                        items: presentationForList
                            .map<DropdownMenuItem<String>>(
                              (e) => DropdownMenuItem<String>(
                                onTap: () {
                                  setState(() {
                                    presentation = e;
                                  });
                                },
                                value: e,
                                child: AppTextTheme.text(e, color: Theme.of(context).colorScheme.onSurface),
                              ),
                            )
                            .toList(),
                        onChanged: (v) => setState(() => presentation = v),
                      ),
                    ),
                  ),
                ],
              ),

              30.height,
              if (error != null)
                Column(
                  children: [
                    AppTextTheme.text(error!, color: Theme.of(context).colorScheme.error),
                    12.height,
                  ],
                ),
              ClickablePrimaryButton(
                label: 'Generate',
                onTap: loader ? null : _generate,
                isLoader: loader,
                loader: Loader(color: Theme.of(context).colorScheme.surface),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
