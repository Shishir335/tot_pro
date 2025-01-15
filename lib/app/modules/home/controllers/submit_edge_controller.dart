import 'dart:convert';
import 'package:field_suggestion/box_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:tot_pro/app/data/api_services.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../main.dart';
import '../../../../models/address_model.dart';
import '../../../../models/user_profile_model.dart';
import '../../../data/api_client.dart';
import '../../../data/core/values/app_helper.dart';
import '../../../data/core/values/app_space.dart';
import '../../../data/core/values/app_url.dart';
import '../../../data/dbhelper.dart';

class SubmitEdgeController extends GetxController {
  final postCodeStatus = ''.obs;
  final postCodeStatusMsg = ''.obs;
  final searchPostCodeName = ''.obs;
  ApiService? apiService;
  final isUseRegisterAddress = false.obs;
  final isUseRegisterNumber = false.obs;
  File? imageFile;

  List<TextEditingController> descriptionCont = [];
  GlobalKey<FormState> submitFormKey = GlobalKey<FormState>();
  final descriptionCnt = TextEditingController();

  final imageFiles = <File>[].obs;
  TextEditingController nameCon = TextEditingController();
  TextEditingController mailCon = TextEditingController();
  TextEditingController phoneCon = TextEditingController();
  TextEditingController houseCon = TextEditingController();
  TextEditingController townCon = TextEditingController();
  TextEditingController streetCon = TextEditingController();
  TextEditingController postCon = TextEditingController();
  TextEditingController commentCon = TextEditingController();
  final loading = false.obs;
  final count = 0.obs;
  Rx<UserProfileModel> proInfo = UserProfileModel().obs;

  late ApiClient _apiClient;

  ///------------ Address --------------
  ///
  static const String _baseUrl = 'https://api.ideal-postcodes.co.uk';
  //static const String _key = 'ak_lu3q2fx5XP10rIvksRD4uw1CHqKSM';
  static const String _key = 'ak_lt4ocv0eHLLo4meBRGHWK4HU0SBxa';

  var boxController = BoxController();
  var addressLineOneController = TextEditingController();
  final firstAddress = ''.obs;
  var addressLineTwoController = TextEditingController();
  var addressLineThreeController = TextEditingController();
  var countryTextController = TextEditingController();
  var postcodeTextController = TextEditingController();
  bool shouldSearch = true;
  final isVideoCapture = false.obs;

  final fileModeCameraOrVideo = 'camera'.obs;

  returnEmptyFutureData() =>
      Future.delayed(Duration.zero).then((value) => <AddressModel>[]);

  Future<List<AddressModel>> searchAddress(query) async {
    print('query :$query');
    dynamic response;
    List<AddressModel> addressList = [];

    try {
      var headers = {
        "Accept": "application/json",
        'Content-type': 'application/json',
        'X-Requested-With': 'XMLHttpRequest',
      };

      http.Response response = await http.get(
        Uri.parse(
            '$_baseUrl/v1/autocomplete/addresses?api_key=$_key&&query=$query'),
        headers: headers,
      );

      print('RegisterController.searchAddress ${response.body}');
      //    response = await _repository.searchAddress(query);

      if (response.statusCode == 200) {
        final Map<String, dynamic> mapdata = json.decode(response.body);
        for (var data in mapdata['result']['hits']) {
          addressList.add(AddressModel.fromJson(data));
        }
        print('address lng :: ${addressList.toString()}');
        return addressList;
      } else {
        return addressList;
      }
    } catch (ex) {
      return addressList;
    }
  }

  Future getAndSetAddressDetails(endpoint) async {
    dynamic response;

    try {
      var url = '$_baseUrl$endpoint?api_key=$_key';
      var headers = {
        "Accept": "application/json",
        'Content-type': 'application/json',
        'X-Requested-With': 'XMLHttpRequest',
      };

      http.Response response = await http.get(
        Uri.parse(url),
        headers: headers,
      );
      //response = await _repository.getAddressDetails(endpoint);

      print(
          'RegisterController.getAndSetAddressDetails ${response.statusCode}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> mapdata = json.decode(response.body);
        print('mapdata ::: ${mapdata.toString()}');
        // addressLineOneController.text = mapdata['result']['line_1'] ?? '';
        addressLineTwoController.text = mapdata['result']['line_2'] ?? '';
        addressLineThreeController.text = mapdata['result']['line_3'] ?? '';
        countryTextController.text = mapdata['result']['post_town'] ?? '';

        print('SubmitEdgeController >> ${countryTextController.text}');

        postcodeTextController.text = mapdata['result']['postcode'] ?? '';
      } else {
        clearController();
      }
    } catch (ex) {
      clearController();
    }
  }

