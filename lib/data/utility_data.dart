import '../models/utility_model.dart';

class UtilityData {
  static const List<UtilityModel> utilities = [
    UtilityModel(
      id: 1,
      userId: 1,
      categoryName: 'Food',
      type: 'EXPENSE',
    ),
    UtilityModel(
      id: 2,
      userId: 1,
      categoryName: 'Salary',
      type: 'INCOME',
    ),
    UtilityModel(
      id: 3,
      userId: 1,
      categoryName: 'Fuel',
      type: 'EXPENSE',
    ),
    UtilityModel(
      id: 4,
      userId: 1,
      categoryName: 'Freelance',
      type: 'EXPENSE',
    ),
    UtilityModel(
      id: 5,
      userId: 1,
      categoryName: 'Shopping',
      type: 'EXPENSE',
    ),
    UtilityModel(
      id: 6,
      userId: 1,
      categoryName: 'Rent',
      type: 'EXPENSE',
    ),
    UtilityModel(
      id: 7,
      userId: 1,
      categoryName: 'Freelance',
      type: 'INCOME',
    ),
  ];

  static String getUtilityName(int? utilityId) {
    if (utilityId == null) return '';
    final utility = utilities.firstWhere(
      (u) => u.id == utilityId,
      orElse: () => UtilityModel(
        id: -1,
        userId: 1,
        categoryName: 'Unknown',
        type: '',
      ),
    );
    return utility.categoryName;
  }

  static String getUtilityType(int? utilityId) {
    if (utilityId == null) return '';
    final utility = utilities.firstWhere(
      (u) => u.id == utilityId,
      orElse: () => UtilityModel(
        id: -1,
        userId: 1,
        categoryName: 'Unknown',
        type: '',
      ),
    );
    return utility.type;
  }
}