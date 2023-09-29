import 'package:flutter/material.dart';
import 'package:oasis_cafe_app/provider/userStateProvider.dart';
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
            About()
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
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              aboutList[index],
              style: TextStyle(
                fontSize: 18
              ),
            ),
          );
        }
      ),
    );
  }
}


