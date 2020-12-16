import 'package:clean_architecture/modules/search/domain/entities/result_search.dart';
import 'package:clean_architecture/modules/search/domain/errors/errors.dart';
import 'package:clean_architecture/modules/search/domain/repositories/search_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:clean_architecture/modules/search/domain/usecases/search_by_text.dart';
import 'package:mockito/mockito.dart';

class SearchRepositoryMock extends Mock implements SearchRepository{}
main(){
  final repository = SearchRepositoryMock();

  final usecase = SearchByTextImpl(repository);
  test('should return a list ResultSearch', () async {

    when(repository.search(any))
          .thenAnswer((_) async => Right(<ResultSearch>[]));
    
    final result = await usecase("jacob");
    expect(result | null, isA<List<ResultSearch>>());

  });

  test('should return a exception when send invalid text', () async {

    when(repository.search(any))
          .thenAnswer((_) async => Right(<ResultSearch>[]));
    
    var result = await usecase(null);
    expect(result.isLeft(), true);
    expect(result.fold(id, id), isA<InvalidTextError>());

    result = await usecase("");
    expect(result.fold(id, id), isA<InvalidTextError>());
    
  });
}