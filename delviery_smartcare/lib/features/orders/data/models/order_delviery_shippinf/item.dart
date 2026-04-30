class Item {
	String? medicineName;
	int? quantity;
	double? unitPrice;
	double? subTotal;

	Item({this.medicineName, this.quantity, this.unitPrice, this.subTotal});

	factory Item.fromJson(Map<String, dynamic> json) => Item(
				medicineName: json['medicineName'] as String?,
				quantity: json['quantity'] as int?,
				unitPrice: (json['unitPrice'] as num?)?.toDouble(),
				subTotal: (json['subTotal'] as num?)?.toDouble(),
			);

	Map<String, dynamic> toJson() => {
				'medicineName': medicineName,
				'quantity': quantity,
				'unitPrice': unitPrice,
				'subTotal': subTotal,
			};
}
