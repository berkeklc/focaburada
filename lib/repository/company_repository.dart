import 'dart:convert';
import 'dart:io';

import 'package:focaburada/model/companies_pagination_options.dart';
import 'package:http/http.dart';
import 'package:focaburada/data/api_service.dart';
import 'package:focaburada/model/companies.dart';
import 'package:focaburada/model/pagination_options.dart';

class CompanyRepository {
  Future<CompaniesPaginationOptions> find({
    PaginationOptions paginationOptions,
  }) async {
    Uri uri = APIService.baseUrl.replace(
      path: '/api/page/index.php',
      query: paginationOptions.toQuery(),
    );

    final response = await get(uri);

    if (response.statusCode != HttpStatus.ok) return null;

    Map decodedResponse = jsonDecode(response.body);

    List _companiesList = decodedResponse['company'];

    return CompaniesPaginationOptions(
      companies: _companiesList
          .map(
            (company) => Companies.fromJson(company),
          )
          .toList(),
      page: paginationOptions.page,
      maxPage: decodedResponse['page'],
    );
  }

  Future<List<Companies>> search(String query) async {
    Uri uri = APIService.baseUrl.replace(
      path: '/api/tum_arama.php',
    );
    final body = {
      "isletme_adi": query,
    };

    final response = await post(
      uri,
      body: body,
    );

    Map decodedResponse = jsonDecode(response.body);

    List _companiesList = decodedResponse['company'];

    return _companiesList
        .map(
          (company) => Companies.fromJson(company),
        )
        .toList();
  }
}