  clearController() {
    addressLineOneController.clear();
    addressLineTwoController.clear();
    addressLineThreeController.clear();
    countryTextController.clear();
    postcodeTextController.clear();
  }

  @override
  void onInit() async {
    print('HomeController.onInit');
    apiService = ApiService();
    _apiClient = ApiClient();
    await getDetailsInfo();
    nameCon.text = proInfo.value.name ?? '';
    mailCon.text = proInfo.value.email ?? '';
    super.onInit();
  }

  void increment() => count.value++;

  // Current Active
  void selectImage(ImageSource source, String type) async {
    fileModeCameraOrVideo.value = type;
    print('SubmitEdgeController.selectImage :: ${fileModeCameraOrVideo.value}');
    debugPrint('source :: $source');
    debugPrint('type :: $type');
    if (imageFiles.length <= 3) {
      final picker = ImagePicker();
      final XFile? pickedFile;
      if (type == 'video') {
        pickedFile = await picker.pickVideo(source: source);
      } else {
        pickedFile = await picker.pickImage(source: source);
      }

      Get.back();

      if (pickedFile != null) {
        var descriptionCnt = TextEditingController();

        imageFile = File(pickedFile.path);
        imageFiles.add(File(pickedFile.path));

        descriptionCont.add(descriptionCnt);

        isVideoCapture.value = false;

        print('images lng : $imageFiles');
      }
    } else {
      Helpers.snackbarForErorr(
          titleText: 'Alert', bodyText: 'Maximum Three Images ');
    }
  }

  void selectVideo(ImageSource source) async {
    debugPrint('source :: $source');
    if (imageFiles.length <= 3) {
      final picker = ImagePicker();

      // final pickedFile=picker.pickVideo(source: source);
      final pickedFile = await picker.pickVideo(source: source);
      Get.back();
      if (pickedFile != null) {
        final descriptionCnt = TextEditingController();
      }
      imageFile = File(pickedFile!.path);
      imageFiles.add(
        File(pickedFile.path),
      );
      descriptionCont.add(descriptionCnt);
      isVideoCapture.value = true;
      print('images lng : $imageFiles');
    } else {
      Helpers.snackbarForErorr(
          titleText: 'Alert',
          bodyText: 'You cannot upload more then four files.');
    }
  }

  /// PostCode Check done
  Future postCodeCheck(String postCode) async {
    print('postCode $postCode');

    final response = await ApiService().connectionImage(
      API_TYPE: 'POST',
      apiType: 'POST',
      REQUEST_TYPE: '',
      REQUEST_DATA: {"postcode": postCode},
      apiUrl: 'https://www.edgeemg.co.uk/api/check-post-code',
      PARAM: {},
    );

    if (response != null) {
      final Map<String, dynamic> mapdata = response.data;
      print(mapdata);
      if (mapdata['status'] == 303) {
        print('mapdata :${mapdata['message']}');
        postCodeStatusMsg.value = mapdata['message'];
      } else {
        print('mapdata :${mapdata['message']}');
        print('postcode :${mapdata['data']['postcode']}');
        print('status :${mapdata['data']['status']}');
        postCodeStatusMsg.value = mapdata['message'];
        postCodeStatus.value = mapdata['data']['status'];
        searchPostCodeName.value = mapdata['data']['postcode'];
      }
    }
  }

