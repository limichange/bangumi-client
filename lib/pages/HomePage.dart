import 'package:bangumi/components/AnimeListItem.dart';
import 'package:bangumi/model/Anime.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = [
      Anime(
          cover:
              'https://i0.hdslb.com/bfs/bangumi/320a6c9893a874e7db755ecb7316a0d0abccec49.jpg@450w_600h.webp',
          desc:
              '简介：在单身的辛苦OL小林身边突然出现的女仆装束的美少女托尔。长着角和尾巴的她的身姿正是所谓的龙娘。在醉酒的小林邀请下说要到家里去的托尔，鬼使神差地开始以小林家女仆的身份工作……！？“女仆”+“龙”=“女仆龙”有着笨手笨脚的可爱之处！龙娘与人类之间基本上很温暖、偶尔有些黑暗的异种族间交流喜剧！！',
          name: '小林家的龙女仆'),
      Anime(
          cover:
              'https://i0.hdslb.com/bfs/bangumi/image/943cbb66870e70d8ad339c5c0b2ddbe2230d0b95.png@450w_600h.webp',
          desc:
              '简介：这是一个人类理所当然拥有超能力“个性”的世界。被称为「笨久」的“无个性”少年·绿谷出久与憧憬的No.1英雄欧尔麦特相遇，被其发现绿谷隐藏的英雄资质，从欧尔麦特手中继承了“个性” One For All。',
          name: '我的英雄学院'),
      Anime(
          cover:
              'https://i0.hdslb.com/bfs/bangumi/a79e331b7443ed5df5a2acd345dc41d598d46ff9.jpg@450w_600h.webp',
          desc:
              '简介：——真正的实力，平等究竟是什么？几乎百分之百实现升学、就业目标的全国首屈一指的名门校──高度育成高等学校。这间简直如同乐园般的学校，真面目却是唯有优秀者才能享受优待的实力至上主义学校！绫小路清隆被分配到最底层的D班。在那里，他遇见了成绩优异个性却超难搞的美少女──堀北铃音，和由体贴与温柔所构成，天使般的少女──栉田桔梗。与她们的相遇，使清隆的态度逐渐改变。',
          name: '欢迎来到实力至上主义的教室'),
      Anime(
          cover:
              'https://i0.hdslb.com/bfs/bangumi/f5d5f51b941c01f8b90b361b412dc75ecc2608d3.png',
          desc:
              '这是一个关于你自身的故事。你体内的故事——。人的细胞数量，约为37兆2千亿个。细胞们在名为身体的世界中，今天也精神满满、无休无眠地在工作着。运送着氧气的红细胞，与细菌战斗的白细胞……！这里，有着细胞们不为人知的故事。',
          name: '工作细胞'),
      Anime(
          cover:
              'https://i0.hdslb.com/bfs/bangumi/9d9cd5a6a48428fe2e4b6ed17025707696eab47b.png@320w_428h.webp',
          desc:
              '大正时期，日本。心地善良的卖炭少年·炭治郎，有一天他的家人被鬼杀死了。而唯一幸存下来的妹妹——祢豆子变成了鬼。被绝望的现实打垮的炭治郎，为了寻找让妹妹变回人类的方法，决心朝着“鬼杀队”的道路前进。人与鬼交织的悲哀的兄妹的故事，现在开始！',
          name: '鬼灭之刃')
    ];

    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("半谷米"),
        ),
        body: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, int index) {
            return AnimeListItem(anime: data[index]);
          },
        ));
  }
}
