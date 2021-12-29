class PassenggersData {
  int totalPassengers = 0;
  int totalPages = 0;
  late List<Data> data;

  PassenggersData({required this.totalPassengers, required this.totalPages, required this.data});

  PassenggersData.fromJson(Map<String, dynamic> json) {
    totalPassengers = json['totalPassengers'];
    totalPages = json['totalPages'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalPassengers'] = this.totalPassengers;
    data['totalPages'] = this.totalPages;
    if (this.data.length > 0) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  late String sId;
  String? name;
  int? trips;
  late List<Airline> airline;
  int? iV;

  Data({required this.sId, required this.name, required this.trips, required this.airline, required this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    print(json['_id']);
    print(json['name']);
    print(json['trips']);

    sId = json['_id'];
    name = json['name'];
    trips = json['trips'];
    if (json['airline'] != null) {
      airline = <Airline>[];
      json['airline'].forEach((v) {
        airline.add(new Airline.fromJson(v));
      });
    }
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['trips'] = this.trips;
    if (this.airline.length > 0) {
      data['airline'] = this.airline.map((v) => v.toJson()).toList();
    }
    data['__v'] = this.iV;
    return data;
  }
}

class Airline {
  late int id;
  late String name;
  late String country;
  late String logo;
  late String slogan;
  late String headQuaters;
  late String website;
  late String established;

  Airline(
      {required this.id,
        required this.name,
        required this.country,
        required this.logo,
        required this.slogan,
        required this.headQuaters,
        required this.website,
        required this.established});

  Airline.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    country = json['country'];
    logo = json['logo'];
    slogan = json['slogan'];
    headQuaters = json['head_quaters'];
    website = json['website'];
    established = json['established'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['country'] = this.country;
    data['logo'] = this.logo;
    data['slogan'] = this.slogan;
    data['head_quaters'] = this.headQuaters;
    data['website'] = this.website;
    data['established'] = this.established;
    return data;
  }
}