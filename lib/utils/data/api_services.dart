import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:tot_pro/utils/data/snackbar.dart';
import 'helper.dart';

class ApiService {
  late Dio _dio;

  ApiService({int? connectTimeout, int? receiveTimeout}) {
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
            'images[]',
            dio.MultipartFile.fromFileSync(
              element.path,
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
        // if (enableLoading) showLoader();


        print('url : $url');
        print('ApiClient.connection POST ');

        response = await _dio.post(
          url,
          data: REQUEST_DATA,// formData,

          options: dio.Options(headers: header),
        );


        print('ApiClient.connection ???? $url');
        print('ApiClient.connection code ???? ${response.statusCode}');
        print('ApiClient.connection data ???? ${response.data}');

        //if (enableLoading) loaderDismiss();
      } on DioException catch (e) {
        //   if (enableLoading) loaderDismiss();
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
        errorSnack(errorMessage);
        return null;
      } on SocketException catch (e) {
         if (enableLoading) loaderDismiss();
        String errorMessage = e.message;
        debugPrint(errorMessage);
         errorSnack(errorMessage);
        return null;
      } catch (e) {
        // if (enableLoading) loaderDismiss();
        String errorMessage = e.toString();
        debugPrint(errorMessage);
        print('errorMessage :$errorMessage');
            errorSnack(errorMessage);
        return null;
      }
      final Map<String, dynamic> mapdata = response.data;
      if (response.statusCode == 200) {
        return response;
      }
      else {
        //Error Response (error provided by REST API)
        if (errorMessage != null) {
          //Showing errror provided by error message
          errorSnack(errorMessage);
        } else {
          //errorSnack(mapdata['response']['message']);
        }
        return null;
      }
    } else {

      // alertSnack('Sorry, You are not connected with mobile/wifi network');
    }
    return null;
  }

  Future<dio.Response?> connectionImage({
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


    formData= dio.FormData.fromMap(REQUEST_DATA);




    dio.Response? response;
    String url = '';

    if (apiUrl == null) {
    } else {
      url = apiUrl;
    }




    Map<String, dynamic> header = customheader ??
        <String, String>{
          'Accept': 'application/json',
        };

    if (imageFileList != null) {
      formData.files.addAll(
        imageFileList
            .map(
              (element) => MapEntry(
            'images[]',
            dio.MultipartFile.fromFileSync(
              element.path,
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
        // if (enableLoading) showLoader();


        print('url : $url');
        print('ApiClient.connection POST ');

        response = await _dio.post(
          url,
          data:  formData,

          options: dio.Options(headers: header),
        );


        print('ApiClient.connection ???? $url');
        print('ApiClient.connection code ???? ${response.statusCode}');
        print('ApiClient.connection data ???? ${response.data}');

        //if (enableLoading) loaderDismiss();
      } on DioException catch (e) {
        //   if (enableLoading) loaderDismiss();
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
        errorSnack(errorMessage);
        return null;
      } on SocketException catch (e) {
        // if (enableLoading) loaderDismiss();
        String errorMessage = e.message;
        debugPrint(errorMessage);
         errorSnack(errorMessage);
        return null;
      } catch (e) {
        // if (enableLoading) loaderDismiss();
        String errorMessage = e.toString();
        debugPrint(errorMessage);
        print('errorMessage :$errorMessage');
             errorSnack(errorMessage);
        return null;
      }
      final Map<String, dynamic> mapdata = response.data;
      if (response.statusCode == 200) {
        return response;
      }
      else {
        //Error Response (error provided by REST API)
        if (errorMessage != null) {
          //Showing errror provided by error message
          errorSnack(errorMessage);
        } else {
          //errorSnack(mapdata['response']['message']);
        }
        return null;
      }
    } else {

      // alertSnack('Sorry, You are not connected with mobile/wifi network');
    }
    return null;
  }


}