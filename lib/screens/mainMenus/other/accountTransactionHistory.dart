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
    print('before29days >> ${before29days}');
    print('lastMonth >> ${getLastDay.month}');
    print('lastDay >> ${lastDay}');
    print('nowMonth >> ${month}');

    for(var day = before29days.day; day <= lastDay; day++ ) {
      print('day >> $day');
    }

    for(var currentDay = 1; currentDay <= day; currentDay++ ) {
      print('currentDay >> $currentDay');
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction History'),
      ),

      // body: Text('${transactionHistoryProvider.getOrderHistory(userUid, year, month, day)}'),
    );
  }
}
