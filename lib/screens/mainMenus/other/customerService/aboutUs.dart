import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oasis_cafe_app/config/circularProgressBar.dart';
import 'package:oasis_cafe_app/config/commonTextStyle.dart';
import 'package:oasis_cafe_app/provider/aboutUsProvider.dart';
import 'package:provider/provider.dart';

import '../../../../config/palette.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // ConnectionState.waiting 에서 벗어 나지 못해 listen: false 추가.
    final aboutUsProvider = Provider.of<AboutUsProvider>(context, listen: false);
    List<String> dateList = ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('매장 정보'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FutureBuilder(
          future: aboutUsProvider.fetchStoreInfo(),
          builder: (context, snapshot) {

            if( snapshot.connectionState == ConnectionState.waiting ) {
              return CircularProgressBar.circularProgressBar;

            } else if( snapshot.connectionState == ConnectionState.done ) {
              if( snapshot.hasError ) {

                return Center(
                  child: Text(snapshot.error.toString()),
                );

              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Oasis Cafe',
                      style: TextStyle(
                        color: Palette.textColor1,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0
                      ),
                    ),

                    // 운영 시간
                    _setOpeningHours(aboutUsProvider, dateList),

                    // 전화번호
                    _setPhoneNumber(aboutUsProvider),

                    Row(
                      children: [
                        Icon(CupertinoIcons.location_solid),
                        Text('서울')
                      ],
                    ),
                  ],
                );
              }
            } else {
              return const Center(child: Text('No data'),);
            }
          },
        ),
      ),
    );
  }

  // 운영 시간
  Widget _setOpeningHours(AboutUsProvider aboutUsProvider, List<String> dateList) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(CupertinoIcons.clock),

          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '영업 중',
                  style: CommonTextStyle.fontBoldSize17TextColor1,
                ),

                for( var date = 0; date < 7; date++ )
                  Row(
                    children: [
                      Text(
                        dateList[date],
                        style: CommonTextStyle.fontSize17,
                      ),
                      Text(
                        ' ${aboutUsProvider.storeInfo[date].openAmPm} ${aboutUsProvider.storeInfo[date].openHour}:${aboutUsProvider.storeInfo[date].openMinutes}'
                            ' ~ ${aboutUsProvider.storeInfo[date].closeAmPm} ${aboutUsProvider.storeInfo[date].closeHour}:${aboutUsProvider.storeInfo[date].closeMinutes}',
                        style: CommonTextStyle.fontSize17,
                      ),
                    ],
                  )
              ],
            ),
          )
        ],
      ),
    );
  }

  // 전화번호
  Row _setPhoneNumber(AboutUsProvider aboutUsProvider) {
    return Row(
      children: [
        const Icon(Icons.phone),
        for( var number = 7; number < aboutUsProvider.storeInfo.length; number++ )
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0),
            child: Text(
              '${aboutUsProvider.storeInfo[number].number1} - ${aboutUsProvider.storeInfo[number].number2} - ${aboutUsProvider.storeInfo[number].number3}',
              style: const TextStyle(
                  fontSize: 17.0
              ),
            ),
          )
      ],
    );
  }
}