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
  @override
  Widget build(BuildContext context) {

    final auth = FirebaseAuth.instance;
    final userUid = auth.currentUser!.uid;
    final transactionHistoryProvider = Provider.of<TransactionHistoryProvider>(context);

    var now = DateTime.now();
    var year = now.year;
    var month = now.month;
    var day = now.day;

    var newDateTime = DateTime(year, month, day);
    // 29일 전
    var before29days = newDateTime.subtract(Duration(days: 29));
    var getLastDay = DateTime(year, before29days.month +1, 0).day;
    print('before29days.month >> ${before29days.month}');
    print('before29days.day >> ${before29days.day}');
    // print('lastMonth >> ${getLastDay.month}');
    print('lastDay >> ${getLastDay}');
    // print('now.day = ${day}');
    // print('day - 1 = ${day - 14}');
    // print('nowMonth >> ${month}');


    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.transactionHistory),
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Theme(
              data: ThemeData(
                dividerColor: Colors.transparent
              ),

              child: ExpansionTile(
                // 조회된 날짜
                title: Container(
                  alignment: Alignment.center,
                  child: Text(
                    '2022.10.07 - 2023.10.06',
                    style: TextStyle(
                      color: Colors.black
                    ),
                  ),
                ),

                // 상세 조회 버튼
                trailing: const Text(
                  '상세 조회',
                  style: TextStyle(
                    color: Colors.black
                  ),
                ),

                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(width: 5,),
                      Expanded(
                        child: GestureDetector(
                          onTap: (){
                            transactionHistoryProvider.getOrderHistoryForOneMonth(before29days.month, before29days.day, getLastDay, month, day);

                          },
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1),
                            ),
                            child: const Text(
                              '1개월',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: 5,),

                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                          ),
                          child: const Text(
                            '1년',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),

                      SizedBox(width: 5,),

                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                          ),
                          child: const Text(
                            '기간 설정',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(width: 5,),
                    ],
                  ),

                  ElevatedButton(
                    onPressed: (){},
                    child: Text('조회')
                  )
                ],
              ),
            ),
          ),

          const Divider(thickness: 1, color: Colors.brown,),

          // 1개월 전 ~ 오늘 데이터를 리스트에 담아준다.
          // 예) 9월 12일, 13일 ... 지난 달의 마지막 날까지 day++
          // 10월 1일, 2일 ... 이번 달 첫 날부터 오늘 날짜까지 day++
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
    var now = DateTime.now();
    var year = now.year.toString();
    var month = now.month.toString();
    var day = now.day.toString();

    return FutureBuilder(
      // todo: 1개월 버튼 클릭 시 bool 값을 불러와서 결과에 따라 future 값 변경?
      future: transactionHistoryProvider.getTodayHistory(year, month, day),
      builder: (context, snapshot) {

        if( snapshot.hasData ) {
          return ListView.separated(
            // todo: shrinkWrap -> slivers 로 변경?
            shrinkWrap: true,
            separatorBuilder: (BuildContext context, int index) => const Divider(
              color: Colors.grey,
            ),

            itemCount: transactionHistoryProvider.historyList.length,
            itemBuilder: (context, index) {
              String price = transactionHistoryProvider.historyList[index].itemPrice;
              String itemName = transactionHistoryProvider.historyList[index].itemName;
              String time = transactionHistoryProvider.historyList[index].orderTime;

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
        return Center(child: CircularProgressIndicator(),);
      },
    );
  }
}

