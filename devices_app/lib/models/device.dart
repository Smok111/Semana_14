class Device {
  final String id;
  final String name;
  final String brand;
  final double price;

  Device({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
  });

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      brand: json['brand'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'brand': brand,
      'price': price,
    };
  }
}
