import 'package:catalog_flutter_app/model/cataloge_model.dart';
import 'package:catalog_flutter_app/pages/mycart_page.dart';
import 'package:catalog_flutter_app/provider/cataloge_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CatalogPage extends StatefulWidget {
  @override
  _CatalogPageState createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {

  @override
  Widget build(BuildContext context) {
    ProviderCatalog providerCatalog = context.watch<ProviderCatalog>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Catalog"),
        actions: [
          GestureDetector(
            //toàn bộ bấm zô đc hết
            child: Stack(
              alignment: Alignment.center, //cái sau đề cái trước ở chính giữa
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Icon(
                    Icons.shopping_cart,
                    size: 48,
                    color: Colors.red,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 11, right: 20),
                  child: Text(
                    "${providerCatalog.slMH}",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            onTap: () => _toAdd(context),
          )
        ],
      ),
      body: buildListMatHang(
          context, providerCatalog.cataloge),//khai baos list mat hang
      //floatingActionButton:
    );
  }


  Widget buildListMatHang(BuildContext context, List<MatHang> list) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
          itemBuilder: (context, index) => buildListItem(list[index], context),
          separatorBuilder: (context, index) => Divider(
                thickness: 5,
                color: Colors.white,
              ),
          itemCount: list.length),
    );
  }

  buildListItem(MatHang mh, BuildContext context) {
    ProviderCatalog providerCatalog = context.read<ProviderCatalog>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 48,
          height: 48,
          color: mh.color,
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
            child: Text(
          "${mh.name}",
          style: TextStyle(fontSize: 20),
        )),
        TextButton(
          onPressed: () => providerCatalog.addToCart(mh),
          child: providerCatalog.checkInCart(mh.id)
              ? Icon(Icons.check)
              : Text("Add"),
        ),
        SizedBox(
          width: 15,
        ),
      ],
    );
  }
}

void _toAdd(BuildContext context) {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyCart(), //hàm đầu vào là context, đầu ra
      ));
}

// void _toEditPage(BuildContext context) async{//nhận đối số BuildContext context
//   var updateProfile = await Navigator.push(context,
//       MaterialPageRoute(builder: (context) => AddProductPage(),//hàm đầu vào là context, đầu ra
//       )
//   );
// }
