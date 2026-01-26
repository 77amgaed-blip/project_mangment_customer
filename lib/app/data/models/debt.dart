class Debt {
  final int id;
  final int customerId;
  final int amount;
  final DateTime dueDate;
  /// "active" | "late" | "paid"
  final String status;

  const Debt({
    required this.id,
    required this.customerId,
    required this.amount,
    required this.dueDate,
    required this.status,
  });

  Debt copyWith({
    int? id,
    int? customerId,
    int? amount,
    DateTime? dueDate,
    String? status,
  }) {
    return Debt(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      amount: amount ?? this.amount,
      dueDate: dueDate ?? this.dueDate,
      status: status ?? this.status,
    );
  }
}

