import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ta_caro/models/theme/app_theme.dart';
import 'package:ta_caro/models/user.dart';

class Home extends StatefulWidget {
  final UserModel user;
  const Home({Key? key, required this.user}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var currentIndex = 0;

  void changeIndex(int index) {
    currentIndex = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.background,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 126,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => CardProduct(),
                  ),
                ),
              ),
              AppListTile(),
              AppListTile(),
              AppListTile(),
            ],
          ),
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
      padding: const EdgeInsets.only(top: 18, right: 23, left: 23),
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
              style: TextStyle(color: Colors.black),
            ),
          ),
          title: Text('Produto'),
          subtitle: Text('Preço'),
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
  const CardProduct({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
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
                  child: Icon(Icons.thumb_up)),
              title: Text('Produto'),
              subtitle: Text('Preço'),
            ),
            Text.rich(TextSpan(text: 'Agora\n', children: [
              TextSpan(text: 'R\$ 67,50'),
            ]))
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
            index: 1,
            enabled: currentIndex == 1,
            icon: Icons.add,
          ),
          IconBottomNavigator(
            onChanged: onChanged,
            index: 2,
            enabled: currentIndex == 2,
            icon: Icons.person,
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
