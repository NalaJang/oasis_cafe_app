import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oasis_cafe_app/config/gaps.dart';
import 'package:provider/provider.dart';

import '../../../../config/palette.dart';
import '../../../../model/model_transactionHistory.dart';
import '../../../../provider/orderStateProvider.dart';

class OrderProcessStateCard extends StatelessWidget {

  final bool orderCanceled;
  final String cardTitlePhrase;
  final String cardSubTitlePhrase;
  final String graphImage;
  final DocumentSnapshot documentSnapshot;

  const OrderProcessStateCard({super.key,
    required this.orderCanceled,
    required this.cardTitlePhrase,
    required this.cardSubTitlePhrase,
    required this.graphImage,
    required this.documentSnapshot
  });


  @override
  Widget build(BuildContext context) {
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 주문 상태 메인 문구
          Text(
            cardTitlePhrase,
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold
            ),
          ),

          Gaps.gapH15,

          // 주문 상태 설명 문구
          Text(
            cardSubTitlePhrase,
            style: const TextStyle(
              fontSize: 15.0,
              color: Colors.black54
            ),
          ),

          Gaps.gapH25,

          // 주문 상태 그래프 이미지
          graphImage == '' ? Gaps.emptySizedBox : Image.asset(graphImage),

          Gaps.gapH15,

          // 주문 확인 버튼
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              orderCanceled == false ?
              Gaps.emptySizedBox :
              // 주문이 취소된 경우, 사용자가 취소 확인을 할 수 있도록 버튼을 노출
              TextButton(
                onPressed: (){
                  Provider.of<OrderStateProvider>(context, listen: false).checkedCanceledOrder(documentSnapshot);
                },

                child: const Text(
                  '확인했습니다.',
                  style: TextStyle(
                    color: Palette.textColor1,
                  ),
                )
              ),

              // 주문 리스트 확인 버튼
              TextButton(
                onPressed: (){
                  showOrderListDialog(documentSnapshot, context);
                },

                child: const Text(
                  '주문 확인',
                  style: TextStyle(
                    color: Colors.brown,
                  ),
                )
              ),
            ],
          )
        ],
      ),
    );
  }

  // 주문 리스트 확인 버튼
  Future<void> showOrderListDialog(DocumentSnapshot documentSnapshot, BuildContext context) {
    var data = TransactionHistoryModel.getSnapshotDataFromUserOrder(documentSnapshot);

    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10)
        )
      ),

      builder: (context) {
        double dialogHeight = MediaQuery.of(context).size.height * 0.5;
        return SizedBox(
          height: dialogHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 15, top: 20, bottom: 10),
                child: const Text(
                  '주문내역(1)',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),

              Expanded(
                child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, int index) {
                    return Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(15),
                          child: Image.asset(
                            'image/IMG_espresso.png',
                            scale: 2.5,
                          ),
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${data.itemName} ${data.quantity}',
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold
                              ),
                            ),

                            Gaps.gapH10,

                            Row(
                              children: [
                                Text(data.hotOrIced),
                                const Text(' | '),
                                Text(data.drinkSize),
                                const Text(' | '),
                                Text(data.cup)
                              ],
                            ),

                            //// 옵션 사항
                            // 에스프레소
                            data.espressoOption != 2 ? Text('${data.espressoOption}') : Gaps.emptySizedBox,
                            // 시럽
                            data.syrupOption != "" ? Text(data.syrupOption) : Gaps.emptySizedBox,
                            // 휘핑 크림
                            data.whippedCreamOption != "" ? Text(data.whippedCreamOption) : Gaps.emptySizedBox,
                            // 얼음
                            data.iceOption != "" ? Text('얼음 ${data.iceOption}') : Gaps.emptySizedBox,
                          ],
                        ),
                      ],
                    );
                  }
                ),
              )
            ],
          ),
        );
      }
    );
  }
}
