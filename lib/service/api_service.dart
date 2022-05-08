// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

// var IP = "103.147.32.54";
var IP = "192.168.5.254";

class NewRelease {
  final int id;
  final String name;
  final String cover;

  NewRelease(this.id, this.name, this.cover);
}

class DetailHenti {
  final int id;
  final String name;
  final DateTime released;
  final List tags;
  final int views;
  final int likes;
  final int dislikes;
  final int downloads;
  final String brand;
  final String cover;
  final String description;
  final String? low;
  final String? med;
  final String? high;
  final String? fhd;

  const DetailHenti(
      this.id,
      this.name,
      this.released,
      this.tags,
      this.views,
      this.likes,
      this.dislikes,
      this.downloads,
      this.brand,
      this.cover,
      this.description,
      this.low,
      this.med,
      this.high,
      this.fhd);
  factory DetailHenti.fromJson(Map<String, dynamic> json) {
    return DetailHenti(
        json['id'],
        json['name'],
        DateTime.fromMicrosecondsSinceEpoch(json['released']),
        json['tags'],
        json['views'],
        json['likes'],
        json['dislikes'],
        json['downloads'],
        json['brand'],
        json['cover'],
        json['description'],
        json['quality']['360p'],
        json['quality']['480p'],
        json['quality']['720p'],
        json['quality']['1080p']);
  }
}

class GetNR {
  static Future<List<NewRelease>> getNewRelease() async {
    var data = await http.get(Uri.parse("http://$IP:5000/new"));
    var jsonData = json.decode(data.body);
    List<NewRelease> name = [];

    for (var u in jsonData) {
      NewRelease names = NewRelease(u['id'], u['name'], u['cover']);
      name.add(names);
    }
    if (kDebugMode) {
      print(name.length);
    }
    // print(name);
    return name;
  }
}

class GetTrending {
  static Future<List<NewRelease>> getTrending() async {
    var data = await http.get(Uri.parse("http://$IP:5000/trending"));
    var jsonData = json.decode(data.body);
    List<NewRelease> name = [];

    for (var u in jsonData) {
      NewRelease names = NewRelease(u['id'], u['name'], u['cover']);
      name.add(names);
    }
    if (kDebugMode) {
      print(name.length);
    }
    return name;
  }
}

class GetInfo {
  static Future<DetailHenti> getDetail(int id) async {
    var data = await http.get(Uri.parse("http://$IP:5000/anime?id=$id"));
    if (data.statusCode == 200) {
      return DetailHenti.fromJson(jsonDecode(data.body));
    } else {
      throw Exception('Failed to load Detail');
    }
  }
}

  // factory NewRelease.createNewRelease(Map<String, dynamic> object) {
  //   return NewRelease(
  //       id: object['id'],
  //       name: object['name'],
  //       cover: object['cover'],
  //       baru: object['new']);
  // }
  // static Future<NewRelease> connectToAPI() async {
  //   String apiURL = "http://127.0.0.1:5000/new";
  //   var apiResult = await http.get(apiURL);
  //   var jsonObject = json.decode(apiResult.body);
  //   if (kDebugMode) {
  //     print(jsonObject);
  //   }

  //   return NewRelease.createNewRelease(jsonObject);
  // }
