import 'package:flutter/material.dart';

class AccountTransactionHistory extends StatelessWidget {
  const AccountTransactionHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction History'),
      ),
    );
  }
}
