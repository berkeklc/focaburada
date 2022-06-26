import 'package:flutter/material.dart';

class PaginationOptions {
  int page;
  int maxPage;

  PaginationOptions({
    @required this.page,
    @required this.maxPage,
  });

  Map<String, dynamic> toMap() => {
        'page': page,
      };

  String toQuery() => 'page=$page';
}
