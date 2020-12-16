import 'dart:convert';

import 'package:clean_architecture/modules/search/domain/entities/result_search.dart';

class ResultSearchModel extends ResultSearch {
  final String login;
  final String url;
  final String avatar_url;

  ResultSearchModel({
    this.login,
    this.url,
    this.avatar_url,
  });

  Map<String, dynamic> toMap() {
    return {
      'login': login,
      'url': url,
      'avatar_url': avatar_url,
    };
  }

  factory ResultSearchModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ResultSearchModel(
      login: map['login'],
      url: map['url'],
      avatar_url: map['avatar_url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ResultSearchModel.fromJson(String source) =>
      ResultSearchModel.fromMap(json.decode(source));
}
