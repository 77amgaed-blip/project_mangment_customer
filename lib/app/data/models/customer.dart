class Customer {
  final int id;
  final String name;
  final String phone;

  const Customer({
    required this.id,
    required this.name,
    required this.phone,
  });

  Customer copyWith({
    int? id,
    String? name,
    String? phone,
  }) {
    return Customer(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
    );
  }
}

