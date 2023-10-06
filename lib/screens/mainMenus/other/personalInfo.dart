import 'package:flutter/material.dart';
import 'package:oasis_cafe_app/provider/userStateProvider.dart';
import 'package:provider/provider.dart';

import '../../../strings/strings.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({Key? key}) : super(key: key);

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {

  final formKey = GlobalKey<FormState>();
  var userNameController = TextEditingController();
  var userEmailController = TextEditingController();

  InputDecoration setTextFormDecoration(String labelText) {
    return InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          color: Colors.grey[850],
        ),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black)
        )
    );
  }

  @override
  void initState() {
    super.initState();

    final userStateProvider = Provider.of<UserStateProvider>(context, listen: false);
    var userName = userStateProvider.userName;
    var userEmail = userStateProvider.userEmail;

    userNameController.text = userName;
    userEmailController.text = userEmail;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.personalInfo),
      ),

      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [

              memberInformation(),


            ],
          ),
        ),
      )
    );
  }

  Column memberInformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Member Information(*)',
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),

        SizedBox(height: 20,),

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
}
