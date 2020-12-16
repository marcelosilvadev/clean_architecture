import 'dart:convert';

import 'package:clean_architecture/modules/search/domain/errors/errors.dart';
import 'package:clean_architecture/modules/search/external/datasource/github_datasource.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../utils/github_response.dart';

class DioMock extends Mock implements Dio {}

main() {
  final dio = DioMock();
  final datasource = GithubDatasource(dio);
  test("shoul return a ResultSearchModel list", () async {
    when(dio.get(any)).thenAnswer(
        (_) async => Response(data: jsonDecode(githubResult), statusCode: 200));

    final future = datasource.getSearch("marcelo");
    expect(future, completes);
  });

  test("shoul return a error if status code != 200", () async {
    when(dio.get(any)).thenAnswer(
        (_) async => Response(data: jsonDecode(githubResult), statusCode: 401));

    final future = datasource.getSearch("marcelo");
    expect(future, throwsA(isA<DataSourceError>()));
  });

  test("shoul return a error if has error dio", () async {
    when(dio.get(any)).thenThrow(Exception());

    final future = datasource.getSearch("marcelo");
    expect(future, throwsA(isA<Exception>()));
  });
}
