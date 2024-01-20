import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oasis_cafe_app/model/model_aboutUs.dart';
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

    final aboutUsProvider = Provider.of<AboutUsProvider>(context);

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
                List<AboutUsModel> storeInfo = snapshot.data as List<AboutUsModel>;

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
                        Icon(CupertinoIcons.clock),
                        Container(
                          child: Row(
                            children: [
                              Text(''),
                              Text('오전 11:30 ~ 오후 9시'),
                            ],
                          ),
                        )
                      ],
                    ),

                    Row(
                      children: [
                        Icon(Icons.phone),
                        Text('00-000-0000')
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