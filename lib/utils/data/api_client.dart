import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:tot_pro/utils/data/snackbar.dart';
import 'helper.dart';

class ApiClient {
  late Dio _dio;

  ApiClient({int? connectTimeout, int? receiveTimeout}) {
    print('ApiClient.ApiClient');
    _dio = Dio();
    _dio.options.connectTimeout =
        Duration(milliseconds: connectTimeout ?? 60000); //1000 = 1s
    _dio.options.receiveTimeout =
        Duration(milliseconds: receiveTimeout ?? 60000);
  }

  void endConnection() => _dio.close(force: true);

  Future<dio.Response?> connectionNew({
    required String API_TYPE,
    required String REQUEST_TYPE,
    required Map<String, dynamic> REQUEST_DATA,
    required Map<String, dynamic> PARAM,
    required String apiType,
    String? apiUrl,
    List<File>? imageFileList,
    bool enableLoading = true,
    Map<String, dynamic>? customheader,
    String? successMessage,
    String? successMessageKey,
    String? errorMessage,
  }) async {
    dio.FormData formData = dio.FormData();

    dio.Response? response;
    String url = '';

    if (apiUrl == null) {
    } else {
      url = apiUrl;
    }

    if (API_TYPE == "STANDING") {
      dio.FormData.fromMap(REQUEST_DATA);
    }

    Map<String, dynamic> header = customheader ??
        <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Access-Control-Allow-Origin': '*',
        };

    if (imageFileList != null) {
      formData.files.addAll(
        imageFileList
            .map(
              (element) => MapEntry(
                'image',
                dio.MultipartFile.fromFileSync(
                  element.path,
                  contentType: DioMediaType.parse('image/*'),
                  filename: 'image.jpg',
                ),
              ),
            )
            .toList(),
      );
    }

