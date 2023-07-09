class BannersModel{
  int? id;
  String? url;

  BannersModel.fromJson({required Map<String,dynamic>data})
  {
    id = data['id'];
    url = data['image'];
  }
}