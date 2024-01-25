
import 'package:flutter/material.dart';
import 'package:oasis_cafe_app/config/commonDialog.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionManager {

  static requestNotificationPermission(BuildContext context) async {
      var result = CommonDialog().showConfirmDialog(
          context, "푸시알림 설정 변경은 '설정 > 알림 > Oasis cafe > 알림허용'에서 할 수 있어요.", '확인'
      );

      try {
        if( await result ) {
          openAppSettings();
        }
      } catch(e) {
        debugPrint(e.toString());
      }
  }
}