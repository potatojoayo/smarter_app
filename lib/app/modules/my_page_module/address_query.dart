class AddressQuery {
  static const String myAddresses = '''
  query MyAddresses {
    myAddresses {
      id
      name
      receiver
      phone
      zipCode
      address
      detailAddress
      default
    }
  }
 ''';
}
