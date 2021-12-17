class Address{
  String placeName = '';
  String place_id = '';
  String latitude = '';
  String longitude = '';
  Address({required this.placeName, required this.place_id, required this.latitude,  required this.longitude});
  Address.fromJson(Map<String, dynamic> json){
    place_id = json['place_id'];
    placeName = json['formatted_address'];
    latitude = json['lat'];
    longitude = json['lng'];

  }
}