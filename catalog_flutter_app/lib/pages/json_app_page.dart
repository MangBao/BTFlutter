import 'package:catalog_flutter_app/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cataloge_json_page.dart';

class AppPageJsonVersion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        CatalogeFileProvider catalogeFileProvider = CatalogeFileProvider();
        catalogeFileProvider.readMatHangs();
        return catalogeFileProvider;
      },
      child: MaterialApp(
        title: "Cataloge App",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue
        ),
        home: CatalogeJsonPage(),
      ),
    );
  }
}
