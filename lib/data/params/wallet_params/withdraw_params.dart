import 'package:json_annotation/json_annotation.dart';
part 'withdraw_params.g.dart';

enum TransferType { paypal, bank }

@JsonSerializable()
class WithdrawParams {
  @JsonKey(name: "name", includeIfNull: false)
  final String userName;
  @JsonKey(name: "iban", includeIfNull: false)
  final String? ibanBankNumber;
  @JsonKey(name: "bank_name", includeIfNull: false)
  final String? bankName;
  @JsonKey(name: "redeem_value", includeIfNull: false)
  final String withdrawValue;
  @JsonKey(name: "county", includeIfNull: false)
  final String countyName;
  @JsonKey(name: "transfer_type", includeIfNull: false)
  final TransferType transferType;
  @JsonKey(name: "paybal_id", includeIfNull: false)
  final String? payPalId;
  @JsonKey(name: "paybal_repeat_id", includeIfNull: false)
  final String? payPalRepeat;

  WithdrawParams(
      {required this.userName,
      required this.transferType,
      this.payPalId,
      this.payPalRepeat,
      this.ibanBankNumber,
      this.bankName,
      required this.withdrawValue,
      required this.countyName});
  factory WithdrawParams.fromJson(Map<String, dynamic> json) =>
      _$WithdrawParamsFromJson(json);
  Map<String, dynamic> toJson() => _$WithdrawParamsToJson(this);
}
