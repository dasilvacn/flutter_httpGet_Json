class Veri {
  String name;
  String foto;
  double price;

  Veri({this.foto, this.name, this.price});

  Veri.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    foto = json["imageUrl"];
    price = json["price"];
  }
}
