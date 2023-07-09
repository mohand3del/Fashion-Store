class ProductModel{
  int? id;
  String? name;
  String? description;
  int? price;
  int? oldPrice;
  int? discount;
  String? image;

  ProductModel.fromJson({required Map<String,dynamic>data}){
    id = data['id'].toInt();
    name = data['name'].toString();
    description = data['description'].toString();
    price = data['price'].toInt();
    oldPrice = data['old_price'].toInt();
    discount = data['discount'].toInt();
    image = data['image'].toString();


  }
}