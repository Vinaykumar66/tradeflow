enum PermissionAction { view, create, edit, delete }

abstract class AppScreenKeys {
  static const String dashboard = 'dashboard';
  static const String inventory = 'inventory';
  static const String customers = 'customers';
  static const String vendors = 'vendors';
  static const String invoices = 'invoices';
  static const String payments = 'payments';
  static const String reports = 'reports';
  static const String admin = 'admin';
  static const String catalog = 'catalog';
  static const String purchases = 'purchases';
}

abstract class AppFieldKeys {
  static const String productCostPrice = 'product_cost_price';
  static const String productTaxRate = 'product_tax_rate';

  static const String customerCreditLimit = 'customer_credit_limit';
  static const String customerOutstanding = 'customer_outstanding';
  static const String invoiceDiscount = 'invoice_discount';
  static const String invoiceDelete = 'invoice_delete';
  static const String paymentDelete = 'payment_delete';
}
