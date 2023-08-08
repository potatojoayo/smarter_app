class ChangePasswordMutation {
  static const String changePassword = '''
  mutation ChangePassword(
      \$currentPassword: String
      \$changingPassword: String
     ) {
    changePassword(
      currentPassword: \$currentPassword
      changingPassword: \$changingPassword
     ) {
      success
      invalid
    }
  }
 ''';
}
