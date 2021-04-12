
import 'package:cataloge_flutter_app/model/catalog_model.dart';
import 'package:cataloge_flutter_app/provider/catalog_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CatalogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProviderCatalog providerCatalog = context.watch<ProviderCatalog>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Cata"),
        actions: [
          GestureDetector(//toàn bộ bấm zô đc hết
            child: Stack(
              alignment: Alignment.center,//cái sau đề cái trước ở chính giữa
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Icon(Icons.shopping_cart,size: 48,color: Colors.red,),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 11,right: 20),
                  child: Text("${providerCatalog.slMH}",style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            // onTap: () => toCartPage(context),
          )
        ],
      ),
      body: buildListMatHang(context,providerCatalog.cataloge),//khai baos list mat hang

    );
  }
  Widget buildListMatHang(BuildContext context,List<MatHang> list){
    return ListView.separated(
        itemBuilder: (context, index) => buildListItem(list[index], context),
        separatorBuilder: (context, index) => buildListItem(list[index],context),
        itemCount: list.length);
  }

  buildListItem(MatHang mh, BuildContext context){
    ProviderCatalog providerCatalog = context.read<ProviderCatalog>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(width: 48,height: 48, color: mh.color,),
        SizedBox(width: 20,),
        Expanded(child: Text("${mh.name}",style: TextStyle(fontSize: 20),)
        ),
        TextButton(onPressed: () => providerCatalog.addToCart(mh), child: providerCatalog.checkInCart(mh.id)? Icon(Icons.check):Text("Add"),
        ),
        SizedBox(width: 15,),
      ],
    );
  }
}

