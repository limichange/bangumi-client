import 'package:bangumi/src/pages/LoginAndSignupPage/LoginForm.dart';
import 'package:bangumi/src/pages/LoginAndSignupPage/SignupForm.dart';
import 'package:flutter/material.dart';

class LoginAndSignupPage extends StatefulWidget {
  @override
  _LoginAndSignupPage createState() {
    return _LoginAndSignupPage();
  }
}

class _LoginAndSignupPage extends State<LoginAndSignupPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = new TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  onSignupOk() {
    print('onSignupOk');

    _tabController.animateTo(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _tabController,
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
        controller: _tabController,
        children: [
          SingleChildScrollView(
            child: Container(
              height: 400,
              child: LoginForm(),
            ),
          ),
          SingleChildScrollView(
            child: Container(
                height: 500,
                child: SignupForm(
                  onSignupOk: onSignupOk,
                )),
          ),
        ],
      ),
    );
  }
}
