import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ta_caro/models/theme/app_theme.dart';
import 'package:ta_caro/models/user.dart';
import 'package:ta_caro/models/theme/app_text.dart';
import 'package:ta_caro/screens/create_bottomsheet.dart';
import 'package:ta_caro/screens/feed.dart';

class Home extends StatefulWidget {
  final UserModel user;
  final List<Widget> pages;
  const Home({Key? key, required this.pages, required this.user})
      : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var currentIndex = 0;

  void changeIndex(int index) {
    if (index == 3) {
      showModalBottomSheet(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32), topRight: Radius.circular(32))),
          context: context,
          builder: (context) => CreateBottomsheet());
    } else {
      currentIndex = index;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.background,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            widget.pages[currentIndex],
            Positioned(
              bottom: 14,
              right: 26,
              left: 26,
              child: AppBottomNavigator(
                currentIndex: currentIndex,
                onChanged: changeIndex,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AppListTile extends StatelessWidget {
  const AppListTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.colors.textEnabled,
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: AppTheme.colors.background,
            radius: 30,
            child: Text(
              '11/12',
              style: AppTheme.textStyles.label,
            ),
          ),
          title: Text(
            'Produto',
            style: AppTheme.textStyles.titleListTile,
          ),
          subtitle: Text(
            'Preço',
            style: AppTheme.textStyles.subtitleListTile,
          ),
          trailing: PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(child: Text('Editar')),
              PopupMenuItem(child: Text('Excluir')),
            ],
          ),
        ),
      ),
    );
  }
}

class CardProduct extends StatelessWidget {
  final bool like;
  const CardProduct({
    Key? key,
    required this.like,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Container(
        width: 232,
        decoration: BoxDecoration(
          color: AppTheme.colors.textEnabled,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                  backgroundColor: AppTheme.colors.background,
                  radius: 30,
                  child: like
                      ? Icon(Icons.thumb_up)
                      : Icon(
                          Icons.thumb_down,
                          color: AppTheme.colors.badColor,
                        )),
              title: Text(
                'Produto',
                style: AppTheme.textStyles.titleListTile,
              ),
              subtitle: Text(
                'Preço',
                style: AppTheme.textStyles.subtitleListTile,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50),
              child: Text.rich(
                TextSpan(
                    text: "Agora\n",
                    style: AppTheme.textStyles.subtitleListTile,
                    children: [
                      TextSpan(
                          text: "R\$ 67,50", style: AppTheme.textStyles.title),
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AppBottomNavigator extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onChanged;
  const AppBottomNavigator({
    Key? key,
    required this.onChanged,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.colors.textEnabled,
        borderRadius: BorderRadius.circular(12),
      ),
      height: 76,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconBottomNavigator(
            onChanged: onChanged,
            index: 0,
            enabled: currentIndex == 0,
            icon: Icons.home,
          ),
          IconBottomNavigator(
            onChanged: onChanged,
            index: 3,
            enabled: false,
            icon: Icons.add,
          ),
          IconBottomNavigator(
            onChanged: onChanged,
            index: 1,
            enabled: currentIndex == 1,
            icon: Icons.person_outline,
          ),
        ],
      ),
    );
  }
}

class IconBottomNavigator extends StatelessWidget {
  const IconBottomNavigator({
    Key? key,
    required this.onChanged,
    required this.index,
    required this.enabled,
    required this.icon,
  }) : super(key: key);

  final ValueChanged<int> onChanged;
  final bool enabled;
  final int index;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(index);
      },
      child: Container(
        width: 40,
        height: 40,
        child: Icon(
          icon,
          color: enabled
              ? AppTheme.colors.textEnabled
              : AppTheme.colors.iconInactive,
        ),
        decoration: BoxDecoration(
          color: enabled ? AppTheme.colors.primary : AppTheme.colors.background,
          borderRadius: BorderRadius.circular(13),
        ),
      ),
    );
  }
}

class CardChart extends StatelessWidget {
  final double value, percent;
  const CardChart({Key? key, required this.value, required this.percent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 216,
      decoration: BoxDecoration(
          color: AppTheme.colors.textEnabled,
          borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Gasto mensal').label,
            SizedBox(height: 18),
            Text.rich(TextSpan(
                text: "R\$ ",
                style: AppTheme.textStyles.label,
                children: [
                  TextSpan(
                    text: value.toStringAsFixed(2).replaceAll(".", ","),
                    style: AppTheme.textStyles.title.copyWith(fontSize: 36),
                  )
                ])),
            SizedBox(
              height: 10,
            ),
            ChartHorizontal(
              percent: percent,
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              "Relação de compras caras e boas compras",
              style: AppTheme.textStyles.hint,
            ),
            SizedBox(
              height: 14,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 10,
                      backgroundColor: AppTheme.colors.badColor,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "PAGOU CARO",
                      style: AppTheme.textStyles.hint,
                    ),
                  ],
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 10,
                      backgroundColor: AppTheme.colors.primary,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "BOA COMPRA",
                      style: AppTheme.textStyles.hint,
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ChartHorizontal extends StatelessWidget {
  final double percent;

  const ChartHorizontal({Key? key, required this.percent}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [
            AppTheme.colors.badColor,
            AppTheme.colors.primary,
          ],
          stops: [percent, 0.0],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (percent > 0 && percent <= 1)
              Text(
                "${(percent * 100.0).toInt()}%",
                style: AppTheme.textStyles.chart,
              ),
            if ((1 - percent) > 0)
              Text(
                "${(100 - (percent * 100)).toInt()}%",
                style: AppTheme.textStyles.chart,
              )
          ],
        ),
      ),
    );
  }
}
