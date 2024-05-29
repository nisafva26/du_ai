import 'package:flutter/material.dart';

class MobilePlan {
  final String name;
  final String description;
  final String category;
  final int price;
  final int dataLimitGB; // Data limit in GB
  final bool isUnlimited; // Whether the plan is unlimited

  MobilePlan({
    required this.name,
    required this.description,
    required this.category,
    required this.price,
    required this.dataLimitGB,
    required this.isUnlimited,
  });
}

class MobilePlanProvider with ChangeNotifier {
  List<MobilePlan> _allPlans = [
    MobilePlan(
      name: 'Power Plan 500 Data',
      description: '',
      category: 'Family',
      price: 500,
      dataLimitGB: 13,
      isUnlimited: true,
    ),
    MobilePlan(
      name: 'Power Plan 400 Data',
      description: '',
      category: 'Single',
      price: 400,
      dataLimitGB: 10,
      isUnlimited: false,
    ),
    MobilePlan(
      name: 'Power Plan 300 Data',
      description: '',
      category: 'Family',
      price: 300,
      dataLimitGB: 50,
      isUnlimited: false,
    ),
    MobilePlan(
      name: 'Power Plan 250 Data',
      description: '',
      category: 'Single',
      price: 250,
      dataLimitGB: 25,
      isUnlimited: true,
    ),
    MobilePlan(
      name: 'Power plan 200',
      description: '',
      category: 'Family',
      price: 200,
      dataLimitGB: 20,
      isUnlimited: false,
    ),
    
    // Add more plans as needed
  ];

  List<MobilePlan> _availablePlans = [];
  List<MobilePlan> _myPlans = [];

  List<MobilePlan> get availablePlans => _availablePlans.isEmpty ? _allPlans : _availablePlans;
  List<MobilePlan> get myPlans => _myPlans;

  void showPlansUnder(String category, int price) {
    _availablePlans = _allPlans.where((plan) {
      return plan.price <= price && plan.category.toLowerCase() == category.toLowerCase();
    }).toList();
    notifyListeners();
  }

  void purchasePlan() {
    if (_availablePlans.isNotEmpty) {
      _myPlans.add(_availablePlans.first);
      _availablePlans.removeAt(0);
      notifyListeners();
    }
  }

   void showPlansUnderPrice(int price) {
    _availablePlans = _allPlans.where((plan) {
      return plan.price <= price;
    }).toList();
    notifyListeners();
  }

  void minimumData(int data) {
    _availablePlans = _allPlans.where((plan) {
      return plan.dataLimitGB >= data;
    }).toList();
    notifyListeners();
  }

  void showAllPlans(){
    _availablePlans = _allPlans;
    notifyListeners();
  }

  void showCategoryPlans(String category) {
    _availablePlans = _allPlans.where((plan) {
      return  plan.category.toLowerCase() == category.toLowerCase();
    }).toList();
    notifyListeners();
  }
}
