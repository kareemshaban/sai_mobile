enum OrderState {
  newOrder,
  underPreparation,
  readyForDispatch,
  inDelivery,
  finished,
  canceled,
}

extension OrderStatusMapper on String {
  OrderState toOrderState() {
    switch (this) {
      case 'new_order':
        return OrderState.newOrder;
      case 'under_preparation':
        return OrderState.underPreparation;
      case 'ready_for_dispatch':
        return OrderState.readyForDispatch;
      case 'in_delivery':
        return OrderState.inDelivery;
      case 'finished':
        return OrderState.finished;
      case 'canceled':
        return OrderState.canceled;
      default:
        return OrderState.canceled;
    }
  }
}

enum PrivacyTermsType {
  privacyPolicy,
  terms,
  support,
}
