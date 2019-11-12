class FlightOffer {
  final double price;
  final String airline;
  final String airlineOp;
  final String airlineName;
  final String cacheName;
  final List trips;
  final int id;

  FlightOffer._(
      {this.price,
      this.airline,
      this.airlineOp,
      this.airlineName,
      this.cacheName,
      this.trips,
      this.id});

  factory FlightOffer.fromJson(Map<String, dynamic> json) {
    return new FlightOffer._(

        price: json['price'].toDouble(),
        airline: json['airline'],
        airlineOp: json['airlineOp'],
        airlineName: json['airlineName'],
        cacheName: json['cacheName'],
        trips: json['trips'],
        id: json['SequenceNumber']);
  }

  Map asMap(){
    Map map = Map();
    map['price'] = price;
    map['airline'] = airline;
    map['airlineOp'] = airlineOp;
    map['airlineName'] = airlineName;
    map['cacheName'] = cacheName;
    map['trips'] = trips;
    map['SequenceNumber'] = id;
    return map;
  }
}
