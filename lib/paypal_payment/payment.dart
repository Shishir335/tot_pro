import 'dart:core';
import 'package:flutter/material.dart';
import 'package:tot_pro/paypal_payment/payment_services.dart';
import 'package:tot_pro/paypal_payment/paypal_webview.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../models/invoicemodel.dart';


class Payment extends StatefulWidget {
  final Function onFinish;
  final InvoiceModel? model;

  const Payment({super.key, required this.onFinish,this.model});

  @override
  State<StatefulWidget> createState() {
    return PaymentState();
  }
}

class PaymentState extends State<Payment> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String? checkoutUrl;
  String? executeUrl;
  String? accessToken;
  PaypalServices services = PaypalServices();


// you can change default currency according to your need
  Map<dynamic, dynamic> defaultCurrency = {
    "symbol": "USD ",
    "decimalDigits": 2,
    "symbolBeforeTheNumber": true,
    "currency": "USD"
  };

  bool isEnableShipping = false;
  bool isEnableAddress = false;

  String returnURL = 'return.example.com';
  String cancelURL = 'cancel.example.com';
  late final WebViewController _controller;
  @override
  void initState() {
    super.initState();

    print('PaymentState.initState Model ${widget.model!.toJson()}');
    Future.delayed(
      Duration.zero,
          () async {
        try {
          accessToken = await services.getAccessToken();
          print('accessToken :: $accessToken');

          final transactions = getOrderParams(widget.model??InvoiceModel());
          print('transactions :$transactions');
          final res = await services.createPaypalPayment(transactions, accessToken);

          if (res != null) {
            setState(() {
              checkoutUrl = res["approvalUrl"];
              print('checkoutUrl $checkoutUrl ');
              executeUrl = res["executeUrl"];
            });
          }
        } catch (e) {
          print('exception: $e');
          final snackBar = SnackBar(
            content: Text(e.toString()),
            duration: const Duration(seconds: 10),
            action: SnackBarAction(
              label: 'Close',
              onPressed: () {
// Some code to undo the change.
              },
            ),
          );
// _scaffoldKey.currentState.showSnackBar(snackBar);
        }
      },
    );
  }


  Map<String, dynamic> getOrderParams(InvoiceModel model) {
    print('PaymentState.getOrderParams >>> ${model.amount}');
    print('PaymentState.getOrderParams  id>>> ${model.id}');
    Map<String,dynamic> temp={
      "intent": "sale",
      "payer": {
        "payment_method": "paypal"
      },
      "transactions": [
        {
          "amount": {
            "total": "30.11",
            "currency": "USD",
            "details": {
              "subtotal": "30.00",
              "tax": "0.07",
              "shipping": "0.03",
              "handling_fee": "1.00",
              "shipping_discount": "-1.00",
              "insurance": "0.01"
            }
          },
          "description": "The payment transaction description.",
          "custom": "EBAY_EMS_90048630024435",
          "invoice_number": "48787589673",
          "payment_options": {
            "allowed_payment_method": "INSTANT_FUNDING_SOURCE"
          },
          "soft_descriptor": "ECHI5786786",
          "item_list": {
            "items": [
              {
                "name": "hat",
                "description": "Brown hat.",
                "quantity": "5",
                "price": "3",
                "tax": "0.01",
                "sku": "1",
                "currency": "USD"
              },
              {
                "name": "handbag",
                "description": "Black handbag.",
                "quantity": "1",
                "price": "15",
                "tax": "0.02",
                "sku": "product34",
                "currency": "USD"
              }
            ],
            "shipping_address": {
              "recipient_name": "Brian Robinson",
              "line1": "4th Floor",
              "line2": "Unit #34",
              "city": "San Jose",
              "country_code": "US",
              "postal_code": "95131",
              "phone": "011862212345678",
              "state": "CA"
            }
          }
        }
      ],
      "note_to_payer": "Contact us for any questions on your order.",
      "redirect_urls": {
        "return_url": "https://example.com/return",
        "cancel_url": "https://example.com/cancel"
      }
    };
    return temp;
  }


  @override
  Widget build(BuildContext context) {
    print('PaymentState.build amount :: ${widget.model!.amount??0}');
    print('PaymentState.build amount :: ${widget.model!.toJson()}');
    print(checkoutUrl);

    if (checkoutUrl != null) {
      return Scaffold(
          appBar: AppBar(
            // backgroundColor: Theme.of(context).backgroundColor,
            leading: GestureDetector(
              child: const Icon(Icons.arrow_back_ios),
              onTap: () => Navigator.pop(context),
            ),
          ),
          body:
          PaypalWebView(
            url: checkoutUrl,

/* onFinish: (number) async {
// payment done
final snackBar = SnackBar(
content: const Text("Payment done Successfully"),
duration: const Duration(seconds: 5),
action: SnackBarAction(
label: 'Close',
onPressed: () {
// Some code to undo the change.
},
),
);
// _scaffoldKey.currentState!.showSnackBar(snackBar);
},*/
          )

/* WebView(
initialUrl: checkoutUrl,
javascriptMode: JavascriptMode.unrestricted,
navigationDelegate: (NavigationRequest request) {
if (request.url.contains(returnURL)) {
final uri = Uri.parse(request.url);
final payerID = uri.queryParameters['PayerID'];
if (payerID != null) {
services
.executePayment(executeUrl, payerID, accessToken)
.then((id) {
widget.onFinish(id);
Navigator.of(context).pop();
});
} else {
Navigator.of(context).pop();
}
Navigator.of(context).pop();
}
if (request.url.contains(cancelURL)) {
Navigator.of(context).pop();
}
return NavigationDecision.navigate;
},
),*/
      );
    } else {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          backgroundColor: Colors.black12,
          elevation: 0.0,
        ),
        body: Center(child: Container(child: const CircularProgressIndicator())),
      );
    }
  }
}