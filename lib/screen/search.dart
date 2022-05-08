// ignore_for_file: file_names, non_constant_identifier_names
import 'package:flutter/services.dart';
import 'package:nexiamoe_eighteen/service/api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../global/PublicDrawer.dart';
import 'animeInfo.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _Search createState() => _Search();
}

class _Search extends State<Search> {
  late TextEditingController _controller;
  List<NewRelease>? _NewRelease;
  var total = 0;
  var pages = 0;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _search("");
    setState(() {
      var a = GetSearch.getTotal();
      total = a['total'];
      pages = a['pages'];
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Search"),
          centerTitle: true,
        ),
        drawer: const PublicDrawer(),
        body: Center(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: TextField(
                controller: _controller,
                onSubmitted: _search,
                decoration: const InputDecoration(labelText: "Search Hentai"),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: Text("Found $total hentai !"),
            ),
            Expanded(
              child: GridView.builder(
                  controller: ScrollController(),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 500,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 20),
                  itemCount: _NewRelease?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) =>
                      GestureDetector(
                          onTap: () {
                            if (kDebugMode) {
                              print(_NewRelease![index].id);
                            }
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => InfoDetail(
                                        id: _NewRelease![index].id,
                                        cover: _NewRelease![index].cover,
                                      )),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(50, 20, 50, 10),
                            child: (Flex(
                              direction: Axis.vertical,
                              children: [
                                Flexible(
                                  // height: 300,
                                  child:
                                      Image.network(_NewRelease![index].cover),
                                ),
                                const Padding(
                                    padding: EdgeInsets.only(top: 20)),
                                Text(_NewRelease![index].name)
                              ],
                            )),
                          ))),
            )
          ]),
        ),
      ),
    );
  }

  Future _search(String query) async {
    final anime = await GetSearch.getSearch(query, 0);
    var a = await GetSearch.getTotal();

    if (!mounted) return;
    setState(() {
      _NewRelease = anime;
      total = a['total'];
      pages = a['pages'];
    });
  }

  // setState(() {
  //   selectedIndex = 1;
  //   Navigator.pop(context);
  // });
}
