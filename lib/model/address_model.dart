class AddressModel {
  late int? _id;
  late String _addressType;
  late String? _contactPersonName;
  late String? _contactPersonNumber;
  late String _address;
  late String _latitude;
  late String _longitude;

  AddressModel({
    id,
    required addressType,
    contactPersonName,
    contactPersonNumber,
    required address,
    required latitude,
    required longitude,
  }) {
    _id = id;
    _addressType = addressType;
    _contactPersonName = contactPersonName;
    _contactPersonNumber = contactPersonNumber;
    _address = address;
    _latitude = latitude;
    _longitude = longitude;
  }
  String get address => _address;
  String get addressType => _addressType;
  String? get contactPersonName => _contactPersonName;
  String? get contactPersonNumber => _contactPersonNumber;
  String get longitude => _longitude;
  String get latitude => _latitude;

  AddressModel.fromJson(Map<String,dynamic> json){
    _id=json['id'];
    _addressType=json['address_type']??"";
    _contactPersonNumber=json['contact_person_number']??"";
    _contactPersonName=json['contact_person_name']??"";
    _address = json["address"];
    _latitude = json["latitude"];
    _longitude = json["longitude"];
  }

  Map<String , dynamic> toJson(){
    final Map<String,dynamic> data = Map<String,dynamic>();

    data['id'] = this._id;
    data['address_type'] = this._addressType;
    data['contactPersonName'] = this._contactPersonName;
    data['contactPersonNumber'] = this._contactPersonNumber;
    data['address'] = this._address;
    data['latitude'] = this._latitude;
    data['_ongitude'] = this._longitude;
    return data;
  }
}
