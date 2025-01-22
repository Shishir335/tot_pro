import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_auth/http_auth.dart';

class PaypalServices {
  /// sandbox
  String domain1 = "https://api.sandbox.paypal.com";

  /// production live
String domain = "https://api.paypal.com"; /// for production mode

  /// Change the clientId and secret given by PayPal to your own.

  /* My TESTING PURPOSE */
  String clientId1 = 'AcMmc0rQYPmUPzN0IMUXIY2KbQ3L_73cbceWZB4PKcaNsve_lbibDslV_WDXBx2uilQyhAu7SoPEaCuB';
  static String secret1 = 'EHUj_8TatcivRL6KpM7eNYASbYDRUuXbAx8k59hnX3OkyO4-Lvrs6G-S1HY5d74zQHPEuvc9PcEtlX0R';

  /* Shakil Information */
  static String clientId2 = 'AZi6CBWpD2mlBOgEnuCuF9_SIRPCMdwbpR_SVdk7DEp8gVxdRN0H2WQy-WEFK2zPOYg57MW5XMOVMkFU';
  static String secret2 = 'EKUKk1Siztl1ghhExc1gWnLYtMHJE9od8kJClhL6vz4HFC_8Ay46w51SX-UBb_FsCj1a4A8KYDktcGK0';

  /* Shakil Information live  */
  static String clientId = 'BAAQxRnB_LgRdaHmf9XqEJ7_Ua7_BWL7lPHtL7xxod3caksY2CndRaIl7wnHvHTGz3-LwYQnm6S1UWnN3o';
  static String secret = 'EJ4BOYaIBJLPd74wn65lkKpWkQPQNk08PBpDAkhD8hChUSaWbyFa5qs3WxX-2oqFpA_jEaQrrNneBwdB';


  /// for obtaining the access token from Paypal
  Future<String?> getAccessToken() async {
    try {
      var client = BasicAuthClient(clientId, secret);
      var response = await client.post(
          Uri.parse('$domain/v1/oauth2/token?grant_type=client_credentials'));
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        return body["access_token"];
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

// for generating the PayPal payment request
  Future<Map<String, String>?> createPaypalPayment(
      transactions, accessToken) async {
    try {
      var response = await http.post(Uri.parse("$domain/v1/payments/payment"),
          body: jsonEncode(transactions),
          headers: {
            "content-type": "application/json",
            "Authorization": 'Bearer ' + accessToken
          });

      final body = jsonDecode(response.body);
      print('payment API res code :: ${response.statusCode.toString()}');
      print('payment API res code :: ${response.body.toString()}');
      if (response.statusCode == 201) {
        if (body["links"] != null && body["links"].length > 0) {
          List links = body["links"];

          String executeUrl = "";
          String approvalUrl = "";
          final item = links.firstWhere((o) => o["rel"] == "approval_url",
              orElse: () => null);
          if (item != null) {
            approvalUrl = item["href"];
          }
          final item1 = links.firstWhere((o) => o["rel"] == "execute",
              orElse: () => null);
          if (item1 != null) {
            executeUrl = item1["href"];
          }
          return {"executeUrl": executeUrl, "approvalUrl": approvalUrl};
        }
        return null;
      } else {
        print('PaypalServices.createPaypalPayment Else ');
        throw Exception(body["message"]);
      }
    } catch (e) {
      rethrow;
    }
  }

  /// for carrying out the payment process
  Future<String?> executePayment(url, payerId, accessToken) async {
    try {
      var response = await http.post(url,
          body: jsonEncode({"payer_id": payerId}),
          headers: {
            "content-type": "application/json",
            "Authorization": 'Bearer ' + accessToken
          });

      final body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return body["id"];
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }
}







