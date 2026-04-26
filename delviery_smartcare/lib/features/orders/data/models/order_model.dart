class OrderModel {
  final String id;
  final String title;
  final String sourceAddress;
  final String destinationAddress;
  final String distance;
  final String eta;
  final String earning;
  final bool isPaid;

  OrderModel({
    required this.id,
    required this.title,
    required this.sourceAddress,
    required this.destinationAddress,
    required this.distance,
    required this.eta,
    required this.earning,
    required this.isPaid,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] as String,
      title: json['title'] as String,
      sourceAddress: json['sourceAddress'] as String,
      destinationAddress: json['destinationAddress'] as String,
      distance: json['distance'] as String,
      eta: json['eta'] as String,
      earning: json['earning'] as String,
      isPaid: json['isPaid'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'sourceAddress': sourceAddress,
      'destinationAddress': destinationAddress,
      'distance': distance,
      'eta': eta,
      'earning': earning,
      'isPaid': isPaid,
    };
  }
}
