class ClaimMutation {
  static const String requestClaim = """
    mutation RequestClaim(\$orderDetailId: Int, \$quantity: Int, \$reason: String, \$type: String){
      requestClaim(orderDetailId: \$orderDetailId, quantity: \$quantity, reason: \$reason, type: \$type){
        success
      }
    }
  """;
}
