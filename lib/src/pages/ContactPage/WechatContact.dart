import 'package:bangumi/src/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WechatContact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        Clipboard.setData(ClipboardData(text: 'houyao_273628265'));

        print(Utils.showToast(context: context, text: '微信号复制成功'));
      },
      child: Text('微信'),
    );
  }
}
