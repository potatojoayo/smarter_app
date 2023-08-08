class AuthMutation {
  static const String checkIdPhone = """
    mutation CheckIdPhone(\$identification: String \$phone: String){
      checkIdPhone(identification: \$identification phone: \$phone){
        success
      }
    }
  """;

  static const String removeFcmToken = """
    mutation RemoveFcmToken(\$fcmToken: String){
      removeFcmToken(fcmToken: \$fcmToken){
        success
      }
    }
  """;
  static const String setFcmToken = """
    mutation SetFcmToken(\$fcmToken: String, \$identification:String){
      setFcmToken(fcmToken: \$fcmToken, identification: \$identification){
        success
      }
    }
  """;
  static const String withdraw = """
    mutation Withdraw{
      withdraw{
        success
      }
    }
  """;
  static const String tokenAuth = """
    mutation TokenAuth(\$identification: String!, \$password: String!, \$fcmToken: String){
      tokenAuth(identification:\$identification, password:\$password, fcmToken: \$fcmToken){
          token
          refreshToken
          refreshExpiresIn
          isActive
          user {
            id
            identification
            name
            phone
            gym {
              name
              address
              detailAddress
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
          isParticipatedEvent
          }
      }
    }
  """;

  static const String verifyToken = """
    mutation VerifyToken(\$token: String!){
      verifyToken(token: \$token){
        payload
        isActive
        user {
          id
          identification
          name
          phone
          isParticipatedEvent
          gym {
            name
            address
            detailAddress
            zipCode
            email
            businessRegistrationNumber
            isDeductEnabled
            businessRegistrationCertificate
            refundBankName
            refundBankOwnerName
            refundBankAccountNo
            classPaymentBankName
            classPaymentBankOwnerName
            classPaymentBankAccountNo
          }
          isParticipatedEvent
        }
      }
    }
  """;

  static const String checkIsActive = """
    mutation CheckIsActive(\$identification: String){
      checkIsActive(identification: \$identification){
        isActive
        isGym
      }
    }
  """;

  static const String refreshToken = """
    mutation Refresh(\$refreshToken: String!) {
      refreshToken(refreshToken: \$refreshToken){
        token
        refreshToken
        refreshExpiresIn
      }
    }
    
  """;

  static const String createOrUpdateGym = """
      mutation RegisterUser(\$gym: GymInputType!, \$gymUser: UserInputType!, \$agencyIdentification:String, \$isActive: Boolean = false \$event: Boolean = false \$referralCode: String){
        createOrUpdateGym(gym: \$gym, gymUser: \$gymUser, isActive: \$isActive, agencyIdentification: \$agencyIdentification event: \$event referralCode: \$referralCode){
          success
          agencyNotFound
          message
          duplicatedIdentification
          duplicatedPhone
        }
      }
  """;

  static const String sendCode = """
    mutation sendCode(\$phoneNumber: String!, \$identification:String!){
      sendCode(phoneNumber: \$phoneNumber, identification:\$identification){
        success
        message
      }  
    }
  """;

  static const String checkCode = """
    mutation CheckCode(\$code:Int!, \$phoneNumber:String!, \$identification:String!){
      checkCode(code:\$code, phoneNumber:\$phoneNumber, identification:\$identification){
        success
        userId
        message
      }
    }
  """;

  static const String setPassword = """
    mutation SetPassword(\$userId:Int!, \$newPassword:String!, \$confirmPassword:String!){
      setPassword(userId:\$userId, newPassword:\$newPassword, confirmPassword:\$confirmPassword){
        success
        message
      }       
    }
  """;
}
