import 'package:flutter/material.dart';
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
    final userUid = Provider.of<UserStateProvider>(context, listen: false).userUid;

    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.settings),
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // 푸시 알람, Shake to pay
            const Preferences(),

            const Divider(color: Colors.grey,),

            // 이용약관, 개인정보 처리 방침, 버전 정보
            const About(),

            const Spacer(),

            // 계정 삭제
            userUid == '' ? const Spacer() : const DeleteAccount(),

            const SizedBox(height: 50,)
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
          setSwitchMenu('Notification', userStateProvider),

          setSwitchMenu('Shake To Pay', userStateProvider),
        ],
      ),
    );
  }

  Row setSwitchMenu(String menuName, UserStateProvider switchButton) {

    if( menuName == 'Notification' ) {
      _isSelected = switchButton.notification;
    } else if( menuName == 'Shake To Pay') {
      _isSelected = switchButton.shakeToPay;
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
              if( menuName == 'Notification' ) {
                // 알람 권한 요청
                // 현재 권한 상태와 상관없이 다이얼로그를 띄우고 권한 설정 화면으로 넘긴다.
                PermissionManager.requestNotificationPermission(context);

              } else if( menuName == 'Shake To Pay') {
                switchButton.shakeToPay = _isSelected;
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
final List<String> aboutList = ['Terms of use', 'Privacy policy', 'App version'];
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


// 계정 삭제
class DeleteAccount extends StatelessWidget {
  const DeleteAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () async {
        _pressedDeleteButton(context);
      },

      child: const Text(
        'Delete Account',
        style: TextStyle(
          color: Colors.red,
          decoration: TextDecoration.underline
        ),
      )
    );
  }


  _pressedDeleteButton(BuildContext context) async {
    var isConfirm = CommonDialog().showDeleteAccountDialog(context);

    if( await isConfirm ) {
      try {
        var isDeleteAccount = Provider.of<UserStateProvider>((context), listen: false).deleteAccount();

        if( await isDeleteAccount ) {
          // pushAndRemoveUntil : 이전 페이지들을 모두 제거하기 위한 메소드.
          // true 를 반환할 때까지 이전 경로를 모두 제거한다.
          Navigator.pushAndRemoveUntil(
            (context),
            MaterialPageRoute(
              builder: (context) => const BottomNavi()
            ), (route) => false
          );
        }

      } catch(e) {
        debugPrint(e.toString());
        ScaffoldMessenger.of((context)).showSnackBar(
          SnackBar(
            content: Text(
              e.toString()
            )
          )
        );
      }
    }
  }
}
