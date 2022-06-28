class CompanyMenu {
  CompanyMenu({
    this.menuId,
    this.name,
    this.companyId,
    this.userId,
    this.sorting,
  });

  final String menuId;
  final String name;
  final String companyId;
  final String userId;
  final String sorting;

  factory CompanyMenu.fromJson(Map<String, dynamic> json) => CompanyMenu(
        menuId: json["menu_id"],
        name: json["name"],
        companyId: json["company_id"],
        userId: json["user_id"],
        sorting: json["sorting"],
      );

  Map<String, dynamic> toJson() => {
        "menu_id": menuId,
        "name": name,
        "company_id": companyId,
        "user_id": userId,
        "sorting": sorting,
      };
}
