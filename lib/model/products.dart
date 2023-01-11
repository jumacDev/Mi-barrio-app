class Product{
  late int id;
  late int idstore;
  late String name, unity;
  late int price, cant;

  Product(this.id, this.idstore, this.name, this.unity, this.price);

  //data = id;name;unity;price
  Product.fromString(String data){
    List<String> listpr = data.split(";");
    id = int.parse(listpr[1]);
    idstore = int.parse(listpr[0]);
    name = listpr[2];
    unity = listpr[3];
    price = int.parse(listpr[4]);
    cant = 0;
  }

  Product.fromOrderString(String data){
    List<String> listpr = data.split(",");
    id = 0;
    idstore = 0;
    name = listpr[0];
    unity = '';
    price = int.parse(listpr[1]);
    cant = int.parse(listpr[2]);
  }

  Product.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        idstore = json['idstore'],
        name = json['name'],
        unity = json['unity'].toString(),
        price = int.parse(json['price'].toString()),
        cant = int.parse(json['cant'].toString());

  Map<String, dynamic> toJson() => {
    "id": id,
    "idstore": idstore,
    "name": name,
    "unity": unity,
    "price": price,
    "cant": cant,
  };

}