// ignore_for_file: non_constant_identifier_names

import 'package:nexiamoe_eighteen/screen/search.dart';
import 'package:nexiamoe_eighteen/service/api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../global/PublicDrawer.dart';
import 'animeInfo.dart';

class Trending extends StatefulWidget {
  const Trending({Key? key}) : super(key: key);

  @override
  _Trending createState() => _Trending();
}

class _Trending extends State<Trending> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  List<NewRelease>? _NewRelease;
  Future<void>? _initreleaseData;
  @override
  void initState() {
    super.initState();
    _initreleaseData = _initPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Trending Hentai"),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (a, b, c) => const Search(),
                    ));
              },
              icon: const Icon(Icons.search),
            )
          ],
          centerTitle: true,
        ),
        drawer: const PublicDrawer(),
        body: Center(
          child: FutureBuilder(
            future: _initreleaseData,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  {
                    return const Center(child: Text("None"));
                  }
                case ConnectionState.waiting:
                  {
                    return const Center(child: CircularProgressIndicator());
                  }
                case ConnectionState.active:
                  {
                    return const Center(
                      child: Text('Getting New Release...'),
                    );
                  }
                case ConnectionState.done:
                  {
                    return RefreshIndicator(
                        key: _refreshIndicatorKey,
                        child: GridView.builder(
                            controller: ScrollController(),
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 500,
                                    crossAxisSpacing: 0,
                                    mainAxisSpacing: 20),
                            itemCount: _NewRelease!.length,
                            itemBuilder: (BuildContext context, int index) =>
                                GestureDetector(
                                    onTap: () {
                                      if (kDebugMode) {
                                        print(_NewRelease![index].id);
                                      }
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                InfoDetail(
                                                  id: _NewRelease![index].id,
                                                  cover:
                                                      _NewRelease![index].cover,
                                                )),
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          50, 20, 50, 10),
                                      child: (Flex(
                                        direction: Axis.vertical,
                                        children: [
                                          Flexible(
                                            // height: 300,
                                            child: Image.network(
                                                _NewRelease![index].cover),
                                          ),
                                          const Padding(
                                              padding:
                                                  EdgeInsets.only(top: 20)),
                                          Text(_NewRelease![index].name)
                                        ],
                                      )),
                                    ))),
                        onRefresh: _test);
                  }
              }
            },
          ),
        ),
      ),
    );
  }

  Future<void> _initPhotos() async {
    final release = await GetTrending.getTrending();
    _NewRelease = release;
  }

  Future<void> _test() async {
    Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (a, b, c) => const Trending(),
        ));
    // setState(() {
    //   selectedIndex = 1;
    //   Navigator.pop(context);
    // });
  }
}
