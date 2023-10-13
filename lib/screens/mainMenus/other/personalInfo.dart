import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:oasis_cafe_app/provider/userStateProvider.dart';
import 'package:provider/provider.dart';

import '../../../strings/strings_en.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({Key? key}) : super(key: key);

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {

  final formKey = GlobalKey<FormState>();
  var userNameController = TextEditingController();
  var userEmailController = TextEditingController();
  var userDateOfBirthController = TextEditingController();
  var userMobileNumberController = TextEditingController();
  bool showSpinner = false;

  bool _tryValidation() {
    final isValid = formKey.currentState!.validate();

    // 폼 스테이트 값이 유효하다면 값을 저장
    if( isValid ) {
      formKey.currentState!.save();
    }
    return isValid;
  }

  InputDecoration setTextFormDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: const TextStyle(
        color: Colors.black54,
      ),
      focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black)
      ),
      errorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.red)
      )
    );
  }

  @override
  void initState() {
    super.initState();

    final userStateProvider = Provider.of<UserStateProvider>(context, listen: false);
    var userName = userStateProvider.userName;
    var userEmail = userStateProvider.userEmail;
    var userDateOfBirth = userStateProvider.userDateOfBirth;
    var userMobileNumber = userStateProvider.userMobileNumber;

    userNameController.text = userName;
    userEmailController.text = userEmail;
    userDateOfBirthController.text = userDateOfBirth;
    userMobileNumberController.text = userMobileNumber;
  }


  @override
  void dispose() {
    super.dispose();

    userNameController.dispose();
    userEmailController.dispose();
    userDateOfBirthController.dispose();
    userMobileNumberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.personalInfo),
      ),

      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [

                // 이름, 이메일 정보
                memberInformation(),

                SizedBox(height: 50,),

                // 생일 정보
                birthday(),

                SizedBox(height: 30,),

                Spacer(),
                // update 버튼
                update(),

                SizedBox(height: 50,)
              ],
            ),
          ),
        ),
      )
    );
  }

  // 이름, 이메일 정보
  Column memberInformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          Strings.memberInfo,
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),

        SizedBox(height: 15,),

        // 이름
        TextFormField(
          controller: userNameController,
          validator: (value) {
            if( value!.isEmpty || value.length < 2 ) {
              Strings.nameValidation;
            }
            return null;
          },
          style: TextStyle(
            // label text 와 content text 사이에 간격 주기
            height: 1.6,
            color: Colors.black,
          ),
          cursorColor: Colors.black,
          decoration: setTextFormDecoration(Strings.name),
        ),

        SizedBox(height: 10,),

        // 이메일
        TextFormField(
          enabled: false,
          controller: userEmailController,
          style: TextStyle(
            // label text 와 content text 사이에 간격 주기
            height: 1.6,
            color: Colors.grey[850],
          ),
          decoration: setTextFormDecoration(Strings.email),
        ),
      ],
    );
  }

  // 생일 정보(옵션 사항)
  Column birthday() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          Strings.memberBirth,
          style: TextStyle(
              fontWeight: FontWeight.bold
          ),
        ),

        SizedBox(height: 15,),

        // 생일
        TextFormField(
          controller: userDateOfBirthController,
          validator: (value) =>
            value!.length < 6 ? Strings.dateOfBirthValidation : null,

          style: const TextStyle(
            height: 1.6,
            color: Colors.black,
          ),
          cursorColor: Colors.black,
          decoration: setTextFormDecoration(Strings.dateOfBirth),
        ),
      ],
    );
  }

  // 정보 수정 제출 버튼
  ElevatedButton update() {
    return ElevatedButton(
      onPressed: () async {
        // 사용자 입력 값 유효성 검사
        var isValid = _tryValidation();

        if( isValid ) {

          try {
            setState(() {
              showSpinner = true;
            });

            var isUpdated = Provider.of<UserStateProvider>(context, listen: false).updateUserInfo(
                            userNameController.text,
                            userDateOfBirthController.text,
                            userMobileNumberController.text
                        );

            if( await isUpdated ) {
              setState(() {
                showSpinner = false;
              });
            }
          } catch(e) {
            print(e);
          }
        }

      },

      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: Colors.teal,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
        ),
        side: BorderSide(
            color: Colors.teal,
            width: 1
        )
      ),

      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 15, bottom: 15),
        child: Text(
          'Update',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
        ),
      )
    );
  }

}
