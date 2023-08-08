class CouponQuery {
  static const String myCoupons = """
  query MyCoupons{
      myCoupons{
        id
        couponMaster{
          name
        }
        price
        startOfUse
        endOfUse
      }
  }
  """;
}
