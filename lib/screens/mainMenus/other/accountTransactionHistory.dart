import 'package:flutter/material.dart';
import 'package:oasis_cafe_app/provider/transactionHistoryProvider.dart';
import 'package:provider/provider.dart';

import '../../../config/palette.dart';
import '../../../strings/strings_ko.dart';

class AccountTransactionHistory extends StatefulWidget {
  const AccountTransactionHistory({Key? key}) : super(key: key);

  @override
  State<AccountTransactionHistory> createState() => _AccountTransactionHistoryState();
}

class _AccountTransactionHistoryState extends State<AccountTransactionHistory> {

  late DateTime now;
  late DateTime aMonthAgo;
  late int yearOfAMonthAgo, monthOfAMonthAgo, dayOfAMonthAgo;
  late int year, month, day;

  @override
  void initState() {
    super.initState();

    now = DateTime.now();
    // 한 달 전
    aMonthAgo = now.subtract(const Duration(days: 29));
    yearOfAMonthAgo = aMonthAgo.year;
    monthOfAMonthAgo = aMonthAgo.month;
    dayOfAMonthAgo = aMonthAgo.day;
    // 현재
    year = now.year;
    month = now.month;
    day = now.day + 1;

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
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.transactionHistory),
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Theme(
              data: ThemeData(
                dividerColor: Colors.transparent,
              ),

              child: ExpansionTile(
                // 화면 로딩 시 기본 1개월 내역 보여주기
                title: Container(
                  alignment: Alignment.center,
                  child: Text(
                    '$yearOfAMonthAgo.$monthOfAMonthAgo.$dayOfAMonthAgo - '
                        '$year.$month.$day',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15.0
                    ),
                  ),
                ),

                // 상세 조회
                trailing: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.brown, width: 1),
                    borderRadius: BorderRadius.circular(30)
                  ),

                  child: const Text(
                    '상세 조회',
                    style: TextStyle(
                      color: Colors.brown
                    ),
                  ),
                ),

                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      // 조회 시작 날짜
                      searchDate(true),

                      const Text(' ~ '),

                      // 조회 끝 날짜
                      searchDate(false),
                    ],
                  ),

                  // 조회 버튼
                  SearchButton(yearOfAMonthAgo: yearOfAMonthAgo, monthOfAMonthAgo: monthOfAMonthAgo,
                      dayOfAMonthAgo: dayOfAMonthAgo, year: year, month: month, day: day)
                ],
              ),
            ),
          ),

          const Divider(thickness: 1, color: Colors.brown,),

          const TransactionHistoryList()
        ],
      ),
    );
  }


  // 조회 날짜
  Widget searchDate(bool isStartDate) {
    return Row(
      children: [
        Text(
          isStartDate ?
          '$yearOfAMonthAgo.$monthOfAMonthAgo.$dayOfAMonthAgo' :
          '$year.$month.$day',
          style: const TextStyle(
          ),
        ),

        const SizedBox(width: 5,),

        GestureDetector(
          onTap: () async {
            final selectedDate = await showDatePicker(
              context: context,
              initialDate: now,
              firstDate: DateTime(2018),
              lastDate: now,
              initialEntryMode: DatePickerEntryMode.calendarOnly,
              builder: (context, child) {
                return Theme(
                  data: ThemeData(
                    appBarTheme: const AppBarTheme(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.amber,
                    ),
                  ),
                  child: child!
                );
              }
            );

            if( selectedDate != null ) {
              setState(() {
                if( isStartDate ) {
                  yearOfAMonthAgo = selectedDate.year;
                  monthOfAMonthAgo = selectedDate.month;
                  dayOfAMonthAgo = selectedDate.day;

                } else {
                  year = selectedDate.year;
                  month = selectedDate.month;
                  day = selectedDate.day;
                }

              });
            }
          },

          child: const Icon(
            Icons.calendar_month_outlined,
            color: Colors.brown,
          ),
        )
      ],
    );
  }
}

// 조회 버튼
class SearchButton extends StatelessWidget {
  const SearchButton({required this.yearOfAMonthAgo, required this.monthOfAMonthAgo,
    required this.dayOfAMonthAgo, required this.year, required this.month, required this.day,Key? key}) : super(key: key);

  final int yearOfAMonthAgo, monthOfAMonthAgo, dayOfAMonthAgo;
  final int year, month, day;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: (){
          final transactionHistoryProvider = Provider.of<TransactionHistoryProvider>(context, listen: false);

          transactionHistoryProvider.fromSelectedYear = yearOfAMonthAgo;
          transactionHistoryProvider.fromSelectedMonth = monthOfAMonthAgo;
          transactionHistoryProvider.fromSelectedDay = dayOfAMonthAgo;
          transactionHistoryProvider.toSelectedYear = year;
          transactionHistoryProvider.toSelectedMonth = month;
          transactionHistoryProvider.toSelectedDay = day;
          // 내역 reset
          transactionHistoryProvider.reversedHistoryList.clear();
        },

        style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: Palette.buttonColor1,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
            ),
            side: const BorderSide(color: Palette.buttonColor1,)
        ),

        child: const Text('조회'),
      ),
    );
  }
}


// 거래 내역 리스트
class TransactionHistoryList extends StatelessWidget {
  const TransactionHistoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final transactionHistoryProvider = Provider.of<TransactionHistoryProvider>(context);

    return FutureBuilder(
      future: transactionHistoryProvider.getTransactionHistory(),
      builder: (context, snapshot) {
        if( transactionHistoryProvider.reversedHistoryList.isEmpty ) {
          return const Text('거래 내역이 없습니다.');
          // return const Center(child: CircularProgressIndicator(),);
        } else {

          return Expanded(
            child: ListView.separated(
              // list 위젯의 높이를 유연하게 조절하기 위한 shrinkWrap
              // shrinkWrap: true,
              // -> shrinkWrap 은 내부 컨텐츠의 높이를 미리 설정하기 때문에 오버플로우가 발생할 수 있다.
              // -> 화면 첫 로딩 후 가져온 데이터의 목록이 짧고, 그 후 데이터 조회를 했을 때 조회 내역이 길게 되면
              // 오버플로우가 생겼다. 따라서 Expanded 로 감싸주었다.
              separatorBuilder: (BuildContext context, int index) =>
              const Divider(
                color: Colors.grey,
              ),

              itemCount: transactionHistoryProvider.reversedHistoryList.length,
              itemBuilder: (context, index) {
                String price = transactionHistoryProvider.reversedHistoryList[index].itemPrice;
                String itemName = transactionHistoryProvider.reversedHistoryList[index].itemName;
                String time = transactionHistoryProvider.reversedHistoryList[index].orderTime;

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
            ),
          );
        }
      }
    );
  }
}

