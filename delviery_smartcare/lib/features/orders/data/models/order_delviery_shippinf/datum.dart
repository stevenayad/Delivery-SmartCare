import 'item.dart';

class OrderDelvieryShippingDatum {
	String? orderId;
	String? status;
	DateTime? createdAt;
	String? clientName;
	String? clientPhone;
	String? deliveryAddressLine;
	String? deliveryAddressLabel;
	String? deliveryAddressAdditionalInfo;
	double? clientLatitude;
	double? clientLongitude;
	String? storeName;
	String? storeAddress;
	String? storePhone;
	double? storeLatitude;
	double? storeLongitude;
	double? distanceKm;
	double? medicinePrice;
	double? deliveryFee;
	double? totalPrice;
	List<Item>? items;

	OrderDelvieryShippingDatum({
		this.orderId, 
		this.status, 
		this.createdAt, 
		this.clientName, 
		this.clientPhone, 
		this.deliveryAddressLine, 
		this.deliveryAddressLabel, 
		this.deliveryAddressAdditionalInfo, 
		this.clientLatitude, 
		this.clientLongitude, 
		this.storeName, 
		this.storeAddress, 
		this.storePhone, 
		this.storeLatitude, 
		this.storeLongitude, 
		this.distanceKm, 
		this.medicinePrice, 
		this.deliveryFee, 
		this.totalPrice, 
		this.items, 
	});

	factory OrderDelvieryShippingDatum.fromJson(Map<String, dynamic> json) => OrderDelvieryShippingDatum(
				orderId: json['orderId'] as String?,
				status: json['status'] as String?,
				createdAt: json['createdAt'] == null
						? null
						: DateTime.parse(json['createdAt'] as String),
				clientName: json['clientName'] as String?,
				clientPhone: json['clientPhone'] as String?,
				deliveryAddressLine: json['deliveryAddressLine'] as String?,
				deliveryAddressLabel: json['deliveryAddressLabel'] as String?,
				deliveryAddressAdditionalInfo: json['deliveryAddressAdditionalInfo'] as String?,
				clientLatitude: (json['clientLatitude'] as num?)?.toDouble(),
				clientLongitude: (json['clientLongitude'] as num?)?.toDouble(),
				storeName: json['storeName'] as String?,
				storeAddress: json['storeAddress'] as String?,
				storePhone: json['storePhone'] as String?,
				storeLatitude: (json['storeLatitude'] as num?)?.toDouble(),
				storeLongitude: (json['storeLongitude'] as num?)?.toDouble(),
				distanceKm: (json['distanceKm'] as num?)?.toDouble(),
				medicinePrice: (json['medicinePrice'] as num?)?.toDouble(),
				deliveryFee: (json['deliveryFee'] as num?)?.toDouble(),
				totalPrice: (json['totalPrice'] as num?)?.toDouble(),
				items: (json['items'] as List<dynamic>?)
						?.map((e) => Item.fromJson(e as Map<String, dynamic>))
						.toList(),
			);

	Map<String, dynamic> toJson() => {
				'orderId': orderId,
				'status': status,
				'createdAt': createdAt?.toIso8601String(),
				'clientName': clientName,
				'clientPhone': clientPhone,
				'deliveryAddressLine': deliveryAddressLine,
				'deliveryAddressLabel': deliveryAddressLabel,
				'deliveryAddressAdditionalInfo': deliveryAddressAdditionalInfo,
				'clientLatitude': clientLatitude,
				'clientLongitude': clientLongitude,
				'storeName': storeName,
				'storeAddress': storeAddress,
				'storePhone': storePhone,
				'storeLatitude': storeLatitude,
				'storeLongitude': storeLongitude,
				'distanceKm': distanceKm,
				'medicinePrice': medicinePrice,
				'deliveryFee': deliveryFee,
				'totalPrice': totalPrice,
				'items': items?.map((e) => e.toJson()).toList(),
			};
}
