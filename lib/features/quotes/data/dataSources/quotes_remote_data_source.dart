/* 
--Created by Edward Mansour-- Dec 4, 2022
*/
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/error/exceptions.dart';
import '../models/quotes_model.dart';

/// Call the [https://zenquotes.io/api/random] endpoint.
///
/// Throws a [ServerException] in case of errors.
///
/// Throws a [TimeOutException] in case of timeout errors.
abstract class QuotesRemoteDataSource {
  Future<List<QuotesModel>> getRandomQuote();
}

class QuotesRemoteDataSourceImpl implements QuotesRemoteDataSource {
  final http.Client client;

  QuotesRemoteDataSourceImpl({
    required this.client,
  });

  Future<List<QuotesModel>> _getQuoteFromUrl(String url, String path) async {
    final response = await client
        .get(
          Uri.https(url, path),
        )
        .timeout(const Duration(seconds: 4),
            onTimeout: () => throw TimeOutException());

    ///! If the status 200 and a list format the return the serialized object
    if (response.statusCode == 200) {
      final decodedResponse = json.decode(response.body);

      final responseList = List<QuotesModel>.from(
          decodedResponse.map((e) => QuotesModel.fromMap(e)));

      return responseList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<QuotesModel>> getRandomQuote() async {
    return await _getQuoteFromUrl("zenquotes.io", "/api/random");
  }
}
