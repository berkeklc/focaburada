import 'package:focaburada/model/companies.dart';
import 'package:focaburada/model/pagination_options.dart';

class CompaniesPaginationOptions implements PaginationOptions {
  CompaniesPaginationOptions({
    this.companies,
    this.page,
    this.maxPage,
  });

  List<Companies> companies;

  @override
  int page;

  @override
  int maxPage;

  @override
  Map<String, dynamic> toMap() {
    return {
      'page': page,
    };
  }

  @override
  String toQuery() => 'page=$page';

  reset() {
    page = 1;
  }

  update() {
    page += 1;
  }

  bool get canGoNextPage {
    if (maxPage == null) {
      return true;
    }

    return page < maxPage;
  }
}
