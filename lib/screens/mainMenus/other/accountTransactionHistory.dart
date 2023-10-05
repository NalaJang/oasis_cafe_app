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

      body: FutureBuilder(
        future: transactionHistoryProvider.getOrderHistory(userUid, year.toString(), month.toString(), day.toString()),
        builder: (context, snapshot) {
          return ListView.separated(
            separatorBuilder: (BuildContext context, int index) => Divider(
              color: Colors.grey,
            ),

            itemCount: transactionHistoryProvider.historyList.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(Icons.credit_card),
                title: Text('NZD ${transactionHistoryProvider.historyList[index].itemPrice}'),
                subtitle: Text('${transactionHistoryProvider.historyList[index].itemName}'),
                trailing: Text('${transactionHistoryProvider.historyList[index].id}'),
              );
            },
          );
        },
      ),
    );
  }
}
