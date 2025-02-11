import 'package:equatable/equatable.dart';

class TempUser extends Equatable {
  const TempUser({
    required this.email,
    required this.iban,
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.city,
    required this.postalCode,
    required this.country,
    required this.password,
    required this.amountLimit,
    required this.appLanguage,
    required this.timeZoneId,
    this.guid,
  });

  factory TempUser.empty() => const TempUser(
        email: '',
        iban: '',
        phoneNumber: '',
        firstName: '',
        lastName: '',
        address: '',
        city: '',
        postalCode: '',
        country: '',
        password: '',
        amountLimit: 0,
        appLanguage: '',
        timeZoneId: '',
      );

  factory TempUser.prefilled({
    required String email,
    String password = r'R4nd0mP@s$w0rd123',
    String country = 'NL',
    String iban = 'FB66GIVT12345678',
    String phoneNumber = '060000000',
    String firstName = 'John',
    String lastName = 'Doe',
    String address = 'Foobarstraat 5',
    String city = 'Foobar',
    String postalCode = 'B3 1RD',
    String appLanguage = 'en',
    String timeZoneId = 'Europe/Amsterdam',
    int amountLimit = 499,
  }) =>
      TempUser(
        email: email,
        iban: iban,
        phoneNumber: phoneNumber,
        firstName: firstName,
        lastName: lastName,
        address: address,
        city: city,
        postalCode: postalCode,
        country: country,
        password: password,
        appLanguage: appLanguage,
        amountLimit: amountLimit,
        timeZoneId: timeZoneId,
      );

  factory TempUser.fromJson(Map<String, dynamic> json) => TempUser(
        guid: json['GUID'] as String?,
        email: json['Email'] as String,
        iban: json['IBAN'] as String,
        phoneNumber: json['PhoneNumber'] as String,
        firstName: json['FirstName'] as String,
        lastName: json['LastName'] as String,
        address: json['Address'] as String,
        city: json['City'] as String,
        postalCode: json['PostalCode'] as String,
        country: json['Country'] as String,
        password: json['Password'] as String,
        amountLimit: json['AmountLimit'] as int,
        appLanguage: json['AppLanguage'] as String,
        timeZoneId: json['TimeZoneId'] as String,
      );

  final String? guid;
  final String email;
  final String iban;
  final String phoneNumber;
  final String firstName;
  final String lastName;
  final String address;
  final String city;
  final String postalCode;
  final String country;
  final String password;
  final int amountLimit;
  final String appLanguage;
  final String timeZoneId;

  TempUser copyWith({
    String? guid,
    String? email,
    String? iban,
    String? phoneNumber,
    String? firstName,
    String? lastName,
    String? address,
    String? city,
    String? postalCode,
    String? country,
    String? password,
    int? amountLimit,
    String? appLanguage,
    String? timeZoneId,
  }) =>
      TempUser(
        guid: guid ?? this.guid,
        email: email ?? this.email,
        iban: iban ?? this.iban,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        address: address ?? this.address,
        city: city ?? this.city,
        postalCode: postalCode ?? this.postalCode,
        country: country ?? this.country,
        password: password ?? this.password,
        amountLimit: amountLimit ?? this.amountLimit,
        appLanguage: appLanguage ?? this.appLanguage,
        timeZoneId: timeZoneId ?? this.timeZoneId,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'Email': email,
        'IBAN': iban,
        'PhoneNumber': phoneNumber,
        'FirstName': firstName,
        'LastName': lastName,
        'Address': address,
        'City': city,
        'PostalCode': postalCode,
        'Country': country,
        'Password': password,
        'AmountLimit': amountLimit,
        'AppLanguage': appLanguage,
        'TimeZoneId': timeZoneId,
      };

  @override
  List<Object?> get props => [
        guid,
        email,
        iban,
        phoneNumber,
        firstName,
        lastName,
        address,
        city,
        postalCode,
        country,
        password,
        amountLimit,
        appLanguage,
        timeZoneId,
      ];
}
