import 'package:flutter/material.dart';
import 'package:oasis_cafe_app/strings/strings_en.dart';
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
    return Text(
      Strings.intlMessage('greeting'),
      style: const TextStyle(
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
      title = Strings.intlMessage('checkingYourOrder');
      subTitle = Strings.intlMessage('checkingYourOrderDes');
      graphImage = 'image/IMG_order_status_new.png';

    } else if (processState == 'inProcess') {
      title = Strings.intlMessageAndArgs('preparingTheOrder', userName);
      subTitle = Strings.intlMessage('preparingTheOrderDes');
      graphImage = 'image/IMG_order_status_inProcess.png';

    } else if (processState == 'done') {
      title = Strings.intlMessageAndArgs('readyForPickUp', userName);
      subTitle = Strings.intlMessage('readyForPickUpDes');
      graphImage = 'image/IMG_order_status_done.png';

    } else if( processState == 'canceled' ) {
      orderCanceled = true;
      var reasonOfCancel = splitProcessState[1];
      title = Strings.intlMessageAndArgs('orderCanceled', userName);
      subTitle = Strings.intlMessageAndArgs('orderCanceledDes', reasonOfCancel);
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