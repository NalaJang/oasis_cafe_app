import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../config/circularProgressBar.dart';
import '../../../../config/palette.dart';
import '../../../../localNotification.dart';
import '../../../../provider/orderStateProvider.dart';
import '../../../../provider/userStateProvider.dart';
import 'orderProcessStateCard.dart';

class OrderStatus extends StatefulWidget {
  const OrderStatus({Key? key}) : super(key: key);

  @override
  State<OrderStatus> createState() => _OrderStatusState();
}

class _OrderStatusState extends State<OrderStatus> {


  @override
  void initState() {
    super.initState();

    var userStateProvider = Provider.of<UserStateProvider>(context, listen: false);
    // 자동 로그인
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      userStateProvider.getStorageInfo();
    });

  }


  @override
  Widget build(BuildContext context) {

    var userStateProvider = Provider.of<UserStateProvider>(context);

    // 로그인 상태인지 확인
    if( userStateProvider.userUid == '' ) {
      return noOrder();

    } else {

      var orderStateProvider = Provider.of<OrderStateProvider>(context);
      String userName = userStateProvider.userName;

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
              .where('processState', isNotEqualTo: 'pickedUp')
              .orderBy('processState')
              .orderBy('orderTime', descending: false)
              .snapshots(),

          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.size == 0) {
                return noOrder();

              } else {
                bool orderCanceled = false;
                var document = snapshot.data!.docs[0]; // [0] 제일 먼저 주문한 메뉴를 가지고 온다.
                var documentId = document.id;
                var processState = document['processState'];
                var splitProcessState = processState.toString().split(':');
                if( splitProcessState[0] != null ) {
                  processState = splitProcessState[0];
                }
                String cardTitlePhrase = '';
                String cardSubTitlePhrase = '';
                String graphImage = '';

                if (processState == 'new') {
                  cardTitlePhrase = '주문을 확인하고 있습니다. 🏃🏻‍♀️';
                  cardSubTitlePhrase =
                  '주문 상황에 따라 준비가 늦어질 수 있습니다. 본인이 직접 메뉴를 수령해 주세요.';
                  graphImage = 'image/IMG_order_status_new.png';

                } else if (processState == 'inProcess') {
                  cardTitlePhrase = '$userName 님의 주문을 준비 중입니다.';
                  cardSubTitlePhrase = '주문 승인 즉시 메뉴 준비가 시작됩니다. 완성 후, 빠르게 픽업해 주세요.';
                  graphImage = 'image/IMG_order_status_inProcess.png';

                } else if (processState == 'done') {
                  cardTitlePhrase = '$userName 님, 메뉴가 모두 준비되었어요.';
                  cardSubTitlePhrase = '메뉴가 모두 준비되었어요. 픽업대에서 메뉴를 픽업해주세요!';
                  graphImage = 'image/IMG_order_status_done.png';

                } else if( processState == 'canceled' ) {
                  orderCanceled = true;
                  var reasonOfCancel = splitProcessState[1];
                  cardTitlePhrase = '$userName 님, 주문이 취소되었어요.';
                  cardSubTitlePhrase = '$reasonOfCancel (으)로 주문이 취소되었습니다.';
                  graphImage = '';
                }


                if( userName != '' ) {
                  // 푸시 알림으로 메뉴 준비 상태 알리기
                  LocalNotification().showNotification(processState);

                  // 카드 이미지
                } else {
                  userStateProvider.getStorageInfo();
                  return CircularProgressBar.circularProgressBar;
                }
              }
            }
            return CircularProgressBar.circularProgressBar;
          }
      );
    }
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
}