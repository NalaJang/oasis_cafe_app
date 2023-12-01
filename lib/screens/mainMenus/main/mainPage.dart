import 'package:flutter/material.dart';
import 'package:oasis_cafe_app/provider/orderStateProvider.dart';
import 'package:oasis_cafe_app/provider/userStateProvider.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // 'Hello'
              Container(
                padding: const EdgeInsets.only(top: 70),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Hello',
                      style: TextStyle(
                          fontSize: 35
                      ),
                    ),

                    SizedBox(width: 5,),

                    Icon(
                      Icons.coffee,
                      size: 40,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30,),

              const OrderStatus(),

              const SizedBox(height: 30,),

              // 소식(What's New)
              Row(
                children: const [
                  Icon(
                    Icons.mail_outline_sharp,
                    size: 20,
                  ),

                  SizedBox(width: 5,),

                  Text(
                    "What's New",
                    style: TextStyle(
                      fontSize: 15
                    ),
                  )
                ],
              ),

              const SizedBox(height: 10,),

              Column(
                children: [
                  Image.asset(
                      'image/IMG_banner1.PNG'
                  ),

                  SizedBox(height: 10,),

                  Image.asset(
                      'image/IMG_banner2.PNG'
                  ),
                ],
              ),

              SizedBox(height: 30,),

              // 디저트(하루가 달콤해지는 시간)
              Row(
                children: [
                  Text(
                    '하루가 달콤해지는 시간',
                    style: TextStyle(
                      fontSize: 25
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10,),

              Container(
                height: 150,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Image.asset('image/IMG_dessert1.PNG'),
                    SizedBox(width: 10,),
                    Image.asset('image/IMG_dessert2.PNG'),
                    SizedBox(width: 10,),
                    Image.asset('image/IMG_dessert1.PNG'),
                    SizedBox(width: 10,),
                    Image.asset('image/IMG_dessert2.PNG'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class OrderStatus extends StatefulWidget {
  const OrderStatus({Key? key}) : super(key: key);

  @override
  State<OrderStatus> createState() => _OrderStatusState();
}

class _OrderStatusState extends State<OrderStatus> {

  @override
  Widget build(BuildContext context) {
    var orderStateProvider = Provider.of<OrderStateProvider>(context);
    String userName = Provider.of<UserStateProvider>(context).userName;


    /*
    .where('processState', isNotEqualTo: 'done') ==> isEqualTo -> isNotEqualTo 로 변경하자 발생한 에러.
    .orderBy('orderTime', descending: false)

    The initial orderBy() field "[[FieldPath([orderTime]), false]][0][0]" has to be the same
    as the where() field parameter "FieldPath([processState])"
    when an inequality operator is invoked.

    .orderBy('processState') 를 추가해주었다.
    */
    return StreamBuilder(
      stream: orderStateProvider.orderStateCollection
                                .where('processState', isNotEqualTo: 'done')
                                .orderBy('processState')
                                .orderBy('orderTime', descending: false)
                                .snapshots(),

      builder: (context, snapshot) {
        if( snapshot.hasData ) {
          if( snapshot.data!.size == 0 ) {
            return noOrder();

          } else {
            var document = snapshot.data!.docs[0];
            var documentId = document.id;
            var processState = document['processState'];
            String cardTitlePhrase = '';
            String cardSubTitlePhrase = '';
            String graphImage = '';

            if( processState == 'new' ) {
              cardTitlePhrase = '주문을 확인하고 있습니다. 🏃🏻‍♀️';
              cardSubTitlePhrase = '주문 상황에 따라 준비가 늦어질 수 있습니다. 본인이 직접 메뉴를 수령해 주세요.';
              graphImage = 'image/IMG_order_status_new.png';

            } else if( processState == 'inProcess' ) {
              cardTitlePhrase = '$userName 님의 주문을 1번째 메뉴로 준비 중입니다.';
              cardSubTitlePhrase = '주문 승인 즉시 메뉴 준비가 시작됩니다. 완성 후, 빠르게 픽업해 주세요.';
              graphImage = 'image/IMG_order_status_inProcess.png';

            } else if( processState == 'done' ) {
              cardTitlePhrase = '$userName 님, 메뉴가 모두 준비되었어요.';
              cardSubTitlePhrase = '메뉴가 모두 준비되었어요. 픽업대에서 메뉴를 픽업해주세요!';
              graphImage = 'image/IMG_order_status_done.png';
            }

            // 카드 이미지
            return orderProcessStateCard(cardTitlePhrase, cardSubTitlePhrase, graphImage);
          }

        }
        return const CircularProgressIndicator();
      }
    );
  }

  Widget noOrder() {
    return const Text(
      "It's a great day for coffee ☕️",
      style: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold
      ),
    );
  }

  // 카드 이미지
  Widget orderProcessStateCard(String cardTitlePhrase, String cardSubTitlePhrase, String graphImage) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 1,
                // spreadRadius: 2
            )
          ]
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 주문 상태 메인 문구
          Text(
            cardTitlePhrase,
            style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold
            ),
          ),

          const SizedBox(height: 15.0,),
          // 주문 상태 설명 문구
          Text(
            cardSubTitlePhrase,
            style: const TextStyle(
              fontSize: 15.0,
              color: Colors.black54
            ),
          ),

          const SizedBox(height: 25,),

          // 주문 상태 그래프 이미지
          Image.asset(graphImage),

          const SizedBox(height: 15,),
          const Text('주문내역 확인하기')
        ],
      ),
    );
  }
}

