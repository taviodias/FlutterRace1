import 'package:flutter/material.dart';
import 'package:ta_caro/models/theme/app_text.dart';

import 'home.dart';

class Feed extends StatelessWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CardChart(
                    value: 365.0,
                    percent: 0.43,
                  ),
                  SizedBox(height: 27),
                  Text('Preço dos produtos').label,
                  SizedBox(height: 14),
                ],
              ),
            ),
            SizedBox(
              height: 126,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => CardProduct(
                  like: index % 2 == 0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 27),
                  Text('Suas últimas compras').label,
                  SizedBox(height: 14),
                  AppListTile(),
                  AppListTile(),
                  AppListTile(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
