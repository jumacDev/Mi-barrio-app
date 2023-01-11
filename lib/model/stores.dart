enum StoresType{
  tienda, drogueria, ferreteria, lavanderia, otros
}

class Store{
  final String idstore;
  final String namestore;
  final String adresstore;
  final double latitude, longitude;
  final String cellphonestore;
  final String email;
  final String webpage;
  final StoresType typestore;
  final String logo;

  Store({
    required this.idstore, required this.namestore, required this.adresstore,
    required this.latitude, required this.longitude, required this.cellphonestore,
    required this.email, required this.webpage, required this.typestore, required this.logo
  });

  Store.fromJson(Map<String, dynamic> json)
      : idstore = json['idstore'].toString(),
        namestore = json['namestore'],
        adresstore = json['adresstore'],
        latitude = double.parse(json['latitude'].toString()),
        longitude = double.parse(json['longitude'].toString()),
        cellphonestore = json['cellphonestore'].toString(),
        email = json['email'],
        webpage = json['webpage'],
        typestore = StoresType.values.firstWhere((element) => element.toString() == json['typestore'].toString()),
        logo = json['logo'];

  Map<String, dynamic> toJson() => {
    "idstore": idstore,
    "namestore": namestore,
    "adresstore": adresstore,
    "latitude": latitude,
    "longitude": longitude,
    "cellphonestore": cellphonestore,
    "email": email,
    "webpage": webpage,
    "typestore": typestore.toString(),
    "logo": logo,
  };

}