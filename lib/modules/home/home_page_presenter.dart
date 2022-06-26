import 'package:focaburada/data/Categories.dart';
import 'package:focaburada/data/Cities.dart';
import 'package:focaburada/model/companies_pagination_options.dart';
import 'package:focaburada/model/model.dart';
import 'package:focaburada/model/pagination_options.dart';
import 'package:focaburada/repository/company_repository.dart';

abstract class HomePageContract {
  onCompaniesUpdate(List<Companies> _companies);
  onCompaniesLoading(bool _newValue);
  onSearchResultUpdate(List<Companies> _companies);
  onCategoriesUpdate(List<Categories> _categories);
  onCitiesUpdate(List<Cities> _cities);
}

class HomePagePresenter {
  HomePageContract _view;

  HomePagePresenter(this._view);

  bool _isCompaniesLoading = false;

  CompaniesPaginationOptions companiesPaginationOptions =
      CompaniesPaginationOptions(
    page: 1,
  );

  getCompanies({
    bool nextPage = false,
    bool resetPage = false,
  }) async {
    if (resetPage) {
      companiesPaginationOptions.reset();
    }

    if (_isCompaniesLoading) return;
    if (!companiesPaginationOptions.canGoNextPage) return;

    _isCompaniesLoading = true;

    _view.onCompaniesLoading(true);

    print('Get companies called');

    CompaniesPaginationOptions _companiesPaginationOptions =
        await CompanyRepository().find(
      paginationOptions: companiesPaginationOptions,
    );

    _isCompaniesLoading = false;
    _view.onCompaniesLoading(false);

    if (_companiesPaginationOptions.companies.isEmpty) return;

    companiesPaginationOptions = _companiesPaginationOptions;

    companiesPaginationOptions.update();

    _view.onCompaniesUpdate(_companiesPaginationOptions.companies);
  }

  search(String query) async {
    _view.onCompaniesLoading(true);

    List<Companies> result = await CompanyRepository().search(query);

    _view.onCompaniesLoading(false);

    _view.onSearchResultUpdate(result);
  }

  getCities() async {}

  getCategories() {}

  getSearchResults() {}
}
