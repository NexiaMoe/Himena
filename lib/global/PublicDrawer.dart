import 'package:NexiaMoe_EighTeen/screen/newUpload.dart';
import 'package:NexiaMoe_EighTeen/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../screen/trending.dart';

class PublicDrawer extends StatefulWidget {
  PublicDrawer({Key? key}) : super(key: key);

  @override
  _PublicDrawerState createState() => _PublicDrawerState();
}

class _PublicDrawerState extends State<PublicDrawer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.black12,
          ),
          child: Text(''),
        ),
        ListTile(
          leading: const Icon(Icons.new_releases),
          title: const Text('New Release'),
          onTap: () {
            Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (a, b, c) => NewUpload(),
                ));
          },
        ),
        ListTile(
          leading: const Icon(Icons.trending_up),
          title: const Text('Trending'),
          onTap: () {
            Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (a, b, c) => Trending(),
                ));
          },
        ),
      ],
    ));
  }
}
