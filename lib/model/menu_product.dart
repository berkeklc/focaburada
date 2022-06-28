class MenuProduct {
  MenuProduct({
    this.productId,
    this.menuId,
    this.companyId,
    this.userId,
    this.catId,
    this.name,
    this.info,
    this.file1,
    this.price,
    this.status,
    this.sorting,
  });

  final String productId;
  final String menuId;
  final String companyId;
  final String userId;
  final String catId;
  final String name;
  final String info;
  final String file1;
  final String price;
  final String status;
  final String sorting;

  factory MenuProduct.fromJson(Map<String, dynamic> json) => MenuProduct(
        productId: json["product_id"],
        menuId: json["menu_id"],
        companyId: json["company_id"],
        userId: json["user_id"],
        catId: json["cat_id"],
        name: json["name"],
        info: json["info"],
        file1: json["file1"],
        price: json["price"],
        status: json["status"],
        sorting: json["sorting"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "menu_id": menuId,
        "company_id": companyId,
        "user_id": userId,
        "cat_id": catId,
        "name": name,
        "info": info,
        "file1": file1,
        "price": price,
        "status": status,
        "sorting": sorting,
      };
}
