import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:field_suggestion/field_suggestion.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tot_pro/utils/data/core/values/app_space.dart';
import 'package:tot_pro/screens/home/controllers/submit_edge_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:widget_zoom/widget_zoom.dart';
import '../../../models/address_model.dart';
import '../../../utils/data/core/values/app_assets.dart';
import '../../../utils/data/core/values/app_strings.dart';
import '../../../utils/data/customIntputHeader.dart';
import '../../../utils/data/custom_checkbox_button.dart';
import '../../../utils/data/custom_text_form_field.dart';
import 'dart:io';

class SubmitEdgeView extends GetView<SubmitEdgeController> {
  var inputTextStyle = TextStyle(fontSize: 14, color: Colors.grey.shade700);

  SubmitEdgeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          'Submit an EDGE',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        color: Colors.grey.shade300,
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        child: Stack(
          children: [
            Container(
              height: 160,
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
              decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.2),
                  borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20.0),
                      bottom: Radius.circular(5.0))),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    AppAssets.appLogo,
                    fit: BoxFit.cover,
                    height: 50,
                    width: 60,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: Text(
                      'Tell us about your task. We will get in touch with you soon.',
                      maxLines: 2,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w600),
                    ),
                  ),
                  AppSpace.spaceH6,
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  top: 110, left: 0, right: 0, bottom: 20),
              //   color: Colors.red,
              width: double.infinity,
              child: submitEdge(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget submitEdge(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: [
            edgeSubmitForm(context),
            AppSpace.spaceH20,
            edgeCompanyInfo(
                '100 Fairholt, Rd, London, N165HN', Icons.location_on_outlined),
            edgeCompanyInfo('02-039947611', Icons.phone),
            edgeCompanyInfo('sam@edgeemg.co.uk', Icons.email_outlined),
            AppSpace.spaceH20,
          ],
        ),
      ),
    );
  }

  edgeSubmitForm(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8.0),
        child: Form(
          key: controller.submitFormKey,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSpace.spaceH10,

                /// -------- Ck Box ---------

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Obx(
                        () => CustomCheckboxButton(
                          value: controller.isUseRegisterAddress.value,
                          onChange: (value) async {
                            if (controller.isUseRegisterAddress.value == true) {
                              controller.isUseRegisterAddress.value = false;
                              controller.phoneCon.text = '';
                            } else {
                              controller.isUseRegisterAddress.value = true;
                              controller.phoneCon.text =
                                  controller.proInfo.value.phone.toString();
                            }
                          },
                        ),
                      ),
                    ),
                    const Expanded(
                      flex: 8,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Use registered phone number.",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                AppSpace.spaceH20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Obx(
                        () => CustomCheckboxButton(
                          value: controller.isUseRegisterNumber.value,
                          onChange: (value) async {
                            if (controller.isUseRegisterNumber.value == true) {
                              controller.isUseRegisterNumber.value = false;
                              controller.firstAddress.value = '';
                              controller.addressLineTwoController.text = '';
                              controller.addressLineThreeController.text = '';
                              controller.countryTextController.text = '';
                              controller.postcodeTextController.text = '';
                            } else {
                              controller.isUseRegisterNumber.value = true;
                              controller.firstAddress.value =
                                  controller.proInfo.value.addressFirstLine ??
                                      '';
                              controller.addressLineTwoController.text =
                                  controller.proInfo.value.addressSecondLine ??
                                      '';
                              controller.addressLineThreeController.text =
                                  controller.proInfo.value.addressThirdLine ??
                                      '';
                              controller.countryTextController.text =
                                  controller.proInfo.value.town ?? '';
                              print(
                                  'SubmitEdgeController proInfo >> ${controller.proInfo.value.toJson()}');
                              print(
                                  'SubmitEdgeController >> ${controller.countryTextController.text}');

                              controller.postcodeTextController.text =
                                  controller.proInfo.value.postcode.toString();
                            }
                          },
                        ),
                      ),
                    ),
                    const Expanded(
                      flex: 8,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Use registered address.",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )
                  ],
                ),

                ///-------- Input field
                AppSpace.spaceH20,
                CustomInputHeader(header: 'Name'),
                AppSpace.spaceH6,
                CustomTextFormField(
                  controller: controller.nameCon,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.emptyInputFieldMsg;
                    }
                    return null;
                  },
                ),
                CustomInputHeader(header: 'Email'),
                AppSpace.spaceH6,
                CustomTextFormField(
                  textInputType: TextInputType.emailAddress,
                  controller: controller.mailCon,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.emptyInputFieldMsg;
                    }
                    return null;
                  },
                ),
                CustomInputHeader(header: 'Phone Number'),
                AppSpace.spaceH6,
                CustomTextFormField(
                  textInputType: TextInputType.phone,
                  custformatter: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r"[0-9,+]"),
                    )
                  ],
                  controller: controller.phoneCon,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.emptyInputFieldMsg;
                    }
                    return null;
                  },
                ),

                CustomInputHeader(header: 'Address First Line'),
                AppSpace.spaceH6,

                ///------------ finder Address  ------

                Obx(
                  () => FieldSuggestion<AddressModel>.network(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    inputDecoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                      hintText: controller.firstAddress.value,
                      filled: true,
                      fillColor: true
                          ? Colors.red.shade50.withOpacity(0.8)
                          : Colors.black12,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.greenAccent),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                    ),
                    future: (input) => controller.shouldSearch
                        ? controller.addressLineOneController.text.length > 0
                            ? controller.searchAddress(input)
                            : controller.returnEmptyFutureData()
                        : controller.returnEmptyFutureData(),
                    textController: controller.addressLineOneController,
                    boxController: controller.boxController,
                    validator: (value) {
                      return null;
                    },
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      final result = snapshot.data ?? [];
                      return ListView.builder(
                        itemCount: result.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              controller.shouldSearch = false;
                              controller.addressLineOneController.text =
                                  result[index].suggestion!;

                              FocusScope.of(context).unfocus();
                              controller.boxController.close?.call();
                              controller.shouldSearch = true;

                              /// get address details and set data to text fields
                              if (result[index].urls != null &&
                                  result[index].urls!.udprn != null) {
                                controller.getAndSetAddressDetails(
                                    result[index].urls!.udprn!);
                              }
                            },
                            child: ListTile(
                                title: Text(result[index].suggestion!)),
                          );
                        },
                      );
                    },
                  ),
                ),

                ///--------- End  ---------

                CustomInputHeader(header: 'Address  Second Line'),
                AppSpace.spaceH6,
                CustomTextFormField(
                  isReadOnly: true,
                  textInputType: TextInputType.text,
                  textStyle: const TextStyle(fontSize: 10),
                  controller: controller.addressLineTwoController,
                  validator: (value) {
                    /*   if (value == null || value.isEmpty) {
                        return AppStrings.emptyInputFieldMsg;
                      }*/
                    return null;
                  },
                ),

                CustomInputHeader(header: 'Address  Third Line'),
                AppSpace.spaceH6,
                CustomTextFormField(
                  isReadOnly: true,
                  textInputType: TextInputType.text,
                  textStyle: const TextStyle(fontSize: 10),
                  controller: controller.addressLineThreeController,
                  validator: (value) {
                    /* if (value == null || value.isEmpty) {
                        return AppStrings.emptyInputFieldMsg;
                      }*/
                    return null;
                  },
                ),

                CustomInputHeader(header: 'Town'),
                AppSpace.spaceH6,
                CustomTextFormField(
                  isReadOnly: true,
                  textStyle: const TextStyle(fontSize: 10),
                  controller: controller.countryTextController,
                  validator: (value) {
                    /*if (value == null || value.isEmpty) {
                        return AppStrings.emptyInputFieldMsg;
                      }*/
                    return null;
                  },
                ),

                CustomInputHeader(header: 'Post Code'),
                AppSpace.spaceH6,
                CustomTextFormField(
                  isReadOnly: true,
                  textStyle: const TextStyle(fontSize: 10),
                  controller: controller.postcodeTextController,
                  validator: (value) {
                    /*if (value == null || value.isEmpty) {
                        return AppStrings.emptyInputFieldMsg;
                      }*/
                    return null;
                  },
                ),

                ///todo list
                /// -------- Image With Comments  ---------

                AppSpace.spaceH6,
                SizedBox(
                  //   height: 120,
                  child: Obx(
                    () => controller.imageFiles.isEmpty
                        ? InkWell(
                            onTap: () => showModalBottomSheet(
                              barrierColor: Colors.teal.withOpacity(0.5),
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: Wrap(
                                    children: <Widget>[
                                      ListTile(
                                        leading: const Icon(Icons.camera),
                                        title: const Text(
                                          'Camera',
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        trailing: const Icon(
                                            Icons.touch_app_outlined),
                                        onTap: () => controller.selectImage(
                                            ImageSource.camera, 'camera'),
                                      ),
                                      ListTile(
                                        leading: const Icon(Icons.image),
                                        title: const Text(
                                          'Gallery',
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        trailing: const Icon(
                                            Icons.touch_app_outlined),
                                        onTap: () => controller.selectImage(
                                            ImageSource.gallery, 'gallery'),
                                      ),
                                      ListTile(
                                        leading: const Icon(
                                            Icons.video_camera_back_outlined),
                                        title: const Text(
                                          'Video',
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        trailing: const Icon(
                                            Icons.video_call_outlined),
                                        onTap: () => controller.selectImage(
                                            ImageSource.gallery, 'video'),
                                        //controller.selectVideo(ImageSource.gallery),
                                        //video
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            child: Center(
                                child: Padding(
                                    padding: const EdgeInsets.all(0.0),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          'assets/images/empty_iamges.png',
                                          width: 100,
                                          height: 100,
                                        ),
                                        const Text(
                                          'No Images OR Videos ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ))),
                          )
                        : SizedBox(
                            width: double.infinity,
                            child: Center(
                              child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: controller.imageFiles.length,
                                  itemBuilder: (BuildContext ctx, int index) {
                                    String extendFile = controller
                                        .imageFiles[index].path
                                        .split('.')
                                        .last;
                                    print('basename :: $extendFile');
                                    String path =
                                        controller.imageFiles[index].path;

                                    return Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      //color: Colors.red.shade50,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 2),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 2, horizontal: 5),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade300,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            width: double.infinity,
                                            alignment: Alignment.topRight,
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 0, horizontal: 0),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 5),
                                            child: InkWell(
                                              onTap: () {
                                                controller.imageFiles
                                                    .removeAt(index);
                                                controller.descriptionCont
                                                    .removeAt(index);
                                              },
                                              child: const CircleAvatar(
                                                radius: 14,
                                                backgroundColor: Colors.red,
                                                child: Icon(
                                                  Icons.close,
                                                  color: Colors.white,
                                                  // size: 30,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            color: Colors.white,
                                            child: CustomTextFormField(
                                              maxLines: 2,
                                              textStyle:
                                                  const TextStyle(fontSize: 10),
                                              controller: controller
                                                  .descriptionCont[index],
                                              hintText: "Description",
                                            ),
                                          ),

                                          AppSpace.spaceH6,

                                          ///------- Image ----------

                                          DottedBorder(
                                            borderType: BorderType.RRect,
                                            radius: const Radius.circular(10),
                                            padding: const EdgeInsets.all(2),
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10)),
                                              child: Container(
                                                height: 250,
                                                padding:
                                                    const EdgeInsets.all(0),
                                                alignment: Alignment.center,
                                                child: Stack(
                                                  children: [
                                                    // Obx(() => controller.fileModeCameraOrVideo.value=='video' ?

                                                    extendFile.toLowerCase() ==
                                                                'jpg' ||
                                                            extendFile ==
                                                                'png' ||
                                                            extendFile ==
                                                                'bmp' ||
                                                            extendFile ==
                                                                'webp' ||
                                                            extendFile ==
                                                                'heic' ||
                                                            extendFile == 'jpge'
                                                        ? imageShowWithZoomInOut(
                                                            path, index)
                                                        : VideoPlay1(
                                                            path:
                                                                path, //'images/works/667a29a242056.mp4',
                                                            index: index,
                                                          )

                                                    //)
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          AppSpace.spaceH4,
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              'File Path :${path.split('/').last} ',
                                              style:
                                                  const TextStyle(fontSize: 8),
                                            ),
                                          ),
                                          AppSpace.spaceH4,
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                          ),
                  ),
                ),
                AppSpace.spaceH10,

                ///-------- ADD + BUTTON

                Obx(
                  () => controller.imageFiles.isEmpty
                      ? Container()
                      : InkWell(
                          onTap: () => showModalBottomSheet(
                            barrierColor: Colors.teal.withOpacity(0.5),
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: Wrap(
                                  children: <Widget>[
                                    ListTile(
                                      leading: const Icon(Icons.camera),
                                      title: const Text(
                                        'Camera',
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      trailing:
                                          const Icon(Icons.touch_app_outlined),
                                      onTap: () => controller.selectImage(
                                          ImageSource.camera, 'camera'),
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.image),
                                      title: const Text(
                                        'Gallery',
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      trailing:
                                          const Icon(Icons.touch_app_outlined),
                                      onTap: () => controller.selectImage(
                                          ImageSource.gallery, 'gallery'),
                                    ),
                                    ListTile(
                                      leading: const Icon(
                                          Icons.video_camera_back_outlined),
                                      title: const Text(
                                        'Video',
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      trailing:
                                          const Icon(Icons.video_call_outlined),
                                      onTap: () => controller.selectImage(
                                          ImageSource.gallery, 'video'),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),

                          //controller.selectImage(ImageSource.gallery),

                          child: Container(
                            width: double.maxFinite,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'add'.toUpperCase(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                AppSpace.spaceW6,
                                CircleAvatar(
                                  radius: 15,
                                  backgroundColor:
                                      Colors.white.withOpacity(0.4),
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                ),

                AppSpace.spaceH20,

                /// ----- SUBMIT -----------

                const DottedLine(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.center,
                  lineLength: double.infinity,
                  lineThickness: 1.0,
                  dashLength: 6.0,
                  dashColor: Colors.black,
                  dashRadius: 0.0,
                  dashGapLength: 4.0,
                  dashGapColor: Colors.transparent,
                  dashGapRadius: 0.0,
                ),
                AppSpace.spaceH20,
                InkWell(
                  onTap: () {
                    print('check submit ');
                    FocusManager.instance.primaryFocus?.unfocus();
                    if (controller.submitFormKey.currentState!.validate()) {
                      controller.isVideoCapture.value == true
                          ? controller.workSubmitVideo(context)
                          : controller.workSubmit(context);
                    }
                  },
                  child: Container(
                    width: double.maxFinite,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                        child: Text(
                      "Submit".toUpperCase(),
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    )),
                  ),
                ),
                AppSpace.spaceH10,
              ],
            ),
          ),
        ),
      ),
    );
  }

  edgeCompanyInfo(String info, IconData? icon) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
              radius: 12,
              backgroundColor: Colors.red,
              child: Icon(
                icon,
                color: Colors.white,
                size: 14,
              )),
          const SizedBox(
            width: 10,
          ),
          Text(
            info,

            // style: contactbodytext,
          ),
        ],
      ),
    );
  }

  imageShowWithZoomInOut(String imagePath, int index) {
    return WidgetZoom(
        heroAnimationTag: index,
        zoomWidget: Image.file(
          File(imagePath),
          alignment: Alignment.center,
          fit: BoxFit.fitWidth,
          height: 250,
          width: double.infinity,
        ));
  }
}

class VideoPlay1 extends StatefulWidget {
  String? path;
  int? index;

  @override
  _VideoPlay1State createState() => _VideoPlay1State();

  VideoPlay1({super.key, this.path, this.index // Video from assets folder
      });
}

class _VideoPlay1State extends State<VideoPlay1> {
  ValueNotifier<VideoPlayerValue?> currentPosition = ValueNotifier(null);
  VideoPlayerController? controller;
  late Future<void> futureController;

  initVideo() {
    //print('Init Video path :: ${ApiURL.globalUrl +widget.path.toString()}');
    String videoUrl = widget.path.toString();
    print('_VideoPlay1State.initVideo Path >> $videoUrl ');
    controller = VideoPlayerController.file(File(videoUrl));
    futureController = controller!.initialize();
  }

  @override
  void initState() {
    //print('testing Video PAth :${widget.path.String()}');
    if (widget.path!.toString() != 'null') {
      initVideo();
      controller!.addListener(() {
        if (controller!.value.isInitialized) {
          currentPosition.value = controller!.value;
        }
      });
    }

    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 5),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            AppSpace.spaceH4,
            widget.path.toString() != 'null'
                ? SizedBox(
                    height: 220,
                    child: FutureBuilder(
                      future: futureController,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          //return const CircularProgressIndicator.adaptive();
                          return const Center(
                              child: CircularProgressIndicator.adaptive(
                            strokeWidth: 8,
                            backgroundColor: Colors.red,
                          ));
                        } else {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            child: SizedBox(
                              height: controller!.value.size.height,
                              width: double.infinity,
                              child: AspectRatio(
                                  aspectRatio: controller!.value.aspectRatio,
                                  child: Stack(children: [
                                    Positioned.fill(
                                        child: Container(
                                            foregroundDecoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                  colors: [
                                                    Colors.black
                                                        .withOpacity(.7),
                                                    Colors.transparent
                                                  ],
                                                  stops: const [
                                                    0,
                                                    .3
                                                  ],
                                                  begin: Alignment.bottomCenter,
                                                  end: Alignment.topCenter),
                                            ),
                                            child: VideoPlayer(controller!))),
                                    Positioned.fill(
                                      child: Column(
                                        children: [
                                          Expanded(
                                            flex: 8,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 3,
                                                  child: GestureDetector(
                                                    onDoubleTap: () async {
                                                      Duration? position =
                                                          await controller!
                                                              .position;
                                                      setState(() {
                                                        controller!.seekTo(Duration(
                                                            seconds: position!
                                                                    .inSeconds -
                                                                10));
                                                      });
                                                    },
                                                    child: const Icon(
                                                      Icons.fast_rewind_rounded,
                                                      color: Colors.black,
                                                      size: 40,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                    flex: 4,
                                                    child: IconButton(
                                                      icon: Icon(
                                                        controller!
                                                                .value.isPlaying
                                                            ? Icons.pause
                                                            : Icons.play_arrow,
                                                        color: Colors.black,
                                                        size: 40,
                                                      ),
                                                      onPressed: () {
                                                        setState(() {
                                                          if (controller!.value
                                                              .isPlaying) {
                                                            controller!.pause();
                                                          } else {
                                                            controller!.play();
                                                          }
                                                        });
                                                      },
                                                    )),
                                                Expanded(
                                                  flex: 3,
                                                  child: GestureDetector(
                                                    onDoubleTap: () async {
                                                      Duration? position =
                                                          await controller!
                                                              .position;
                                                      setState(() {
                                                        controller!.seekTo(Duration(
                                                            seconds: position!
                                                                    .inSeconds +
                                                                10));
                                                      });
                                                    },
                                                    child: const Icon(
                                                      Icons
                                                          .fast_forward_rounded,
                                                      color: Colors.black,
                                                      size: 40,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                              flex: 2,
                                              child: Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: ValueListenableBuilder(
                                                    valueListenable:
                                                        currentPosition,
                                                    builder: (context,
                                                        VideoPlayerValue?
                                                            videoPlayerValue,
                                                        w) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 20,
                                                                vertical: 10),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              videoPlayerValue!.position.toString().substring(
                                                                  videoPlayerValue
                                                                          .position
                                                                          .toString()
                                                                          .indexOf(
                                                                              ':') +
                                                                      1,
                                                                  videoPlayerValue
                                                                      .position
                                                                      .toString()
                                                                      .indexOf(
                                                                          '.')),
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 22),
                                                            ),
                                                            const Spacer(),
                                                            Text(
                                                              videoPlayerValue.duration.toString().substring(
                                                                  videoPlayerValue
                                                                          .duration
                                                                          .toString()
                                                                          .indexOf(
                                                                              ':') +
                                                                      1,
                                                                  videoPlayerValue
                                                                      .duration
                                                                      .toString()
                                                                      .indexOf(
                                                                          '.')),
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 22),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    }),
                                              ))
                                        ],
                                      ),
                                    ),
                                  ])),
                            ),
                          );
                        }
                      },
                    ),
                  )
                : Container(
                    height: 200,
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(10)),
                    child: Image.asset('assets/images/not_video_found.png'),
                  ),
          ],
        ),
      ),
    );
  }
}
