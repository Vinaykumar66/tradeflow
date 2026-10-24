class FaqEntry {
  final String id;
  final String question;
  final String answer;
  final String category;
  final List<String> keywords;
  const FaqEntry({
    required this.id,
    required this.question,
    required this.answer,
    required this.category,
    required this.keywords,
  });
}

const kFaqSeedData = [
  FaqEntry(
      id: 'create-invoice',
      question: 'How do I create an invoice?',
      answer: 'Go to Invoices, tap the + button, select "Tax Invoice" from '
          'the document type dropdown, add a customer and items, then tap Save.',
      category: 'Invoicing',
      keywords: ['invoice', 'create', 'new', 'bill', 'billing']),
  FaqEntry(
      id: 'doc-types',
      question:
          'What is the difference between an invoice, quotation and estimate?',
      answer: 'A Tax Invoice is a real taxable sale. Quotations and Estimates '
          'are pre-sale documents with no tax obligation. You can convert a '
          'Quotation or Estimate into a real Invoice later from its detail screen.',
      category: 'Invoicing',
      keywords: ['quotation', 'estimate', 'proforma', 'convert', 'difference']),
  FaqEntry(
      id: 'gst-split',
      question:
          'Why does my invoice show CGST and SGST instead of one tax line?',
      answer: 'For India, tax automatically splits into CGST+SGST when the '
          'customer is in the same state as your business, or a single IGST '
          'line when they are in a different state. This happens automatically '
          'based on your business state and the customer\'s state.',
      category: 'Tax',
      keywords: ['cgst', 'sgst', 'igst', 'gst', 'tax', 'split']),
  FaqEntry(
      id: 'add-product',
      question: 'How do I add a product to my catalog?',
      answer: 'Go to Catalog, tap the + button, fill in the name, price and '
          'stock quantity, then tap Save.',
      category: 'Catalog',
      keywords: ['product', 'add', 'catalog', 'item']),
  FaqEntry(
      id: 'hsn-code',
      question: 'What is the HSN/SAC code field for?',
      answer: 'HSN codes classify goods and SAC codes classify services for '
          'GST purposes. This field only appears for Indian businesses and is '
          'used on tax invoices and in GST compliance reports.',
      category: 'Tax',
      keywords: ['hsn', 'sac', 'code', 'commodity']),
  FaqEntry(
      id: 'printer-types',
      question: 'Which printer types does TradeFlow support?',
      answer: 'Three: Laser/Inkjet (full A4 PDF), Thermal (narrow receipt '
          'roll, mobile only), and Dot Matrix (continuous stationery). Set '
          'your default in Settings under Printing.',
      category: 'Printing',
      keywords: ['printer', 'print', 'laser', 'thermal', 'dot matrix']),
  FaqEntry(
      id: 'upi-qr',
      question: 'How does the UPI payment QR work?',
      answer: 'Open an unpaid invoice and tap Payment QR. The customer scans '
          'it with any UPI app to pay the balance due directly to your bank '
          'account. After they pay, tap Record Payment to update the invoice — '
          'the QR itself does not update automatically.',
      category: 'Payments',
      keywords: ['upi', 'qr', 'payment', 'scan']),
  FaqEntry(
      id: 'switch-business',
      question: 'How do I switch between businesses?',
      answer: 'Tap your business logo at the top of the sidebar to see every '
          'business you belong to and switch between them.',
      category: 'Account',
      keywords: ['switch', 'business', 'multiple', 'change']),
  FaqEntry(
      id: 'invite-team',
      question: 'How do I add a team member?',
      answer: 'Go to Admin Settings > Team Members, tap Invite, enter their '
          'email and role. They will receive a code by email to join.',
      category: 'Account',
      keywords: ['invite', 'team', 'member', 'staff', 'add user']),
  FaqEntry(
      id: 'backup-data',
      question: 'How do I back up or export my data?',
      answer: 'Go to Business Settings > Data > Export All Data to download '
          'a complete backup of your customers, products, invoices and '
          'purchase bills as a file you can keep.',
      category: 'Account',
      keywords: ['backup', 'export', 'data', 'download']),
  FaqEntry(
      id: 'purchase-bill',
      question: 'How do I record a purchase from a vendor?',
      answer: 'Go to Purchases, tap New Bill, select the vendor, enter the '
          'bill number exactly as printed on their invoice, and add items. '
          'Stock increases automatically for each item received.',
      category: 'Purchases',
      keywords: ['purchase', 'vendor', 'supplier', 'buy', 'stock', 'bill']),
  FaqEntry(
      id: 'credit-note',
      question: 'A customer returned an item — what do I do?',
      answer: 'Open the original invoice and tap the return icon to issue a '
          'Credit Note. Select the quantity being returned — stock is '
          'restored automatically if the reason is "Sales return."',
      category: 'Invoicing',
      keywords: ['return', 'credit note', 'refund', 'returned']),
  FaqEntry(
      id: 'hi',
      question: 'Hi',
      answer: 'Hello, how can I help you',
      category: 'Invoicing',
      keywords: ['hi', 'Hi', 'Hello', 'returned']),
];
