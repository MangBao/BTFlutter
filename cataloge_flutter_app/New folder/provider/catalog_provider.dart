import 'package:cataloge_flutter_app/model/catalog_model.dart';
import 'package:flutter/foundation.dart';

class ProviderCatalog extends ChangeNotifier{
  List<MatHang> _matHang;
  List<int> _gioHang = []; //danh sach chua id cua cac mat hang
  ProviderCatalog(){
    _matHang = CatalogModel.matHangs;//lay ds gan cho mat hang cua minh
  }
//trang thai ung dung
  int get slMH => _gioHang.length;//gio hang co bao nhiu mat hang(cap nhat so trong gio hang)
  List<MatHang> get cataloge => _matHang;
  List<MatHang> get gioHang => _gioHang.map((id) => _matHang[id]).toList();//co ds id roi, tu moi id chuyen thanh 1 mat hang
  //nhan doi so id, tra ve toList ở phía trước
  int get total => gioHang.fold(0, (previousValue, curentElement) => previousValue + curentElement.price);//duyet qua ds các mh trong giỏ hàng, + price
  //hàm fold(cuộn lại) : giá trị khởi tạo = 0
  //end

  bool checkInCart(int id){//kt mặt hàng có trong gh hay chưa, nếu chưa có thì thay dấu check tồi đưa mt vào giỏ
    //nhận id, kt id trong giỏ hàng có ko
    return _gioHang.indexOf(id)>-1;//phương thức indexOf ko có trả về -1; nhận số > hơn -1 thì nhận gt true, = -1 là false
  }
  //thêm vào giỏ
  void addToCart(MatHang mh){
  //nhận đối số là 1 mh, kt nếu ko có trong gh thì thêm, khi thêm vào rồi thì notifi lại
    if(!checkInCart(mh.id)){
      _gioHang.add(mh.id);
      notifyListeners();
    }
  }

  void removeFromCart(MatHang mh){
    int idXoa = _gioHang.indexOf(mh.id);
    _gioHang.removeAt(idXoa);
    notifyListeners();
  }
  //nhaanj vao doi so la mat hang,
}






