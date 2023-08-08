class AddressMutation {
  static const String createOrUpdateAddress = '''
  mutation CreateOrUpdateAddress(
 \$addressId: Int
     \$userId: Int
     \$name: String
     \$receiver: String
     \$phone: String
     \$zipCode: String
     \$address: String
     \$detailAddress: String 
     \$default: Boolean
     ) {
    createOrUpdateAddress(
      addressId: \$addressId
      addressName: \$name
      userId: \$userId
      receiver: \$receiver
      phone: \$phone
      zipCode: \$zipCode
      address: \$address
      detailAddress: \$detailAddress
      default: \$default
     ) {
      success
    }
  }
 ''';
}
