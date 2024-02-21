import 'package:flutter/material.dart';
import 'package:oasis_cafe_app/config/gaps.dart';
import 'package:oasis_cafe_app/config/permissionManager.dart';
import 'package:oasis_cafe_app/provider/userStateProvider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../../config/bottomNavi.dart';
import '../../../config/commonDialog.dart';
import '../../../strings/strings_en.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.intlMessage('settings')),
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: const [
            // 푸시 알람, Shake to pay
            Preferences(),

            Divider(color: Colors.grey,),

            // 이용약관, 개인정보 처리 방침, 버전 정보
            About(),
          ],
        ),
      )
    );
  }
}

// 푸시 알람, Shake to pay
class Preferences extends StatefulWidget {
  const Preferences({Key? key}) : super(key: key);

  @override
  State<Preferences> createState() => _PreferencesState();
}

// WidgetsBindingObserver : 앱 상태 변경 이벤트를 받기 위함
class _PreferencesState extends State<Preferences> with WidgetsBindingObserver {

  bool _isSelected = true;


  @override
  void initState() {
    super.initState();
    // resumed 를 사용하기 위해 앱 상태 변경 이벤트 등록
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch(state) {
      // 알람 권한 설정 화면으로 이동하면서 앱을 빠져나갔다가 들어오면 resumed 상태로 들어온다.
      case AppLifecycleState.resumed :
        checkNotificationPermission();
        break;
    }
  }


  @override
  void dispose() {
    super.dispose();
    // 앱 상태 변경 이벤트 해제
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {

    var userStateProvider = Provider.of<UserStateProvider>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          setSwitchMenu(Strings.intlMessage('notification'), userStateProvider),

          setSwitchMenu(Strings.intlMessage('shakeToPay'), userStateProvider),
        ],
      ),
    );
  }

  Row setSwitchMenu(String menuName, UserStateProvider switchButton) {

    if( menuName == 'Shake to pay') {
      _isSelected = switchButton.shakeToPay;
    } else {
      _isSelected = switchButton.notification;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          menuName,
          style: const TextStyle(
              fontSize: 18
          ),
        ),

        Switch(
          value: _isSelected,
          onChanged: (value) {
            if( menuName == 'Shake to pay') {
              _isSelected = !_isSelected;
              switchButton.shakeToPay = _isSelected;
              Provider.of<UserStateProvider>(context, listen: false).updatePreferences(menuName, _isSelected);
              setState(() {

              });

            } else {
              // 알람 권한 요청
              // 현재 권한 상태와 상관없이 다이얼로그를 띄우고 권한 설정 화면으로 넘긴다.
              PermissionManager.requestNotificationPermission(context);
            }
          }
        )
      ],
    );
  }


  void checkNotificationPermission() async {

    if( mounted ) {
      var userStateProvider = Provider.of<UserStateProvider>(context, listen: false);
      var status = await Permission.notification.status;

      if( status.isGranted ) {
        _isSelected = true;
      } else {
        _isSelected = false;
      }

      setState(() {
        userStateProvider.notification = _isSelected;
      });
      userStateProvider.updatePreferences('Notification', _isSelected);

    } else {
      print('unmounted');
    }
  }
}


// 이용약관, 개인정보 처리 방침, 버전 정보
final List<String> aboutList = [
  Strings.intlMessage('termsOfUse'),
  Strings.intlMessage('privacyPolicy'),
  Strings.intlMessage('appVersion')
];
class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        itemCount: aboutList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text(
                      'clicked ${aboutList[index]}',
                      textAlign: TextAlign.center,
                    ),
                  );
                }
              );
            },

            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                aboutList[index],
                style: const TextStyle(
                  fontSize: 18
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
