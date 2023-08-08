class AuthQuery {
  static const String me = '''
    query Me{
      me{
        id
        identification
        name
        coupons{
          id
        }
        phone
        profileImage
        gym {
          id
          name
          smarterMoney
          address
          detailAddress
          isDeductEnabled
          membership{
            percentage 
          }
          zipCode
          email
          businessRegistrationNumber
          businessRegistrationCertificate
          refundBankName
          refundBankOwnerName
          refundBankAccountNo
          classPaymentBankName
          classPaymentBankOwnerName
          classPaymentBankAccountNo
        }
      }
    }
  ''';
}
