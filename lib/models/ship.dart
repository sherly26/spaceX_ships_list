class Ship {
  String shipId;
  String shipName;
  bool shipStatus;

  Ship({this.shipId, this.shipName, this.shipStatus});

  factory Ship.fromJson(Map<String, dynamic> json) => Ship(shipId: json["ship_id"], shipName: json["ship_name"], shipStatus: json["active"]);

  Map<String, dynamic> toJson() => {
        "ship_id": shipId,
        "ship_name": shipName,
        "active": shipStatus,
      };
}
