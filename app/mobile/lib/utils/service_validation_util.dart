class ValidationPolicy {
  final String error;
  final bool Function(dynamic) rule;
  final List<ValidationPolicy>? connectedPolicies;

  ValidationPolicy(this.error, this.rule, {this.connectedPolicies});

  static ValidationPolicy requiredValidation() =>
      ValidationPolicy("Field should not be null", (value) => value != null);

  static ValidationPolicy stringNotEmptyValidation() => ValidationPolicy(
      "String should not be empty",
      (value) => value is String && (value.isNotEmpty),
      connectedPolicies: [requiredValidation()]);

  static ValidationPolicy passwordValidation() => ValidationPolicy(
      "Password should be at least 6 characters", (value) => value.length >= 6,
      connectedPolicies: [requiredValidation(), stringNotEmptyValidation()]);

  static ValidationPolicy emailValidation() => ValidationPolicy(
      "Email should be valid", (value) => value.contains('@'),
      connectedPolicies: [requiredValidation(), stringNotEmptyValidation()]);

  static ValidationPolicy phoneValidation() => ValidationPolicy(
      "Phone should be valid", (value) => value is String && value.length == 10,
      connectedPolicies: [requiredValidation(), stringNotEmptyValidation()]);

  static ValidationPolicy dateValidation() =>
      ValidationPolicy("Date should be valid", (value) => value is DateTime,
          connectedPolicies: [requiredValidation()]);

  static ValidationPolicy numberNotZeroValidation() => ValidationPolicy(
      "Number should not be zero", (value) => value is num && value != 0,
      connectedPolicies: [requiredValidation()]);

  static ValidationPolicy listNotEmptyValidation() => ValidationPolicy(
      "List should not be empty", (value) => value is List && value.isNotEmpty,
      connectedPolicies: [requiredValidation()]);
}

class ValidationUtil {
  static void validate<T>(T data, ValidationPolicy validation) {
    for (var policy in validation.connectedPolicies ?? []) {
      validate(data, policy);
    }

    if (!validation.rule(data)) {
      throw Exception(
          "${validation.error} error occurred in ${T.toString()} field");
    }
  }
}
