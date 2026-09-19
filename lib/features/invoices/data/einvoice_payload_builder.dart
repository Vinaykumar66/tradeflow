import '../../../shared/models/business.dart';
import '../../../shared/models/customer.dart';
import '../../../shared/models/invoice.dart';

class EInvoicePayloadBuilder {
  static Map<String, dynamic> build({
    required Invoice invoice,
    required Business business,
    Customer? customer,
  }) {
    return {
      'Version': '1.1',
      'TranDtls': {
        'TaxSch': 'GST',
        'SupTyp': customer?.gstin != null ? 'B2B' : 'B2C',
      },
      'DocDtls': {
        'Typ': 'INV',
        'No': invoice.invoiceNumber,
        'Dt': _fmtDate(invoice.issueDate),
      },
      'SellerDtls': {
        'Gstin': business.gstin,
        'LglNm': business.name,
        'Addr1': business.address,
        'Loc': business.city,
        'Pin': business.pincode,
        'Stcd': business.state,
      },
      'BuyerDtls': {
        'Gstin': customer?.gstin,
        'LglNm': customer?.name,
        'Pos': invoice.placeOfSupply,
        'Addr1': customer?.address,
      },
      'ItemList': invoice.items
          .map((item) => {
                'PrdDesc': item.name,
                'HsnCd': item.hsnSacCode,
                'Qty': item.quantity,
                'Unit': item.unit,
                'UnitPrice': item.unitPrice / 100,
                'TotAmt': item.lineTotal / 100,
                'AssAmt': (item.lineTotal - item.taxAmount) / 100,
                'GstRt': item.taxRate,
                'CgstAmt': item.cgstAmount / 100,
                'SgstAmt': item.sgstAmount / 100,
                'IgstAmt': item.igstAmount / 100,
                'TotalItemVal': item.lineTotal / 100,
              })
          .toList(),
      'ValDtls': {
        'AssVal': invoice.subtotal / 100,
        'CgstVal': invoice.cgstTotal / 100,
        'SgstVal': invoice.sgstTotal / 100,
        'IgstVal': invoice.igstTotal / 100,
        'TotInvVal': invoice.total / 100,
      },
    };
  }

  static String _fmtDate(DateTime d) => '${d.day.toString().padLeft(2, "0")}/'
      '${d.month.toString().padLeft(2, "0")}/${d.year}';
}
