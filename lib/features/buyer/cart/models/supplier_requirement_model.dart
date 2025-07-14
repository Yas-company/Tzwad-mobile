import 'package:faker/faker.dart';

class SupplierRequirementModel {
  int? supplierId;
  String? supplierName;
  int? requiredAmount;
  int? currentTotal;
  int? residualAmount;

  SupplierRequirementModel({
    this.supplierId,
    this.supplierName,
    this.requiredAmount,
    this.currentTotal,
    this.residualAmount,
  });

  SupplierRequirementModel.fromJson(Map<String, dynamic> json) {
    supplierId = json['supplier_id'];
    supplierName = json['supplier_name'];
    requiredAmount = json['required_amount'];
    currentTotal = json['current_total'];
    residualAmount = json['residual_amount'];
  }

  static List<SupplierRequirementModel> fromJsonList(List<dynamic> jsonList) {
    return (jsonList).map((item) => SupplierRequirementModel.fromJson(item)).toList();
  }

  factory SupplierRequirementModel.fake({int id = 0}) {
    final faker = Faker();
    return SupplierRequirementModel(
      supplierId: id,
      supplierName: faker.company.name(),
      requiredAmount: faker.randomGenerator.integer(10000, min: 1000),
      currentTotal: faker.randomGenerator.integer(5000, min: 100),
      residualAmount: faker.randomGenerator.integer(5000, min: 100),
    );
  }

  static List<SupplierRequirementModel> generateFakeList({int count = 10}) {
    return List.generate(
      count,
          (index) => SupplierRequirementModel.fake(id: index),
    );
  }
}
