import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../config/bottomNavi.dart';
import '../../../config/commonDialog.dart';
import '../../../provider/userStateProvider.dart';
import '../../../strings/strings_en.dart';


class DeleteAccount extends StatelessWidget {
  const DeleteAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          _pressedDeleteButton(context);
        },

        child: Text(
          Strings.intlMessage('deleteAccount'),
          style: const TextStyle(
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