import 'package:flutter/material.dart';
import 'package:oasis_cafe_app/provider/userStateProvider.dart';
import 'package:oasis_cafe_app/screens/login/login.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
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

            SignOut(),

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

class _PreferencesState extends State<Preferences> {

  bool _isSelected = true;

  // final MaterialStateProperty<Icon?> thumbIcon =
  //     MaterialStateProperty.resolveWith<Icon?>((states) {
  //       if( states.contains(MaterialState.selected) ) {
  //         return Icon(Icons.check);
  //       }
  //       return Icon(Icons.close);
  //     });

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
          style: TextStyle(
              fontSize: 18
          ),
        ),

        Switch(
            value: _isSelected,
            onChanged: (value) {
              setState(() {
                _isSelected = value;
                if( menuName == 'Notification' ) {
                  switchButton.notification = _isSelected;
                } else if( menuName == 'Shake To Pay') {
                  switchButton.shakeToPay = _isSelected;
                }
                Provider.of<UserStateProvider>(context, listen: false).updatePreferences(menuName, _isSelected);
              });
            }
        )
      ],
    );
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
                style: TextStyle(
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

class SignOut extends StatefulWidget {
  const SignOut({Key? key}) : super(key: key);

  @override
  State<SignOut> createState() => _SignOutState();
}

class _SignOutState extends State<SignOut> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: (){
          Provider.of<UserStateProvider>(context, listen: false).signOut();

          // pushAndRemoveUntil : 이전 페이지들을 모두 제거하기 위한 메소드.
          // true 를 반환할 때까지 이전 경로를 모두 제거한다.
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => Login()
            ), (route) => false
          );
        },

        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30)
          ),
          side: BorderSide(
            color: Colors.teal,
          )
        ),

        child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 15, bottom: 15),
          child: const Text(
            'Sign out',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.teal,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }
}



