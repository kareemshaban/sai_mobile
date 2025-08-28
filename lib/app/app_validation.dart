import 'package:new_sai/presentation/resources/string_manger.dart';

class AppValidation {
  static bool isEmail(String? value) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value!);
  }

  static bool isValidUrl(String url) {
    const urlPattern = r'^(https?:\/\/)?' // protocol (optional)
        r'([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}' // domain
        r'(\/[^\s]*)?$'; // path (optional)
    final result = RegExp(urlPattern).hasMatch(url);
    return result;
  }

  static String? validateEmpty(String? value) {
    if (value!.trim().isEmpty) {
      return AppStrings.emptyError;
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value!.isEmpty) {
      return AppStrings.emptyError;
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return AppStrings.emptyError;
    }

    if (!isEmail(value)) {
      return AppStrings.emailError;
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return AppStrings.emptyError;
    }
    if (value.length < 8) {
      return AppStrings.passwordError;
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, String password) {
    if (value!.isEmpty) {
      return AppStrings.emptyError;
    }
    if (value.length < 8) {
      return AppStrings.passwordError;
    }
    if (value != password) {
      return AppStrings.confirmPasswordError;
    }
    return null;
  }

  static String? validateMembershipFee(String? value) {
    final RegExp valueRangeRegex = RegExp(r'^(?:0|[1-9]\d?|[1-4]\d{2}|500)$');

    if (value == null || value.isEmpty) {
      return AppStrings.emptyError;
    }
    if (!valueRangeRegex.hasMatch(value)) {
      return AppStrings.membershipFeeError;
    }
    return null;
  }

  static String? validateRedeemes(String? value, num total) {
    final RegExp valueRangeRegex = RegExp(r'^(?:[5-9]\d{2,}|\d{4,})$');

    if (value == null || value.isEmpty) {
      return AppStrings.emptyError;
    }
    if (!valueRangeRegex.hasMatch(value)) {
      return AppStrings.validateRedeemes;
    }
    if (num.parse(value) < 500) {
      return AppStrings.validateRedeemes;
    }
    if (num.parse(value) > total) {
      return AppStrings.youHaveExceededYourWithdrawalBalance;
    }
    return null;
  }

  static String? validateRoomLock(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.emptyError;
    }
    if (value.length != 4) {
      return AppStrings.lockRoomError;
    }
    return null;
  }

  static String? validateLink(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.emptyError;
    }
    if (!isValidUrl(value)) {
      return AppStrings.linkError;
    }
    return null;
  }
}
