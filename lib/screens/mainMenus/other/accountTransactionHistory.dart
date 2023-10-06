import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:oasis_cafe_app/provider/transactionHistoryProvider.dart';
import 'package:provider/provider.dart';

class AccountTransactionHistory extends StatelessWidget {
  const AccountTransactionHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    final userUid = user!.uid;
    final transactionHistoryProvider = Provider.of<TransactionHistoryProvider>(context);

    var now = DateTime.now();
    var year = now.year;
    var month = now.month;
    var day = now.day;

    var newDateTime = DateTime(year, month, day);
    // 29일 전
    var before29days = newDateTime.subtract(Duration(days: 29));
    var getLastDay = DateTime(year, month, 0);
    var lastDay = getLastDay.day;
    // print('before29days >> ${before29days}');
    // print('lastMonth >> ${getLastDay.month}');
    // print('lastDay >> ${lastDay}');
    // print('nowMonth >> ${month}');

    List<int> days = [];

    for(var day = before29days.day; day <= lastDay; day++ ) {
      // print('day >> $day');
      // transactionHistoryProvider.getOrderHistory(userUid, year.toString(), getLastDay.month.toString(), day.toString());

    }

    for(var currentDay = 1; currentDay <= day; currentDay++ ) {
      // print('currentDay >> $currentDay');
      // transactionHistoryProvider.getOrderHistory(userUid, year.toString(), month.toString(), currentDay.toString());
      days.add(currentDay);
    }
    // transactionHistoryProvider.getOrderHistory(userUid, year.toString(), month.toString(), '5');


    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction History'),
      ),

      body: Column(
        children: [
          Text('ddddd'),
          Divider(height: 10, thickness: 1, color: Colors.grey,),
          FutureBuilder(
            future: transactionHistoryProvider.getOrderHistory(userUid, year.toString(), month.toString(), '5'),
            builder: (context, snapshot) {

              if( transactionHistoryProvider.historyList.isEmpty ) {
                return Text('is empty');

              } else {
                return ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (BuildContext context, int index) => Divider(
                    color: Colors.grey,
                  ),

                  itemCount: transactionHistoryProvider.historyList.length,
                  itemBuilder: (context, index) {
                    String price = transactionHistoryProvider.historyList[index].itemPrice;
                    String itemName = transactionHistoryProvider.historyList[index].itemName;
                    String time = transactionHistoryProvider.historyList[index].id;

                    return Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 0),
                      child: ListTile(

                        // 결제 수단
                        leading: Icon(Icons.credit_card),

                        // 가격
                        title: Text('NZD $price'),

                        // 결제한 아이템 이름
                        subtitle: Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text(itemName)
                        ),

                        // 결제 시간
                        trailing: Text(time),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
