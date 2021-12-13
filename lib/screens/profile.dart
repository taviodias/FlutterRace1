import 'package:flutter/material.dart';
import 'package:ta_caro/models/theme/app_theme.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Perfil',
              style: AppTheme.textStyles.title.copyWith(fontSize: 36),
            ),
            SizedBox(height: 100),
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppTheme.colors.textEnabled,
                ),
                child: ListTile(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  title: Text(
                    'Sair do aplicatico',
                    style: AppTheme.textStyles.titleListTile,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
