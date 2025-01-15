import 'package:flutter/material.dart';
import 'package:get/get.dart';
export 'package:get/get.dart';
import '../../../../models/transactionmodel.dart';
import '../controllers/transaction_controller.dart';

class TransactionView extends GetView<TransactionController> {
  const TransactionView({super.key});
  @override
  Widget build(BuildContext context) {
    print('TransactionView.build >>>');
    List<TransactionModel> transactions = Get.arguments[0];
    String jobId = Get.arguments[1];
    print('tns lng :: ${transactions.length}');
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          'Transaction',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          width: double.maxFinite,
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: transactions.isEmpty
                ? Center(child: Image.asset("assets/images/nodatafound.png"))
                : ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      //OrderRecordModel model = controller.orderHistoryDataList[index];
                      return Container();
                    },
                    itemCount: transactions.length,
                    itemBuilder: (context, index) {
                      TransactionModel model = transactions[index];
                      return paymentCardUI(model, jobId);
                    },
                  ),
          ),
        ),
      ),
    );
  }

  paymentCardUI(TransactionModel model, jobId) {
    return Card(
      elevation: 0.0,
      color: Colors.white,
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: ListTile(
            leading: const Icon(Icons.payments_outlined),
            title: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'JobId : $jobId',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'TID : ${model.tranid}',
                ),
              ],
            ),
            subtitle: Text(model.date.toString().substring(0, 11)),
            trailing: Text(
              model.amount.toString(),
              style: const TextStyle(fontSize: 16),
            ),
          )),
    );
  }
/*

  /// Job remove Alert
  openDialog(int id) {
    Get.dialog(
      AlertDialog(
        icon: Icon(Icons.delete_forever),
        title:

        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Are Yor Sure?',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
            AppSpace.spaceH6,
            Text('Do you want to remove job?',style: TextStyle(fontSize: 14),),
            AppSpace.spaceH20,

          ],
        ),

        actions: [
          Row(
            children: [

              Expanded(
                  child:
                  InkWell(
                    onTap: (){
                      Get.back();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      // width: double.maxFinite,
                      height: 50,
                      margin: EdgeInsets.all(2),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text('Cancel',style: TextStyle(color: Colors.white),),
                    ),
                  )
              ),
              Expanded(
                  child:
                  InkWell(
                    onTap: ()async{
                      Get.back();
                      controller.getJobHistoryDeleteCTR(id);


                    },
                    child: Container(
                      alignment: Alignment.center,
                      // width: double.maxFinite,
                      height: 50,
                      margin: EdgeInsets.all(2),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text('Ok',style: TextStyle(color: Colors.white),),
                    ),
                  )
              ),
            ],
          )
        ],
      ),
    );
  }
*/
}
