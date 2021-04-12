import 'package:cataloge_flutter_app/model/catalog_model.dart';
import 'package:flutter/foundation.dart';

class ProviderCataloge extends ChangeNotifier{
  List<MatHang> _matHangs;
  List<int> _gioHang = []; //ds cac id cua mathang trong gio hang

  ProviderCataloge(){
    _matHangs = CatalogModel.matHangs;// lay ds mh o tren gan cho mat hang cua minh
  }
  //state cua ung dung

int get slMH => _gioHang.length;// gio hang co bao nhiu mat hang(cap nhat so trong gio hang)
  List<MatHang> get cataloge =>_matHangs;
  List<MatHang> get gioHang => _gioHang.map((id) => _matHangs[id]).toList();// co ds tu id roi => tu id chuyen thanh 1 mh
  //get doi so >< Id return ve toList() phia trc
  int get total => gioHang.fold(0, (previousValue, currentElement) => previousValue + currentElement.price);
  //duyet qua ds cac mh trong giohang *fold la cuon lai <=> for loop

  bool checkInCart(int id){// kiem tra mh da co trong gh hay chua
    return _gioHang.indexOf(id) > - 1;// true else false
  }
  void addToCart(MatHang mh){
    if(!checkInCart(mh.id)){
      _gioHang.add(mh.id);
      notifyListeners();// cap nhat len UI
    }
  }
  void removeFromCart(MatHang mh){
    int idXoa = _gioHang.indexOf(mh.id);
    _gioHang.removeAt(idXoa);
    notifyListeners();
  }
}