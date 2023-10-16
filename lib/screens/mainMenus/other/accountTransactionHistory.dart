import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:oasis_cafe_app/provider/transactionHistoryProvider.dart';
import 'package:provider/provider.dart';

import '../../../strings/strings_en.dart';

class AccountTransactionHistory extends StatefulWidget {
  const AccountTransactionHistory({Key? key}) : super(key: key);

  @override
  State<AccountTransactionHistory> createState() => _AccountTransactionHistoryState();
}

class _AccountTransactionHistoryState extends State<AccountTransactionHistory> {

  late DateTime now;
  late int year, month, day;
  late DateTime aMonthAgo;
  late int yearOfAMonthAgo, monthOfAMonthAgo, dayOfAMonthAgo;

  @override
  void initState() {
    super.initState();

    now = DateTime.now();
    // 한 달 전
    aMonthAgo = now.subtract(Duration(days: 29));
    yearOfAMonthAgo = aMonthAgo.year;
    monthOfAMonthAgo = aMonthAgo.month;
    dayOfAMonthAgo = aMonthAgo.day;
    // 현재
    year = now.year;
    month = now.month;
    day = now.day;

    final transactionHistoryProvider = Provider.of<TransactionHistoryProvider>(context, listen: false);

    transactionHistoryProvider.fromSelectedYear = yearOfAMonthAgo;
    transactionHistoryProvider.fromSelectedMonth = monthOfAMonthAgo;
    transactionHistoryProvider.fromSelectedDay = dayOfAMonthAgo;
    transactionHistoryProvider.toSelectedYear = year;
    transactionHistoryProvider.toSelectedMonth = month;
    transactionHistoryProvider.toSelectedDay = day;
  }
  @override
  Widget build(BuildContext context) {

    final transactionHistoryProvider = Provider.of<TransactionHistoryProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.transactionHistory),
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // 화면 로딩 시 기본 1개월 내역 보여주기
                Text(
                  '$yearOfAMonthAgo.$monthOfAMonthAgo.$dayOfAMonthAgo - '
                      '$year.$month.$day',
                  style: const TextStyle(
                    fontSize: 15.0
                  ),
                ),

                // 상세 조회
                ElevatedButton(
                  onPressed: (){
                    transactionHistoryProvider.fromSelectedYear = yearOfAMonthAgo;
                    transactionHistoryProvider.fromSelectedMonth = monthOfAMonthAgo;
                    transactionHistoryProvider.fromSelectedDay = dayOfAMonthAgo;
                    transactionHistoryProvider.toSelectedYear = year;
                    transactionHistoryProvider.toSelectedMonth = month;
                    transactionHistoryProvider.toSelectedDay = day;

                    transactionHistoryProvider.getTransactionHistory();
                  },

                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)
                      ),
                      side: BorderSide(
                        color: Colors.brown,
                      )
                  ),

                  child: Text(
                    '상세 조회',
                    style: TextStyle(
                      color: Colors.brown
                    ),
                  )
                )
              ],
            ),
          ),

          const Divider(thickness: 1, color: Colors.brown,),

          TransactionHistoryList()
        ],
      ),
    );
  }
}

class TransactionHistoryList extends StatelessWidget {
  const TransactionHistoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final transactionHistoryProvider = Provider.of<TransactionHistoryProvider>(context);

    return FutureBuilder(
      future: transactionHistoryProvider.getTransactionHistory(),
      builder: (context, snapshot) {
        if (transactionHistoryProvider.historyList.isEmpty) {
          return const Center(child: CircularProgressIndicator(),);
        } else {

          return ListView.separated(
            // list 위젯의 높이를 유연하게 조절하기 위한 shrinkWrap
            shrinkWrap: true,
            separatorBuilder: (BuildContext context, int index) =>
            const Divider(
              color: Colors.grey,
            ),

            itemCount: transactionHistoryProvider.historyList.length,
            itemBuilder: (context, index) {
              String price = transactionHistoryProvider.historyList[index].itemPrice;
              String itemName = transactionHistoryProvider.historyList[index].itemName;
              String time = transactionHistoryProvider.historyList[index].orderTime;

              return Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 5, bottom: 0
                ),
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
      }
    );
  }
}