    List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());

    if (connectivityResult[0] == ConnectivityResult.mobile ||
        connectivityResult[0] == ConnectivityResult.wifi) {
      try {
        //  if (enableLoading) showLoader();

        if (apiType == 'GET') {
          print('ApiClient.connection ??? GET ');

          response = await _dio.get(
            url,
            options: dio.Options(headers: header),
          );
          print('ApiClient.connection Header $customheader');
          print('ApiClient.connection Make ${jsonEncode(REQUEST_DATA)}');
          print('ApiClient.connection ${response.statusCode}');
          //  print('ApiClient.connection >>>>> ${response.data}');
          print('url : $url');
        } else {
          print('url : $url');
          print('ApiClient.connection POST ');

          response = await _dio.post(
            url,
            data: REQUEST_DATA, // formData,

            options: dio.Options(headers: header),
          );
        }

        print('ApiClient.connection ???? $url');
        print('ApiClient.connection code ???? ${response.statusCode}');
        print('ApiClient.connection data ???? ${response.data}');

        //  if (enableLoading) loaderDismiss();
      } on DioException catch (e) {
        //  if (enableLoading) loaderDismiss();
        String errorMessage = '';
        debugPrint(e.toString());
        if (e.type == DioExceptionType.connectionTimeout) {
          errorMessage = e.message ?? 'Connection timeout';
        }
        if (e.type == DioExceptionType.sendTimeout) {
          errorMessage = e.message ?? 'Send timeout';
        }
        if (e.type == DioExceptionType.receiveTimeout) {
          errorMessage = e.message ?? 'Receive timeout';
        }
        if (e.type == DioExceptionType.badCertificate) {
          errorMessage = e.message ?? 'Bad certificate';
        }
        if (e.type == DioExceptionType.badResponse) {
          errorMessage = e.message ?? 'Bad response';
        }
        if (e.type == DioExceptionType.cancel) {
          errorMessage = e.message ?? 'Your request is cancled';
        }
        if (e.type == DioExceptionType.connectionError) {
          errorMessage = e.message ?? 'Connection error';
        }
        if (e.type == DioExceptionType.unknown) {
          errorMessage = e.message ?? 'Unknown error';
        }
        debugPrint(errorMessage);
        //    errorSnack(errorMessage);
        return null;
      } on SocketException catch (e) {
        // if (enableLoading) loaderDismiss();
        String errorMessage = e.message;
        debugPrint(errorMessage);
        // errorSnack(errorMessage);
        return null;
      } catch (e) {
        if (enableLoading) loaderDismiss();
        String errorMessage = e.toString();
        debugPrint(errorMessage);
        errorSnack(errorMessage);
        return null;
      }
      final Map<String, dynamic> mapdata = response.data;
      if (response.statusCode == 200) {
        return response;
      } else {
        //Error Response (error provided by REST API)
        if (errorMessage != null) {
          //Showing errror provided by error message
          //  errorSnack(errorMessage);
        } else {
          //    errorSnack(mapdata['response']['message']);
        }
        return null;
      }
    } else {
      //alertSnack('Sorry, You are not connected with mobile/wifi network');
    }
    return null;
  }

  Future<dio.Response?> connection({
    required String API_TYPE,
    required String REQUEST_TYPE,
    required Map<String, String> REQUEST_DATA,
    required Map<String, dynamic> PARAM,
    required String apiType,
    String? apiUrl,
    List<File>? imageFileList,
    bool enableLoading = true,
    Map<String, dynamic>? customheader,
    String? successMessage,
    String? successMessageKey,
    String? errorMessage,
  }) async {
    dio.FormData formData = dio.FormData();

    dio.Response? response;
    String url = '';

    if (apiUrl == null) {
    } else {
      url = apiUrl;
    }

    log('url: ' + url);
    log('body: $REQUEST_DATA');
    log('header: ' + customheader.toString());

    Map<String, dynamic> header = customheader ??
        <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Access-Control-Allow-Origin': '*',
        };

    if (imageFileList != null) {
      formData.files.addAll(
        imageFileList
            .map(
              (element) => MapEntry(
                'image',
                dio.MultipartFile.fromFileSync(
                  element.path,
                  contentType: DioMediaType.parse('image/*'),
                  filename: 'image.jpg',
                ),
              ),
            )
            .toList(),
      );
    }

    List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());

    if (connectivityResult[0] == ConnectivityResult.mobile ||
        connectivityResult[0] == ConnectivityResult.wifi) {
      try {
        if (enableLoading) showLoader();

        if (apiType == 'GET') {
          print('ApiClient.connection ??? GET ');

          response = await _dio.get(
            url,
            options: dio.Options(headers: header),
          );

          print('ApiClient.connection ${response.statusCode}');
          // print('ApiClient.connection >>>>> ${response.data}');
        } else if (apiType == 'DELETE') {
          print('ApiClient.connection DELETE ');
          response = await _dio.delete(
            url,
            // data: REQUEST_DATA, // formData,
            options: dio.Options(headers: header),
          );
        } else if (apiType == 'PUT') {
          print('ApiClient.connection DELETE ');
          response = await _dio.put(
            url,
            data: REQUEST_DATA, // formData,
            options: dio.Options(headers: header),
          );
        } else {
          print('ApiClient.connection POST ');
          response = await _dio.post(
            url,
            data: REQUEST_DATA, // formData,

            options: dio.Options(headers: header),
          );
        }

        log(response.statusCode.toString());
        log(response.data.toString());

        print('ApiClient.connection ???? $url');

        if (enableLoading) loaderDismiss();
      } on DioException catch (e) {
        if (enableLoading) loaderDismiss();
        String errorMessage = '';
        debugPrint(e.toString());
        if (e.type == DioExceptionType.connectionTimeout) {
          errorMessage = e.message ?? 'Connection timeout';
        }
        if (e.type == DioExceptionType.sendTimeout) {
          errorMessage = e.message ?? 'Send timeout';
        }
        if (e.type == DioExceptionType.receiveTimeout) {
          errorMessage = e.message ?? 'Receive timeout';
        }
        if (e.type == DioExceptionType.badCertificate) {
          errorMessage = e.message ?? 'Bad certificate';
        }
        if (e.type == DioExceptionType.badResponse) {
          errorMessage = e.response!.statusMessage.toString() ?? 'Bad response';
        }
        if (e.type == DioExceptionType.cancel) {
          errorMessage = e.message ?? 'Your request is cancel';
        }
        if (e.type == DioExceptionType.connectionError) {
          errorMessage = e.message ?? 'Connection error';
        }
        if (e.type == DioExceptionType.unknown) {
          errorMessage = e.message ?? 'Unknown error';
        }
        debugPrint(errorMessage);
        errorSnack(errorMessage);

        return null;
      } on SocketException catch (e) {
        if (enableLoading) loaderDismiss();
        String errorMessage = e.message;
        debugPrint(errorMessage);
        errorSnack(errorMessage);
        return null;
      } catch (e) {
        if (enableLoading) loaderDismiss();
        String errorMessage = e.toString();
        debugPrint(errorMessage);
        errorSnack(errorMessage);
        return null;
      }
      print('res status code :: ${response.statusCode.toString()}');
      // print('res status data :: ${response.data.toString()}');
      final Map<String, dynamic> mapdata = response.data;

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        //Error Response (error provided by REST API)
        if (errorMessage != null) {
          //Showing errror provided by error message
          //   errorSnack(errorMessage);
        } else {
          //errorSnack(mapdata['response']['message']);
        }
        return response;
      }
    } else {
      alertSnack('Sorry, You are not connected with mobile-wifi network');
    }
    return response;
  }

  Future<dio.Response?> connectionWork({
    required String API_TYPE,
    required String REQUEST_TYPE,
    required Map<String, String> REQUEST_DATA,
    required Map<String, dynamic> PARAM,
    required String apiType,
    String? apiUrl,
    List<File>? imageFileList,
    bool enableLoading = true,
    Map<String, dynamic>? customheader,
    String? successMessage,
    String? successMessageKey,
    String? errorMessage,
  }) async {
    dio.FormData formData = dio.FormData();

    dio.Response? response;
    String url = '';

    if (apiUrl == null) {
    } else {
      url = apiUrl;
    }

    Map<String, dynamic> header = customheader ??
        <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Access-Control-Allow-Origin': '*',
        };

    if (imageFileList != null) {
      formData.files.addAll(
        imageFileList
            .map(
              (element) => MapEntry(
                'image',
                dio.MultipartFile.fromFileSync(
                  element.path,
                  contentType: DioMediaType.parse('image/*'),
                  filename: 'image.jpg',
                ),
              ),
            )
            .toList(),
      );
    }

    List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());

    if (connectivityResult[0] == ConnectivityResult.mobile ||
        connectivityResult[0] == ConnectivityResult.wifi) {
      try {
        if (enableLoading) showLoader();

        if (apiType == 'GET') {
          print('ApiClient.connection ??? GET ');

          response = await _dio.get(
            url,
            options: dio.Options(headers: header),
          );

          print('ApiClient.connection ${response.statusCode}');
          // print('ApiClient.connection >>>>> ${response.data}');
        } else if (apiType == 'DELETE') {
          print('ApiClient.connection DELETE ');
          response = await _dio.delete(
            url,
            // data: REQUEST_DATA, // formData,
            options: dio.Options(headers: header),
          );
        } else if (apiType == 'PUT') {
          print('ApiClient.connection DELETE ');
          response = await _dio.put(
            url,
            data: REQUEST_DATA, // formData,
            options: dio.Options(headers: header),
          );
        } else {
          print('ApiClient.connection POST ');
          response = await _dio.post(
            url,
            data: REQUEST_DATA, // formData,

            options: dio.Options(headers: header),
          );
        }

        print('ApiClient.connection ???? $url');

        if (enableLoading) loaderDismiss();
      } on DioException catch (e) {
        if (enableLoading) loaderDismiss();
        String errorMessage = '';
        debugPrint(e.toString());
        if (e.type == DioExceptionType.connectionTimeout) {
          errorMessage = e.message ?? 'Connection timeout';
        }
        if (e.type == DioExceptionType.sendTimeout) {
          errorMessage = e.message ?? 'Send timeout';
        }
        if (e.type == DioExceptionType.receiveTimeout) {
          errorMessage = e.message ?? 'Receive timeout';
        }
        if (e.type == DioExceptionType.badCertificate) {
          errorMessage = e.message ?? 'Bad certificate';
        }
        if (e.type == DioExceptionType.badResponse) {
          final Map<String, dynamic> mapdata = e.response!.data;
          errorMessage = mapdata['response']['message'];
          // errorMessage = 'No Uploads found for the given work Id';
        }
        if (e.type == DioExceptionType.cancel) {
          errorMessage = e.message ?? 'Your request is cancel';
        }
        if (e.type == DioExceptionType.connectionError) {
          errorMessage = e.message ?? 'Connection error';
        }
        if (e.type == DioExceptionType.unknown) {
          errorMessage = e.message ?? 'Unknown error';
        }
        debugPrint(errorMessage);
        errorSnack(errorMessage);

        return null;
      } on SocketException catch (e) {
        if (enableLoading) loaderDismiss();
        String errorMessage = e.message;
        debugPrint(errorMessage);
        errorSnack(errorMessage);
        return null;
      } catch (e) {
        if (enableLoading) loaderDismiss();
        String errorMessage = e.toString();
        debugPrint(errorMessage);
        errorSnack(errorMessage);
        return null;
      }
      print('res status code :: ${response.statusCode.toString()}');
      // print('res status data :: ${response.data.toString()}');
      final Map<String, dynamic> mapdata = response.data;

      if (response.statusCode == 200) {
        return response;
      } else {
        //Error Response (error provided by REST API)
        if (errorMessage != null) {
          //Showing errror provided by error message
          //   errorSnack(errorMessage);
        } else {
          //errorSnack(mapdata['response']['message']);
        }
        return null;
      }
    } else {
      alertSnack('Sorry, You are not connected with mobile-wifi network');
    }
    return null;
  }

  ///---------------------------- Login --------------

  Future<dio.Response?> connectionLogin({
    required String API_TYPE,
    required String REQUEST_TYPE,
    required Map<String, String> REQUEST_DATA,
    required Map<String, dynamic> PARAM,
    required String apiType,
    String? apiUrl,
    List<File>? imageFileList,
    bool enableLoading = true,
    Map<String, dynamic>? customheader,
    String? successMessage,
    String? successMessageKey,
    String? errorMessage,
  }) async {
    dio.FormData formData = dio.FormData();

    dio.Response? response;
    String url = '';

    if (apiUrl == null) {
    } else {
      url = apiUrl;
    }

    Map<String, dynamic> header = customheader ??
        <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Access-Control-Allow-Origin': '*',
        };

    List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());

    if (connectivityResult[0] == ConnectivityResult.mobile ||
        connectivityResult[0] == ConnectivityResult.wifi) {
      try {
        if (enableLoading) showLoader();

        log('ApiClient.connection POST >>>>>>>>>>>> $url $REQUEST_DATA $header');
        response = await _dio.post(
          url,
          data: REQUEST_DATA, // formData,

          options: dio.Options(headers: header),
        );

        print('ApiClient.connection ???? $url');

        if (enableLoading) loaderDismiss();
      } on DioException catch (e) {
        if (enableLoading) loaderDismiss();
        String errorMessage = '';
        debugPrint(e.toString());
        if (e.type == DioExceptionType.connectionTimeout) {
          errorMessage = e.message ?? 'Connection timeout';
        }
        if (e.type == DioExceptionType.sendTimeout) {
          errorMessage = e.message ?? 'Send timeout';
        }
        if (e.type == DioExceptionType.receiveTimeout) {
          errorMessage = e.message ?? 'Receive timeout';
        }
        if (e.type == DioExceptionType.badCertificate) {
          errorMessage = e.message ?? 'Bad certificate';
        }
        if (e.type == DioExceptionType.badResponse) {
          // errorSnack('Credential Error. You are not authenticate user..');
          errorMessage = 'Credential Error. You are not authenticate user..';
        }
        if (e.type == DioExceptionType.cancel) {
          errorMessage = e.message ?? 'Your request is cancled';
        }
        if (e.type == DioExceptionType.connectionError) {
          errorMessage = e.message ?? 'Connection error';
        }
        if (e.type == DioExceptionType.unknown) {
          errorMessage = e.message ?? 'Unknown error';
        }
        debugPrint(errorMessage);
        errorSnack(errorMessage);
        return null;
      } on SocketException catch (e) {
        if (enableLoading) loaderDismiss();
        String errorMessage = e.message;
        debugPrint(errorMessage);
        errorSnack(errorMessage);
        return null;
      } catch (e) {
        if (enableLoading) loaderDismiss();
        String errorMessage = e.toString();
        debugPrint(errorMessage);
        errorSnack(errorMessage);
        return null;
      }
      final Map<String, dynamic> mapdata = response.data;
      if (response.statusCode == 200) {
        return response;
      } else {
        //Error Response (error provided by REST API)
        if (errorMessage != null) {
          //Showing errror provided by error message
          errorSnack(errorMessage);
        } else {
          errorSnack(mapdata['message']);
        }
        return null;
      }
    } else {
      alertSnack('Sorry, You are not connected with mobile/wifi network');
    }
    return null;
  }

