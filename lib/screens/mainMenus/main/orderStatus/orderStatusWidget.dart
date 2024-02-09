import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../config/circularProgressBar.dart';
import '../../../../provider/orderStateProvider.dart';
import '../../../../provider/userStateProvider.dart';
import 'orderProcessStateCard.dart';

class OrderStatus extends StatefulWidget {
  const OrderStatus({Key? key}) : super(key: key);

  @override
  State<OrderStatus> createState() => _OrderStatusState();
}

class _OrderStatusState extends State<OrderStatus> {

  late OrderStatusInfo orderStatusInfo;

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
    String userName = userStateProvider.userName;

    // 로그인 상태인지 확인
    if( userStateProvider.userUid == '' ) {
      return noOrder();

    } else {

      if( userName == '' ) {
        userStateProvider.getStorageInfo();
        return CircularProgressBar.circularProgressBar;
      }

      var orderStateProvider = Provider.of<OrderStateProvider>(context);

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
              var document = snapshot.data!.docs[0]; // [0] 제일 먼저 주문한 메뉴를 가지고 온다.
              var processState = document['processState'];
              var splitProcessState = processState.toString().split(':');
              if( splitProcessState[0] != '' ) {
                processState = splitProcessState[0];
              }

              // 주문 상태에 따른 안내 정보
              orderStatusInfo = getOrderStatus(processState, userName, splitProcessState);

              // 푸시 알림으로 메뉴 준비 상태 알리기
              // LocalNotification().showNotification(processState);

              // 카드 이미지
              return OrderProcessStateCard(
                orderCanceled: orderStatusInfo.isCanceled,
                cardTitlePhrase: orderStatusInfo.title,
                cardSubTitlePhrase: orderStatusInfo.subTitle,
                graphImage: orderStatusInfo.graphImage,
                documentSnapshot: document
              );
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

  // 주문 상태에 따른 안내 정보
  OrderStatusInfo getOrderStatus(String processState, String userName, List<String> splitProcessState) {
    bool orderCanceled = false;
    String title = '';
    String subTitle = '';
    String graphImage = '';

    if (processState == 'new') {
      title = '주문을 확인하고 있습니다. 🏃🏻‍♀️';
      subTitle = '주문 상황에 따라 준비가 늦어질 수 있습니다. 본인이 직접 메뉴를 수령해 주세요.';
      graphImage = 'image/IMG_order_status_new.png';

    } else if (processState == 'inProcess') {
      title = '$userName 님의 주문을 준비 중입니다.';
      subTitle = '주문 승인 즉시 메뉴 준비가 시작됩니다. 완성 후, 빠르게 픽업해 주세요.';
      graphImage = 'image/IMG_order_status_inProcess.png';

    } else if (processState == 'done') {
      title = '$userName 님, 메뉴가 모두 준비되었어요.';
      subTitle = '메뉴가 모두 준비되었어요. 픽업대에서 메뉴를 픽업해주세요!';
      graphImage = 'image/IMG_order_status_done.png';

    } else if( processState == 'canceled' ) {
      orderCanceled = true;
      var reasonOfCancel = splitProcessState[1];
      title = '$userName 님, 주문이 취소되었어요.';
      subTitle = '$reasonOfCancel (으)로 주문이 취소되었습니다.';
      graphImage = '';
    }

    return OrderStatusInfo(
      title: title,
      subTitle: subTitle,
      graphImage: graphImage,
      isCanceled: orderCanceled
    );
  }
}

class OrderStatusInfo {
  final String title;
  final String subTitle;
  final String graphImage;
  final bool isCanceled;

  OrderStatusInfo({
    required this.title,
    required this.subTitle,
    required this.graphImage,
    this.isCanceled = false
  });
}