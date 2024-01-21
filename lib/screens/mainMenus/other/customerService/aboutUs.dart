import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oasis_cafe_app/provider/aboutUsProvider.dart';
import 'package:provider/provider.dart';

import '../../../../config/palette.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {


  @override
  void initState() {
    super.initState();
  }


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
              return const CircularProgressIndicator();

            } else if( snapshot.connectionState == ConnectionState.done ) {
              if( snapshot.hasError ) {

                return Center(
                  child: Text(snapshot.error.toString()),
                );

              } else {
                // List<AboutUsModel> storeInfo = snapshot.data as List<AboutUsModel>;
                // print('storeInfo > ${storeInfo.isEmpty}');

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

                    Row(
                      children: [
                        const Icon(CupertinoIcons.clock),

                        Column(
                          children: [
                            for( var date = 0; date < 7; date++ )
                              Row(
                                children: [
                                  Text(dateList[date]),
                                  Text(
                                      '${aboutUsProvider.storeInfo[date].openAmPm} ${aboutUsProvider.storeInfo[date].openHour}:${aboutUsProvider.storeInfo[date].openMinutes}'
                                          ' ~ ${aboutUsProvider.storeInfo[date].closeAmPm} ${aboutUsProvider.storeInfo[date].closeHour}:${aboutUsProvider.storeInfo[date].closeMinutes}'
                                  ),
                                ],
                              )
                          ],
                        )
                      ],
                    ),

                    Row(
                      children: [
                        const Icon(Icons.phone),
                        for( var number = 7; number < aboutUsProvider.storeInfo.length; number++ )
                          Text('${aboutUsProvider.storeInfo[number].number1}-${aboutUsProvider.storeInfo[number].number2}-${aboutUsProvider.storeInfo[number].number3}')
                      ],
                    ),

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
}