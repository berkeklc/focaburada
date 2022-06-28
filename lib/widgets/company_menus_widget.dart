import 'package:flutter/material.dart';
import 'package:focaburada/model/companies.dart';
import 'package:focaburada/model/menu_product.dart';
import 'package:focaburada/model/model.dart';

class CompanyMenusWidget extends StatefulWidget {
  final Companies company;

  const CompanyMenusWidget({
    Key key,
    this.company,
  }) : super(key: key);

  @override
  State<CompanyMenusWidget> createState() => _CompanyMenusWidgetState();
}

class _CompanyMenusWidgetState extends State<CompanyMenusWidget>
    with TickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    if (widget.company.menus == null || widget.company.menus.isEmpty) return;
    tabController =
        TabController(length: widget.company.menus.length, vsync: this);
  }

  /*
  $ Tab Logic

  - Menu -> Sub Menu List -> Sub Menu Products
  */

  @override
  Widget build(BuildContext context) {
    if (widget.company.menus == null || widget.company.menus.isEmpty == null)
      return SizedBox.shrink();

    Widget subMenuContent(CompanySubMenu companySubMenu) {
      List<MenuProduct> _menuProducts = widget.company.menuProducts
          .where((_menuProduct) => _menuProduct.catId == companySubMenu.catId)
          .toList();

      return Column(
        children: _menuProducts
            .map(
              (menuProduct) => Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${menuProduct.name}',
                        style: TextStyle(fontSize: 14),
                      ),
                      Text(
                        '${menuProduct.price} TL',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  Divider(
                    height: 8,
                    color: Colors.black,
                  ),
                ],
              ),
            )
            .toList(),
      );
    }

    Widget menuContent(CompanyMenu companyMenu) {
      List<CompanySubMenu> _subMenus = widget.company.subMenus
          .where((submenu) => submenu.menuId == companyMenu.menuId)
          .toList();

      return Column(
        children: _subMenus
            .map(
              (CompanySubMenu subMenu) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10, left: 5),
                    child: Text(
                      '${subMenu.name}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  subMenuContent(subMenu),
                ],
              ),
            )
            .toList(),
      );
    }

    List<Widget> tabs = widget.company.menus
        .map(
          (_menu) => Tab(
            child: Container(
              height: 30,
              width: MediaQuery.of(context).size.width / 2.5,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: Alignment.center,
              child: Text(
                '${_menu.name}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        )
        .toList();

    List<Widget> tabbarViews = widget.company.menus.map((companyMenu) {
      return Padding(
        padding: EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: menuContent(companyMenu),
        ),
      );
    }).toList();

    return Container(
      margin: const EdgeInsets.all(8.0),
      height: 300,
      child: Column(
        children: [
          PreferredSize(
            preferredSize: Size.fromHeight(40),
            child: TabBar(
              controller: tabController,
              isScrollable: true,
              indicatorPadding: EdgeInsets.all(0),
              indicatorColor: Colors.black,
              indicatorWeight: 0.01,
              indicatorSize: TabBarIndicatorSize.label,
              overlayColor: null,
              tabs: tabs,
              labelColor: Colors.black,
            ),
          ),
          Container(
            height: 240,
            child: TabBarView(
              controller: tabController,
              children: tabbarViews,
            ),
          )
        ],
      ),
    );
  }
}