//------------------ ******************* ----------------------
  Future<dio.Response?> uploadProfileImage({
    required String profileImagePath,
    required Map<String, dynamic> PARAM,
    required String? tokenValue,
    String? apiUrl,
    List<File>? imageFileList,
    bool enableLoading = true,
    Map<String, dynamic>? customheader,
    String? successMessage,
    String? successMessageKey,
    String? errorMessage,
  }) async {
    dio.FormData formData = dio.FormData();

    dio.Response? response;
    String url = '';

    if (apiUrl == null) {
    } else {
      url = apiUrl;
    }

    List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());

    if (connectivityResult[0] == ConnectivityResult.mobile ||
        connectivityResult[0] == ConnectivityResult.wifi) {
      try {
        Map<String, dynamic> headToken = {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $tokenValue'
        };

        if (enableLoading) showLoader();

        print('ApiClient.connection POST >>>>>>>>>>>> ');
        FormData formData = FormData.fromMap({
          "image": await MultipartFile.fromFile(profileImagePath),
        });

        var res = await _dio.post(
          url,
          data: formData,
          options: dio.Options(headers: headToken),
        );
        print('res :${res.statusCode}');
        print('res :${res.statusMessage}');
        print('res :${res.data}');

        print('ApiClient.connection ???? $url');

        if (enableLoading) loaderDismiss();
      } on DioException catch (e) {
        if (enableLoading) loaderDismiss();
        String errorMessage = '';
        debugPrint(e.toString());
        if (e.type == DioExceptionType.connectionTimeout) {
          errorMessage = e.message ?? 'Connection timeout';
        }
        if (e.type == DioExceptionType.sendTimeout) {
          errorMessage = e.message ?? 'Send timeout';
        }
        if (e.type == DioExceptionType.receiveTimeout) {
          errorMessage = e.message ?? 'Receive timeout';
        }
        if (e.type == DioExceptionType.badCertificate) {
          errorMessage = e.message ?? 'Bad certificate';
        }
        if (e.type == DioExceptionType.badResponse) {
          errorSnack('Credential Error. You are not authenticate user..');
          errorMessage = '';
        }
        if (e.type == DioExceptionType.cancel) {
          errorMessage = e.message ?? 'Your request is cancled';
        }
        if (e.type == DioExceptionType.connectionError) {
          errorMessage = e.message ?? 'Connection error';
        }
        if (e.type == DioExceptionType.unknown) {
          errorMessage = e.message ?? 'Unknown error';
        }
        debugPrint(errorMessage);
        errorSnack(errorMessage);
        return null;
      } on SocketException catch (e) {
        if (enableLoading) loaderDismiss();
        String errorMessage = e.message;
        debugPrint(errorMessage);
        errorSnack(errorMessage);
        return null;
      } catch (e) {
        if (enableLoading) loaderDismiss();
        String errorMessage = e.toString();
        debugPrint(errorMessage);
        errorSnack(errorMessage);
        return null;
      }
    } else {
      alertSnack('Sorry, You are not connected with mobile/wifi network');
    }
    return null;
  }
}
