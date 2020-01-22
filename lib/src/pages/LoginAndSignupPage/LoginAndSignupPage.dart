import 'package:bangumi/src/pages/LoginAndSignupPage/LoginForm.dart';
import 'package:bangumi/src/pages/LoginAndSignupPage/SignupForm.dart';
import 'package:flutter/material.dart';

class LoginAndSignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                text: "登录",
              ),
              Tab(
                text: "注册",
              ),
            ],
          ),
          title: Text('欢迎 (*｀∀´*)ノ亻!'),
        ),
        body: TabBarView(
          children: [LoginForm(), SignupForm()],
        ),
      ),
    );
  }
}
