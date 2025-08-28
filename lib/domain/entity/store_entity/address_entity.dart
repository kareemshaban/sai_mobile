import 'package:new_sai/domain/entity/app_entity/country_entity.dart';

class AddressEntity {
  int id;
  String fullName;
  CountryEntity country;
  String street;
  String streetMark;
  String phone;
  String optionalPhone;
  bool isDefault;

  AddressEntity({
    required this.id,
    required this.country,
    required this.street,
    required this.fullName,
    required this.phone,
    required this.isDefault,
    required this.optionalPhone,
    required this.streetMark,
  });

  static final fakeData = AddressEntity(
    id: 0,
    country: CountryEntity(id: 0, name: "name", flag: "flag", isFamous: 1),
    street: "street",
    fullName: "fullName",
    phone: "phone",
    isDefault: false,
    optionalPhone: "optionalPhone",
    streetMark: "streetMark",
  );
}