  /// Work Submit  done Image
  Future<void> workSubmit(BuildContext context) async {
    print('SubmitEdgeController.workSubmit Image Upload ');
    final Directory tempDir = await getTemporaryDirectory();
    final targetPath = '${tempDir.absolute.path}/temp.jpg';
    //DBHelper.loadingDialog(Get.overlayContext!);
    if (imageFiles.isNotEmpty) {
      DBHelper.loadingDialog(Get.overlayContext!);
      List<http.MultipartFile> multipartFileList = [];
      loading.value = true;
      String? token = localStoreSRF.getString('token');
      Map<String, String> customHeader = {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      };

      final url = Uri.parse("https://www.edgeemg.co.uk/api/work");
      var request = http.MultipartRequest('POST', url);

      for (int i = 0; i < imageFiles.length; i++) {
        String extendFile = imageFiles[i].path.split('.').last;
        print('SubmitEdgeController extendFile >>$extendFile');

        if (extendFile.toLowerCase() == 'jpg' ||
            extendFile == 'png' ||
            extendFile == 'bmp' ||
            extendFile == 'webp' ||
            extendFile == 'heic' ||
            extendFile == 'jpge') {
          final targetPath = '${tempDir.absolute.path}/temp.jpg';
          final compressImage = await FlutterImageCompress.compressAndGetFile(
              imageFiles[i].path, targetPath,
              minHeight: 1000, minWidth: 1000, quality: 90);
          final bytes1 = compressImage!.readAsBytes().toString();
          final newKb = bytes1.length / 2024;
          final newMb = newKb / 2024;
          debugPrint('Compress Image Size newKb : ${newKb.toString()}');
          debugPrint('Compress Image Size newMb: ${newMb.toString()}');
          var length = await compressImage.length();
          var stream = http.ByteStream(compressImage.openRead());
          multipartFileList.add(
            http.MultipartFile(
                'images[]',
                File(compressImage.path).readAsBytes().asStream(),
                File(compressImage.path).lengthSync(),
                filename: targetPath),
          );

          print('Camera & Gallery');
        } else {
          print('Video Option ');
          multipartFileList.add(
            http.MultipartFile(
                'images[]',
                File(imageFiles[i].path).readAsBytes().asStream(),
                File(imageFiles[i].path).lengthSync(),
                filename: imageFiles[i].path),
          );
        }

        request.fields['descriptions[$i]'] = descriptionCont[i].text == ''
            ? 'no description'
            : descriptionCont[i].text;
      }
      print('multipartFileList final tesing  :: ${multipartFileList.length}');

      request.files.addAll(multipartFileList);

      Map<String, String> workSubmitMap = {
        "name": nameCon.text.toString(),
        "email": mailCon.text.toString(),
        "address_first_line": firstAddress.value == ''
            ? addressLineOneController.text.toString()
            : firstAddress.value,
        "address_second_line": addressLineTwoController.text.toString(),
        "address_third_line": addressLineThreeController.text.toString(),
        "phone": phoneCon.text.toString(),
        "town": countryTextController.text.toString(),
        "post_code": postcodeTextController.text,

        // 'descriptions[]': 'This is first description u13@gmail.com',
      };

      print(workSubmitMap);
      request.fields.addAll(workSubmitMap);
      request.headers.addAll(customHeader);

      try {
        var response = await request.send();
        var responseStream = await response.stream.bytesToString();
        //  pDialog.hide();

        debugPrint(' status code : ${response.statusCode}');
        debugPrint('responseStream  : $responseStream');

        if (response.statusCode == 200) {
          // pDialog.hide();
          return showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                  width: 390,
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        ' Work Order is added successfully! ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                      Image.asset('assets/images/successful.png'),
                      AppSpace.spaceH10,
                      ElevatedButton(
                        onPressed: () {
                          //nameCon.clear();
                          //mailCon.clear();
                          phoneCon.clear();
                          streetCon.clear();
                          townCon.clear();
                          postCon.clear();
                          houseCon.clear();
                          countryTextController.clear();
                          // nameCon.clear();
                          commentCon.clear();
                          addressLineThreeController.clear();
                          addressLineOneController.clear();
                          addressLineTwoController.clear();
                          descriptionCont.clear();
                          postcodeTextController.clear();
                          postCodeStatusMsg.value = '';
                          postCodeStatus.value = '';
                          imageFiles.clear();

                          isUseRegisterAddress.value = false;
                          isUseRegisterNumber.value = false;
                          isVideoCapture.value = false;
                          DBHelper.loadingClose();
                          // pDialog.hide();
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          // primary: Colors.green,
                          minimumSize: const Size(150, 40),
                        ),
                        child: const Text(
                          'Ok',
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else if (response.statusCode.toString() == '302') {
          //  pDialog.hide();
          print('SubmitEdgeController.workSubmit 302');
          DBHelper.loadingClose();
          loading.value = false;
        } else {
          // pDialog.hide();
          loading.value = false;
          DBHelper.loadingClose();
          Get.snackbar(
            'Error',
            'Status code :  ${response.statusCode.toString()}\n work order has Failed ',
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } catch (e) {
        DBHelper.loadingClose();
        //  pDialog.hide();
        Get.snackbar(
          'Failed',
          e.toString(),
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        print('Error occurred: $e');
      }
      loading.value = false;
      // pDialog.hide();
    } else {
      Helpers.snackbarForErorr(
          titleText: 'Alert Message', bodyText: 'Image field required.');
    }
  }

  /// Work Submit  done Video
  Future<void> workSubmitVideo(BuildContext context) async {
    print('SubmitEdgeController.workSubmitVideo Video Upload ');
    final Directory tempDir = await getTemporaryDirectory();
    final targetPath = '${tempDir.absolute.path}/temp.mp4';
    //DBHelper.loadingDialog(Get.overlayContext!);
    if (imageFiles.isNotEmpty) {
      DBHelper.loadingDialog(Get.overlayContext!);
      List<http.MultipartFile> multipartFileList = [];
      loading.value = true;
      String? token = localStoreSRF.getString('token');
      Map<String, String> customHeader = {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      };

      final url = Uri.parse("https://www.edgeemg.co.uk/api/work");
      var request = http.MultipartRequest('POST', url);

      for (int i = 0; i < imageFiles.length; i++) {
        request.fields['descriptions[$i]'] = descriptionCont[i].text;
        multipartFileList.add(
          http.MultipartFile(
              'images[]',
              File(imageFiles[i].path).readAsBytes().asStream(),
              File(imageFiles[i].path).lengthSync(),
              filename: targetPath),
        );
      }

      request.files.addAll(multipartFileList);
      Map<String, String> workSubmitMap = {
        "name": nameCon.text.toString(),
        "email": mailCon.text.toString(),
        "address_first_line": firstAddress.value == ''
            ? addressLineOneController.text.toString()
            : firstAddress.value,
        "address_second_line": addressLineTwoController.text.toString(),
        "address_third_line": addressLineThreeController.text.toString(),
        "phone": phoneCon.text.toString(),
        "town": countryTextController.text.toString(),
        "post_code": postcodeTextController.text,
      };

      print(workSubmitMap);
      request.fields.addAll(workSubmitMap);
      request.headers.addAll(customHeader);

      try {
        var response = await request.send();
        var responseStream = await response.stream.bytesToString();
        //  pDialog.hide();

        debugPrint(' status code : ${response.statusCode}');
        debugPrint('responseStream  : $responseStream');

        if (response.statusCode == 200) {
          // pDialog.hide();
          return showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                  width: 390,
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        ' Work Order is added successfully! ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                      Image.asset('assets/images/successful.png'),
                      AppSpace.spaceH10,
                      InkWell(
                        onTap: () {
                          //nameCon.clear();
                          //mailCon.clear();
                          phoneCon.clear();
                          streetCon.clear();
                          townCon.clear();
                          postCon.clear();
                          houseCon.clear();
                          countryTextController.clear();
                          // nameCon.clear();
                          commentCon.clear();
                          addressLineThreeController.clear();
                          addressLineOneController.clear();
                          addressLineTwoController.clear();
                          descriptionCont.clear();
                          postcodeTextController.clear();
                          postCodeStatusMsg.value = '';
                          postCodeStatus.value = '';
                          imageFiles.clear();

                          isUseRegisterAddress.value = false;
                          isUseRegisterNumber.value = false;
                          isVideoCapture.value = false;

                          DBHelper.loadingClose();
                          // pDialog.hide();
                          Get.back();
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
                            "OK".toUpperCase(),
                            style: const TextStyle(
                                fontSize: 18, color: Colors.white),
                          )),
                        ),
                      ),

                      /*ElevatedButton(
                        onPressed: () {

                          //nameCon.clear();
                          //mailCon.clear();
                          phoneCon.clear();
                          streetCon.clear();
                          townCon.clear();
                          postCon.clear();
                          houseCon.clear();
                          countryTextController.clear();
                          // nameCon.clear();
                          commentCon.clear();
                          addressLineThreeController.clear();
                          addressLineOneController.clear();
                          addressLineTwoController.clear();
                          descriptionCont.clear();
                          postcodeTextController.clear();
                          postCodeStatusMsg.value='';
                          postCodeStatus.value='';
                          imageFiles.clear();

                          isUseRegisterAddress.value=false;
                          isUseRegisterNumber.value=false;
                          isVideoCapture.value=false;

                          DBHelper.loadingClose();
                          // pDialog.hide();
                          Get.back();



                        },
                        child: Text(
                          'Ok',
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          primary: Colors.green,
                          minimumSize: Size(150, 40),
                        ),
                      ),*/
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else if (response.statusCode.toString() == '302') {
          //  pDialog.hide();
          print('SubmitEdgeController.workSubmit 302');
          DBHelper.loadingClose();
          loading.value = false;
        } else {
          // pDialog.hide();
          loading.value = false;
          DBHelper.loadingClose();
          Get.snackbar(
            'Error',
            'Status code :  ${response.statusCode.toString()}\n work order has Failed ',
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } catch (e) {
        DBHelper.loadingClose();
        //  pDialog.hide();
        Get.snackbar(
          'Failed',
          e.toString(),
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        print('Error occurred: $e');
      }
      loading.value = false;
      // pDialog.hide();
    } else {
      Helpers.snackbarForErorr(
          titleText: 'Alert Message', bodyText: 'Image field required.');
    }
  }

  /// Work Submit  done testing
  /* Future<void> workSubmit1(BuildContext context) async {
    final Directory tempDir = await getTemporaryDirectory();
    final  targetPath =tempDir.absolute.path+'/temp.jpg';
    //DBHelper.loadingDialog(Get.overlayContext!);
    if(imageFiles.isNotEmpty){
      DBHelper.loadingDialog(Get.overlayContext!);
      List des=[];
      */ /*for (int i = 0; i < imageFiles.length; i++) {
    //  des.add(descriptionCont[i].text);
    }*/ /*
      // print('des ${des.length}');
      //  print('des tite ${des.toString()}');
      //   print('des:: ${descriptionCont[0].text}');



      String? token = await localStoreSRF.getString('token');
      Map<String,String>  customheader={
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };


      List<http.MultipartFile> multipartFileList = [];
      loading.value=true;
      final url =Uri.parse('https://www.edgeemg.co.uk/api/work');
      var request = http.MultipartRequest('POST', url);

      for (int i = 0; i < imageFiles.length; i++) {
        des.add(descriptionCont[i].text);

         final  targetPath =tempDir.absolute.path+'/temp.jpg';
        final compressImage=await FlutterImageCompress.compressAndGetFile(imageFiles[i].path,targetPath,minHeight: 1000,minWidth: 1000,quality: 90);
        final bytes1 = compressImage!.readAsBytes().toString();
        final newKb =bytes1.length/2024;
        final newMb =newKb/2024;

        debugPrint('Compress Image Size newKb : ${newKb.toString()}');
        debugPrint('Compress Image Size newMb: ${newMb.toString()}');

        var length = await compressImage.length();
        var stream = http.ByteStream(compressImage.openRead());

        */ /*String fileName = imageFiles[i].path.split('/').last;
      http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
        'images[]',
        imageFiles[i].path,
        filename: fileName,
      );*/ /*

        request.files.add(
            http.MultipartFile('images[]',
                File(compressImage.path).readAsBytes().asStream(), File(compressImage.path).lengthSync(),
                filename: (compressImage.path.split("/").last)));
           request.fields.addAll({'descriptions[]':descriptionCont[i].text});

        //request.files.add(multipartFile);
        print('Image Files :: ${imageFiles[i].path}');
      }

      Map<String,String> workSubmitMap={
        "name": nameCon.text.toString(),
        "email": mailCon.text.toString(),
        "address_first_line": firstAddress.value==''?  addressLineOneController.text.toString():firstAddress.value,
        "address_second_line": addressLineTwoController.text.toString(),
        "address_third_line": addressLineThreeController.text.toString(),
        "phone":phoneCon.text.toString(),
        //"street":street,
        "town":countryTextController.text.toString(),
        // "house_number":house_number,
        "post_code":postcodeTextController.text,
        //"descriptions[]":des.toString(),

      };
      print(workSubmitMap);
      request.fields.addAll(workSubmitMap);
      request.headers.addAll(customheader);

      // var length1 = await imageFiles[0].length();
      // debugPrint('length $length1');

      //final bytes =await imageFiles[0].readAsBytes();
      // final kb =bytes.length/2024;
      //final mb =kb/2024;

      //debugPrint('orginal Image Size kb : ${kb.toString()}');
      //  debugPrint('orginal Image Size mb : ${mb.toString()}');



      // final compressImage=await FlutterImageCompress.compressAndGetFile(imageFiles[0].path,targetPath,minHeight: 1000,minWidth: 1000,quality: 90);

      */ /* final bytes1 = compressImage!.readAsBytes().toString();
    final newKb =bytes1.length/2024;
    final newMb =newKb/2024;

    debugPrint('Compress Image Size newKb : ${newKb.toString()}');
    debugPrint('Compress Image Size newMb: ${newMb.toString()}');

    var length = await compressImage.length();
    var stream = http.ByteStream(compressImage.openRead());
*/ /*

//request.files.add(await http.MultipartFile.fromPath('images[]', 'postman-cloud:///1eeee9b2-4226-4700-8b08-f2b2243ddff3'));


      // var multipartFile = http.MultipartFile('images[]', stream, length, filename: compressImage.path.split('/').last);
      // request.files.add(multipartFile);

      try {

        var response = await request.send();

        var responseStream = await response.stream.bytesToString();
        //  pDialog.hide();

        debugPrint(' status code : ${response.statusCode}');
        debugPrint('responseStream  : $responseStream');


        if (response.statusCode == 200) {
          // pDialog.hide();
          return showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                  width: 390,
                  padding: EdgeInsets.all(16.0),
                  child:
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        ' Work Order is added successfully! ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.green),
                      ),

                      Image.asset('assets/images/successful.png'),
                      AppSpace.spaceH10,
                      ElevatedButton(
                        onPressed: () {

                          nameCon.clear();
                          mailCon.clear();
                          phoneCon.clear();
                          streetCon.clear();
                          townCon.clear();
                          postCon.clear();
                          houseCon.clear();
                          countryTextController.clear();
                          nameCon.clear();
                          commentCon.clear();
                          addressLineThreeController.clear();
                          addressLineOneController.clear();
                          addressLineTwoController.clear();
                          descriptionCont.clear();
                          postcodeTextController.clear();
                          postCodeStatusMsg.value='';
                          postCodeStatus.value='';
                          imageFiles.clear();

                          isUseRegisterAddress.value=false;
                          isUseRegisterNumber.value=false;

                          DBHelper.loadingClose();
                          // pDialog.hide();
                          Get.back();



                        },
                        child: Text(
                          'Ok',
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          primary: Colors.green,
                          minimumSize: Size(150, 40),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),



                    ],
                  ),
                ),
              );
            },
          );
        }

        else if(response.statusCode.toString()=='302'){
          //  pDialog.hide();
          print('SubmitEdgeController.workSubmit 302');
          DBHelper.loadingClose();
          loading.value=false;
        }
        else {
          // pDialog.hide();
          loading.value=false;
          Get.snackbar(
            'Error',
            'Status code :  ${response.statusCode.toString()}\n work order has Failed ',
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }

      } catch (e) {
        //  pDialog.hide();
        Get.snackbar(
          'Failed',
          e.toString(),
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        print('Error occurred: $e');
      }
      loading.value=false;
      // pDialog.hide();

    }else{
      Helpers.snackbarForErorr(
          titleText: 'Alert Message', bodyText: 'Image field required.');
    }
  }
*/

  /// done
  Future getDetailsInfo() async {
    print('DashboardController.getUserDetailsCTR');
    // String? token = await localStoreSRF.getString('token');
    String? token = localStoreSRF.getString('token');
    final response = await _apiClient.connection(
      API_TYPE: 'GET',
      apiType: 'GET',
      REQUEST_TYPE: '',
      REQUEST_DATA: {},
      customheader: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      apiUrl: ApiURL.userDetailsUrl,
      PARAM: {},
    );

    if (response != null) {
      print('HomeController.homeAllProductsCTR');
      final Map<String, dynamic> mapdata = response.data;
      var info = mapdata['response']['data'];
      proInfo.value = UserProfileModel.fromJson(info);

      /*nameCTL.text=proInfo.value.name.toString();
      companyCTL.text=proInfo.value.surname.toString();
      // passwordCTL.text=proInfo.value.phone.toString();
      mailCTL.text=proInfo.value.email.toString();
      mobileCTL.text=proInfo.value.phone.toString();
      postCodeCTL.text=proInfo.value.postcode.toString();
      addressFirstLineCTL.text=proInfo.value.addressFirstLine.toString();
      addressSecondLineCTL.text=proInfo.value.addressSecondLine.toString();
      addressThirdLineCTL.text=proInfo.value.addressThirdLine.toString();
    */
    }
  }

  Future accountCheck() async {
    String? id = localStoreSRF.getString('id');

    print('user Id ::$id');
  }
}
