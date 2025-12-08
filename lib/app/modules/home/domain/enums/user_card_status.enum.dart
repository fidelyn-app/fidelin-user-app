// ignore_for_file: constant_identifier_names

enum UserCardStatus {
  ACTIVE('ACTIVE'),
  FATURATED('FATURATED'),
  DELETED('DELETED'),
  EXPIRED('EXPIRED');

  final String value;
  const UserCardStatus(this.value);

  @override
  String toString() {
    switch (this) {
      case UserCardStatus.ACTIVE:
        return 'Ativo';
      case UserCardStatus.FATURATED:
        return 'Faturado';
      case UserCardStatus.DELETED:
        return 'Deletado';
      case UserCardStatus.EXPIRED:
        return 'Expirado';
    }
  }

  static String toValue(UserCardStatus status) {
    return status.value;
  }

  static UserCardStatus fromString(String value) {
    return UserCardStatus.values.firstWhere(
      (e) => e.value == value,
      orElse: () => UserCardStatus.ACTIVE,
    );
  }
}
