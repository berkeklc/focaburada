class CompanySubMenu {
  CompanySubMenu({
    this.catId,
    this.menuId,
    this.companyId,
    this.userId,
    this.name,
    this.sorting,
    this.status,
  });

  final String catId;
  final String menuId;
  final String companyId;
  final String userId;
  final String name;
  final String sorting;
  final String status;

  factory CompanySubMenu.fromJson(Map<String, dynamic> json) => CompanySubMenu(
        catId: json["cat_id"],
        menuId: json["menu_id"],
        companyId: json["company_id"],
        userId: json["user_id"],
        name: json["name"],
        sorting: json["sorting"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "cat_id": catId,
        "menu_id": menuId,
        "company_id": companyId,
        "user_id": userId,
        "name": name,
        "sorting": sorting,
        "status": status,
      };
}
