enum ListingStatusDataType {
  listed('listed'),
  pendingPayment('pendingPayment'),
  paid('paid'),
  paymentReceived('paymentReceived'),
  pendingSellerConfirmation('pendingSellerConfirmation'),
  shipped('shipped'),
  notifyChatP2P('notifyChatP2P'),
  feedbackProvided('feedbackProvided'),
  removed('removed'),
  editing('editing'),
  received('received');

  final String textValue;

  const ListingStatusDataType(this.textValue);
}
