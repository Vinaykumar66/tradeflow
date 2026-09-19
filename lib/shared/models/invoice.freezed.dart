// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'invoice.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Invoice _$InvoiceFromJson(Map<String, dynamic> json) {
  return _Invoice.fromJson(json);
}

/// @nodoc
mixin _$Invoice {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'business_id')
  String get businessId => throw _privateConstructorUsedError;
  @JsonKey(name: 'customer_id')
  String? get customerId => throw _privateConstructorUsedError;
  @JsonKey(name: 'invoice_number')
  String get invoiceNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'document_type')
  String get documentType => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'issue_date')
  DateTime get issueDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'due_date')
  DateTime? get dueDate =>
      throw _privateConstructorUsedError; // Amounts in smallest currency unit
  @JsonKey(name: 'subtotal')
  int get subtotal => throw _privateConstructorUsedError;
  @JsonKey(name: 'discount_amount')
  int get discountAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'tax_amount')
  int get taxAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'cgst_total')
  int get cgstTotal => throw _privateConstructorUsedError;
  @JsonKey(name: 'sgst_total')
  int get sgstTotal => throw _privateConstructorUsedError;
  @JsonKey(name: 'igst_total')
  int get igstTotal => throw _privateConstructorUsedError;
  @JsonKey(name: 'ugst_total')
  int get ugstTotal => throw _privateConstructorUsedError;
  @JsonKey(name: 'total')
  int get total => throw _privateConstructorUsedError;
  @JsonKey(name: 'amount_paid')
  int get amountPaid =>
      throw _privateConstructorUsedError; // Currency snapshot at time of invoice creation
  @JsonKey(name: 'currency_code')
  String get currencyCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'currency_symbol')
  String get currencySymbol => throw _privateConstructorUsedError;
  @JsonKey(name: 'use_lakh_format')
  bool get useLakhFormat => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  String? get terms => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_by')
  String? get createdBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'converted_to_invoice_id')
  String? get convertedToInvoiceId =>
      throw _privateConstructorUsedError; // Populated by join — not stored in invoices table
  @JsonKey(includeFromJson: false, includeToJson: false)
  @JsonKey(name: 'customer_gstin')
  String? get customerGstin => throw _privateConstructorUsedError;
  @JsonKey(name: 'customer_name')
  String? get customerName => throw _privateConstructorUsedError;
  @JsonKey(name: 'place_of_supply')
  String? get placeOfSupply => throw _privateConstructorUsedError;
  @JsonKey(name: 'einvoice_status')
  String get einvoiceStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'irn')
  String? get irn => throw _privateConstructorUsedError;
  @JsonKey(name: 'ack_number')
  String? get ackNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'ack_date')
  DateTime? get ackDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'signed_qr_code')
  String? get signedQrCode => throw _privateConstructorUsedError;
  List<InvoiceItem> get items => throw _privateConstructorUsedError;

  /// Serializes this Invoice to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Invoice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InvoiceCopyWith<Invoice> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvoiceCopyWith<$Res> {
  factory $InvoiceCopyWith(Invoice value, $Res Function(Invoice) then) =
      _$InvoiceCopyWithImpl<$Res, Invoice>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'business_id') String businessId,
      @JsonKey(name: 'customer_id') String? customerId,
      @JsonKey(name: 'invoice_number') String invoiceNumber,
      @JsonKey(name: 'document_type') String documentType,
      String status,
      @JsonKey(name: 'issue_date') DateTime issueDate,
      @JsonKey(name: 'due_date') DateTime? dueDate,
      @JsonKey(name: 'subtotal') int subtotal,
      @JsonKey(name: 'discount_amount') int discountAmount,
      @JsonKey(name: 'tax_amount') int taxAmount,
      @JsonKey(name: 'cgst_total') int cgstTotal,
      @JsonKey(name: 'sgst_total') int sgstTotal,
      @JsonKey(name: 'igst_total') int igstTotal,
      @JsonKey(name: 'ugst_total') int ugstTotal,
      @JsonKey(name: 'total') int total,
      @JsonKey(name: 'amount_paid') int amountPaid,
      @JsonKey(name: 'currency_code') String currencyCode,
      @JsonKey(name: 'currency_symbol') String currencySymbol,
      @JsonKey(name: 'use_lakh_format') bool useLakhFormat,
      String? notes,
      String? terms,
      @JsonKey(name: 'created_by') String? createdBy,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt,
      @JsonKey(name: 'converted_to_invoice_id') String? convertedToInvoiceId,
      @JsonKey(includeFromJson: false, includeToJson: false)
      @JsonKey(name: 'customer_gstin')
      String? customerGstin,
      @JsonKey(name: 'customer_name') String? customerName,
      @JsonKey(name: 'place_of_supply') String? placeOfSupply,
      @JsonKey(name: 'einvoice_status') String einvoiceStatus,
      @JsonKey(name: 'irn') String? irn,
      @JsonKey(name: 'ack_number') String? ackNumber,
      @JsonKey(name: 'ack_date') DateTime? ackDate,
      @JsonKey(name: 'signed_qr_code') String? signedQrCode,
      List<InvoiceItem> items});
}

/// @nodoc
class _$InvoiceCopyWithImpl<$Res, $Val extends Invoice>
    implements $InvoiceCopyWith<$Res> {
  _$InvoiceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Invoice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? businessId = null,
    Object? customerId = freezed,
    Object? invoiceNumber = null,
    Object? documentType = null,
    Object? status = null,
    Object? issueDate = null,
    Object? dueDate = freezed,
    Object? subtotal = null,
    Object? discountAmount = null,
    Object? taxAmount = null,
    Object? cgstTotal = null,
    Object? sgstTotal = null,
    Object? igstTotal = null,
    Object? ugstTotal = null,
    Object? total = null,
    Object? amountPaid = null,
    Object? currencyCode = null,
    Object? currencySymbol = null,
    Object? useLakhFormat = null,
    Object? notes = freezed,
    Object? terms = freezed,
    Object? createdBy = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? convertedToInvoiceId = freezed,
    Object? customerGstin = freezed,
    Object? customerName = freezed,
    Object? placeOfSupply = freezed,
    Object? einvoiceStatus = null,
    Object? irn = freezed,
    Object? ackNumber = freezed,
    Object? ackDate = freezed,
    Object? signedQrCode = freezed,
    Object? items = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      businessId: null == businessId
          ? _value.businessId
          : businessId // ignore: cast_nullable_to_non_nullable
              as String,
      customerId: freezed == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as String?,
      invoiceNumber: null == invoiceNumber
          ? _value.invoiceNumber
          : invoiceNumber // ignore: cast_nullable_to_non_nullable
              as String,
      documentType: null == documentType
          ? _value.documentType
          : documentType // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      issueDate: null == issueDate
          ? _value.issueDate
          : issueDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      dueDate: freezed == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      subtotal: null == subtotal
          ? _value.subtotal
          : subtotal // ignore: cast_nullable_to_non_nullable
              as int,
      discountAmount: null == discountAmount
          ? _value.discountAmount
          : discountAmount // ignore: cast_nullable_to_non_nullable
              as int,
      taxAmount: null == taxAmount
          ? _value.taxAmount
          : taxAmount // ignore: cast_nullable_to_non_nullable
              as int,
      cgstTotal: null == cgstTotal
          ? _value.cgstTotal
          : cgstTotal // ignore: cast_nullable_to_non_nullable
              as int,
      sgstTotal: null == sgstTotal
          ? _value.sgstTotal
          : sgstTotal // ignore: cast_nullable_to_non_nullable
              as int,
      igstTotal: null == igstTotal
          ? _value.igstTotal
          : igstTotal // ignore: cast_nullable_to_non_nullable
              as int,
      ugstTotal: null == ugstTotal
          ? _value.ugstTotal
          : ugstTotal // ignore: cast_nullable_to_non_nullable
              as int,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      amountPaid: null == amountPaid
          ? _value.amountPaid
          : amountPaid // ignore: cast_nullable_to_non_nullable
              as int,
      currencyCode: null == currencyCode
          ? _value.currencyCode
          : currencyCode // ignore: cast_nullable_to_non_nullable
              as String,
      currencySymbol: null == currencySymbol
          ? _value.currencySymbol
          : currencySymbol // ignore: cast_nullable_to_non_nullable
              as String,
      useLakhFormat: null == useLakhFormat
          ? _value.useLakhFormat
          : useLakhFormat // ignore: cast_nullable_to_non_nullable
              as bool,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      terms: freezed == terms
          ? _value.terms
          : terms // ignore: cast_nullable_to_non_nullable
              as String?,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      convertedToInvoiceId: freezed == convertedToInvoiceId
          ? _value.convertedToInvoiceId
          : convertedToInvoiceId // ignore: cast_nullable_to_non_nullable
              as String?,
      customerGstin: freezed == customerGstin
          ? _value.customerGstin
          : customerGstin // ignore: cast_nullable_to_non_nullable
              as String?,
      customerName: freezed == customerName
          ? _value.customerName
          : customerName // ignore: cast_nullable_to_non_nullable
              as String?,
      placeOfSupply: freezed == placeOfSupply
          ? _value.placeOfSupply
          : placeOfSupply // ignore: cast_nullable_to_non_nullable
              as String?,
      einvoiceStatus: null == einvoiceStatus
          ? _value.einvoiceStatus
          : einvoiceStatus // ignore: cast_nullable_to_non_nullable
              as String,
      irn: freezed == irn
          ? _value.irn
          : irn // ignore: cast_nullable_to_non_nullable
              as String?,
      ackNumber: freezed == ackNumber
          ? _value.ackNumber
          : ackNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      ackDate: freezed == ackDate
          ? _value.ackDate
          : ackDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      signedQrCode: freezed == signedQrCode
          ? _value.signedQrCode
          : signedQrCode // ignore: cast_nullable_to_non_nullable
              as String?,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<InvoiceItem>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InvoiceImplCopyWith<$Res> implements $InvoiceCopyWith<$Res> {
  factory _$$InvoiceImplCopyWith(
          _$InvoiceImpl value, $Res Function(_$InvoiceImpl) then) =
      __$$InvoiceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'business_id') String businessId,
      @JsonKey(name: 'customer_id') String? customerId,
      @JsonKey(name: 'invoice_number') String invoiceNumber,
      @JsonKey(name: 'document_type') String documentType,
      String status,
      @JsonKey(name: 'issue_date') DateTime issueDate,
      @JsonKey(name: 'due_date') DateTime? dueDate,
      @JsonKey(name: 'subtotal') int subtotal,
      @JsonKey(name: 'discount_amount') int discountAmount,
      @JsonKey(name: 'tax_amount') int taxAmount,
      @JsonKey(name: 'cgst_total') int cgstTotal,
      @JsonKey(name: 'sgst_total') int sgstTotal,
      @JsonKey(name: 'igst_total') int igstTotal,
      @JsonKey(name: 'ugst_total') int ugstTotal,
      @JsonKey(name: 'total') int total,
      @JsonKey(name: 'amount_paid') int amountPaid,
      @JsonKey(name: 'currency_code') String currencyCode,
      @JsonKey(name: 'currency_symbol') String currencySymbol,
      @JsonKey(name: 'use_lakh_format') bool useLakhFormat,
      String? notes,
      String? terms,
      @JsonKey(name: 'created_by') String? createdBy,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt,
      @JsonKey(name: 'converted_to_invoice_id') String? convertedToInvoiceId,
      @JsonKey(includeFromJson: false, includeToJson: false)
      @JsonKey(name: 'customer_gstin')
      String? customerGstin,
      @JsonKey(name: 'customer_name') String? customerName,
      @JsonKey(name: 'place_of_supply') String? placeOfSupply,
      @JsonKey(name: 'einvoice_status') String einvoiceStatus,
      @JsonKey(name: 'irn') String? irn,
      @JsonKey(name: 'ack_number') String? ackNumber,
      @JsonKey(name: 'ack_date') DateTime? ackDate,
      @JsonKey(name: 'signed_qr_code') String? signedQrCode,
      List<InvoiceItem> items});
}

/// @nodoc
class __$$InvoiceImplCopyWithImpl<$Res>
    extends _$InvoiceCopyWithImpl<$Res, _$InvoiceImpl>
    implements _$$InvoiceImplCopyWith<$Res> {
  __$$InvoiceImplCopyWithImpl(
      _$InvoiceImpl _value, $Res Function(_$InvoiceImpl) _then)
      : super(_value, _then);

  /// Create a copy of Invoice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? businessId = null,
    Object? customerId = freezed,
    Object? invoiceNumber = null,
    Object? documentType = null,
    Object? status = null,
    Object? issueDate = null,
    Object? dueDate = freezed,
    Object? subtotal = null,
    Object? discountAmount = null,
    Object? taxAmount = null,
    Object? cgstTotal = null,
    Object? sgstTotal = null,
    Object? igstTotal = null,
    Object? ugstTotal = null,
    Object? total = null,
    Object? amountPaid = null,
    Object? currencyCode = null,
    Object? currencySymbol = null,
    Object? useLakhFormat = null,
    Object? notes = freezed,
    Object? terms = freezed,
    Object? createdBy = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? convertedToInvoiceId = freezed,
    Object? customerGstin = freezed,
    Object? customerName = freezed,
    Object? placeOfSupply = freezed,
    Object? einvoiceStatus = null,
    Object? irn = freezed,
    Object? ackNumber = freezed,
    Object? ackDate = freezed,
    Object? signedQrCode = freezed,
    Object? items = null,
  }) {
    return _then(_$InvoiceImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      businessId: null == businessId
          ? _value.businessId
          : businessId // ignore: cast_nullable_to_non_nullable
              as String,
      customerId: freezed == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as String?,
      invoiceNumber: null == invoiceNumber
          ? _value.invoiceNumber
          : invoiceNumber // ignore: cast_nullable_to_non_nullable
              as String,
      documentType: null == documentType
          ? _value.documentType
          : documentType // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      issueDate: null == issueDate
          ? _value.issueDate
          : issueDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      dueDate: freezed == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      subtotal: null == subtotal
          ? _value.subtotal
          : subtotal // ignore: cast_nullable_to_non_nullable
              as int,
      discountAmount: null == discountAmount
          ? _value.discountAmount
          : discountAmount // ignore: cast_nullable_to_non_nullable
              as int,
      taxAmount: null == taxAmount
          ? _value.taxAmount
          : taxAmount // ignore: cast_nullable_to_non_nullable
              as int,
      cgstTotal: null == cgstTotal
          ? _value.cgstTotal
          : cgstTotal // ignore: cast_nullable_to_non_nullable
              as int,
      sgstTotal: null == sgstTotal
          ? _value.sgstTotal
          : sgstTotal // ignore: cast_nullable_to_non_nullable
              as int,
      igstTotal: null == igstTotal
          ? _value.igstTotal
          : igstTotal // ignore: cast_nullable_to_non_nullable
              as int,
      ugstTotal: null == ugstTotal
          ? _value.ugstTotal
          : ugstTotal // ignore: cast_nullable_to_non_nullable
              as int,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      amountPaid: null == amountPaid
          ? _value.amountPaid
          : amountPaid // ignore: cast_nullable_to_non_nullable
              as int,
      currencyCode: null == currencyCode
          ? _value.currencyCode
          : currencyCode // ignore: cast_nullable_to_non_nullable
              as String,
      currencySymbol: null == currencySymbol
          ? _value.currencySymbol
          : currencySymbol // ignore: cast_nullable_to_non_nullable
              as String,
      useLakhFormat: null == useLakhFormat
          ? _value.useLakhFormat
          : useLakhFormat // ignore: cast_nullable_to_non_nullable
              as bool,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      terms: freezed == terms
          ? _value.terms
          : terms // ignore: cast_nullable_to_non_nullable
              as String?,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      convertedToInvoiceId: freezed == convertedToInvoiceId
          ? _value.convertedToInvoiceId
          : convertedToInvoiceId // ignore: cast_nullable_to_non_nullable
              as String?,
      customerGstin: freezed == customerGstin
          ? _value.customerGstin
          : customerGstin // ignore: cast_nullable_to_non_nullable
              as String?,
      customerName: freezed == customerName
          ? _value.customerName
          : customerName // ignore: cast_nullable_to_non_nullable
              as String?,
      placeOfSupply: freezed == placeOfSupply
          ? _value.placeOfSupply
          : placeOfSupply // ignore: cast_nullable_to_non_nullable
              as String?,
      einvoiceStatus: null == einvoiceStatus
          ? _value.einvoiceStatus
          : einvoiceStatus // ignore: cast_nullable_to_non_nullable
              as String,
      irn: freezed == irn
          ? _value.irn
          : irn // ignore: cast_nullable_to_non_nullable
              as String?,
      ackNumber: freezed == ackNumber
          ? _value.ackNumber
          : ackNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      ackDate: freezed == ackDate
          ? _value.ackDate
          : ackDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      signedQrCode: freezed == signedQrCode
          ? _value.signedQrCode
          : signedQrCode // ignore: cast_nullable_to_non_nullable
              as String?,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<InvoiceItem>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InvoiceImpl implements _Invoice {
  const _$InvoiceImpl(
      {required this.id,
      @JsonKey(name: 'business_id') required this.businessId,
      @JsonKey(name: 'customer_id') this.customerId,
      @JsonKey(name: 'invoice_number') required this.invoiceNumber,
      @JsonKey(name: 'document_type') this.documentType = kDocTypeInvoice,
      this.status = 'draft',
      @JsonKey(name: 'issue_date') required this.issueDate,
      @JsonKey(name: 'due_date') this.dueDate,
      @JsonKey(name: 'subtotal') this.subtotal = 0,
      @JsonKey(name: 'discount_amount') this.discountAmount = 0,
      @JsonKey(name: 'tax_amount') this.taxAmount = 0,
      @JsonKey(name: 'cgst_total') this.cgstTotal = 0,
      @JsonKey(name: 'sgst_total') this.sgstTotal = 0,
      @JsonKey(name: 'igst_total') this.igstTotal = 0,
      @JsonKey(name: 'ugst_total') this.ugstTotal = 0,
      @JsonKey(name: 'total') this.total = 0,
      @JsonKey(name: 'amount_paid') this.amountPaid = 0,
      @JsonKey(name: 'currency_code') this.currencyCode = 'INR',
      @JsonKey(name: 'currency_symbol') this.currencySymbol = 'Rs.',
      @JsonKey(name: 'use_lakh_format') this.useLakhFormat = true,
      this.notes,
      this.terms,
      @JsonKey(name: 'created_by') this.createdBy,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt,
      @JsonKey(name: 'converted_to_invoice_id') this.convertedToInvoiceId,
      @JsonKey(includeFromJson: false, includeToJson: false)
      @JsonKey(name: 'customer_gstin')
      this.customerGstin,
      @JsonKey(name: 'customer_name') this.customerName,
      @JsonKey(name: 'place_of_supply') this.placeOfSupply,
      @JsonKey(name: 'einvoice_status') this.einvoiceStatus = 'not_generated',
      @JsonKey(name: 'irn') this.irn,
      @JsonKey(name: 'ack_number') this.ackNumber,
      @JsonKey(name: 'ack_date') this.ackDate,
      @JsonKey(name: 'signed_qr_code') this.signedQrCode,
      final List<InvoiceItem> items = const []})
      : _items = items;

  factory _$InvoiceImpl.fromJson(Map<String, dynamic> json) =>
      _$$InvoiceImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'business_id')
  final String businessId;
  @override
  @JsonKey(name: 'customer_id')
  final String? customerId;
  @override
  @JsonKey(name: 'invoice_number')
  final String invoiceNumber;
  @override
  @JsonKey(name: 'document_type')
  final String documentType;
  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey(name: 'issue_date')
  final DateTime issueDate;
  @override
  @JsonKey(name: 'due_date')
  final DateTime? dueDate;
// Amounts in smallest currency unit
  @override
  @JsonKey(name: 'subtotal')
  final int subtotal;
  @override
  @JsonKey(name: 'discount_amount')
  final int discountAmount;
  @override
  @JsonKey(name: 'tax_amount')
  final int taxAmount;
  @override
  @JsonKey(name: 'cgst_total')
  final int cgstTotal;
  @override
  @JsonKey(name: 'sgst_total')
  final int sgstTotal;
  @override
  @JsonKey(name: 'igst_total')
  final int igstTotal;
  @override
  @JsonKey(name: 'ugst_total')
  final int ugstTotal;
  @override
  @JsonKey(name: 'total')
  final int total;
  @override
  @JsonKey(name: 'amount_paid')
  final int amountPaid;
// Currency snapshot at time of invoice creation
  @override
  @JsonKey(name: 'currency_code')
  final String currencyCode;
  @override
  @JsonKey(name: 'currency_symbol')
  final String currencySymbol;
  @override
  @JsonKey(name: 'use_lakh_format')
  final bool useLakhFormat;
  @override
  final String? notes;
  @override
  final String? terms;
  @override
  @JsonKey(name: 'created_by')
  final String? createdBy;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  @override
  @JsonKey(name: 'converted_to_invoice_id')
  final String? convertedToInvoiceId;
// Populated by join — not stored in invoices table
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @JsonKey(name: 'customer_gstin')
  final String? customerGstin;
  @override
  @JsonKey(name: 'customer_name')
  final String? customerName;
  @override
  @JsonKey(name: 'place_of_supply')
  final String? placeOfSupply;
  @override
  @JsonKey(name: 'einvoice_status')
  final String einvoiceStatus;
  @override
  @JsonKey(name: 'irn')
  final String? irn;
  @override
  @JsonKey(name: 'ack_number')
  final String? ackNumber;
  @override
  @JsonKey(name: 'ack_date')
  final DateTime? ackDate;
  @override
  @JsonKey(name: 'signed_qr_code')
  final String? signedQrCode;
  final List<InvoiceItem> _items;
  @override
  @JsonKey()
  List<InvoiceItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'Invoice(id: $id, businessId: $businessId, customerId: $customerId, invoiceNumber: $invoiceNumber, documentType: $documentType, status: $status, issueDate: $issueDate, dueDate: $dueDate, subtotal: $subtotal, discountAmount: $discountAmount, taxAmount: $taxAmount, cgstTotal: $cgstTotal, sgstTotal: $sgstTotal, igstTotal: $igstTotal, ugstTotal: $ugstTotal, total: $total, amountPaid: $amountPaid, currencyCode: $currencyCode, currencySymbol: $currencySymbol, useLakhFormat: $useLakhFormat, notes: $notes, terms: $terms, createdBy: $createdBy, createdAt: $createdAt, updatedAt: $updatedAt, convertedToInvoiceId: $convertedToInvoiceId, customerGstin: $customerGstin, customerName: $customerName, placeOfSupply: $placeOfSupply, einvoiceStatus: $einvoiceStatus, irn: $irn, ackNumber: $ackNumber, ackDate: $ackDate, signedQrCode: $signedQrCode, items: $items)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvoiceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.businessId, businessId) ||
                other.businessId == businessId) &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId) &&
            (identical(other.invoiceNumber, invoiceNumber) ||
                other.invoiceNumber == invoiceNumber) &&
            (identical(other.documentType, documentType) ||
                other.documentType == documentType) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.issueDate, issueDate) ||
                other.issueDate == issueDate) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            (identical(other.subtotal, subtotal) ||
                other.subtotal == subtotal) &&
            (identical(other.discountAmount, discountAmount) ||
                other.discountAmount == discountAmount) &&
            (identical(other.taxAmount, taxAmount) ||
                other.taxAmount == taxAmount) &&
            (identical(other.cgstTotal, cgstTotal) ||
                other.cgstTotal == cgstTotal) &&
            (identical(other.sgstTotal, sgstTotal) ||
                other.sgstTotal == sgstTotal) &&
            (identical(other.igstTotal, igstTotal) ||
                other.igstTotal == igstTotal) &&
            (identical(other.ugstTotal, ugstTotal) ||
                other.ugstTotal == ugstTotal) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.amountPaid, amountPaid) ||
                other.amountPaid == amountPaid) &&
            (identical(other.currencyCode, currencyCode) ||
                other.currencyCode == currencyCode) &&
            (identical(other.currencySymbol, currencySymbol) ||
                other.currencySymbol == currencySymbol) &&
            (identical(other.useLakhFormat, useLakhFormat) ||
                other.useLakhFormat == useLakhFormat) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.terms, terms) || other.terms == terms) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.convertedToInvoiceId, convertedToInvoiceId) ||
                other.convertedToInvoiceId == convertedToInvoiceId) &&
            (identical(other.customerGstin, customerGstin) ||
                other.customerGstin == customerGstin) &&
            (identical(other.customerName, customerName) ||
                other.customerName == customerName) &&
            (identical(other.placeOfSupply, placeOfSupply) ||
                other.placeOfSupply == placeOfSupply) &&
            (identical(other.einvoiceStatus, einvoiceStatus) ||
                other.einvoiceStatus == einvoiceStatus) &&
            (identical(other.irn, irn) || other.irn == irn) &&
            (identical(other.ackNumber, ackNumber) ||
                other.ackNumber == ackNumber) &&
            (identical(other.ackDate, ackDate) || other.ackDate == ackDate) &&
            (identical(other.signedQrCode, signedQrCode) ||
                other.signedQrCode == signedQrCode) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        businessId,
        customerId,
        invoiceNumber,
        documentType,
        status,
        issueDate,
        dueDate,
        subtotal,
        discountAmount,
        taxAmount,
        cgstTotal,
        sgstTotal,
        igstTotal,
        ugstTotal,
        total,
        amountPaid,
        currencyCode,
        currencySymbol,
        useLakhFormat,
        notes,
        terms,
        createdBy,
        createdAt,
        updatedAt,
        convertedToInvoiceId,
        customerGstin,
        customerName,
        placeOfSupply,
        einvoiceStatus,
        irn,
        ackNumber,
        ackDate,
        signedQrCode,
        const DeepCollectionEquality().hash(_items)
      ]);

  /// Create a copy of Invoice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InvoiceImplCopyWith<_$InvoiceImpl> get copyWith =>
      __$$InvoiceImplCopyWithImpl<_$InvoiceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InvoiceImplToJson(
      this,
    );
  }
}

abstract class _Invoice implements Invoice {
  const factory _Invoice(
      {required final String id,
      @JsonKey(name: 'business_id') required final String businessId,
      @JsonKey(name: 'customer_id') final String? customerId,
      @JsonKey(name: 'invoice_number') required final String invoiceNumber,
      @JsonKey(name: 'document_type') final String documentType,
      final String status,
      @JsonKey(name: 'issue_date') required final DateTime issueDate,
      @JsonKey(name: 'due_date') final DateTime? dueDate,
      @JsonKey(name: 'subtotal') final int subtotal,
      @JsonKey(name: 'discount_amount') final int discountAmount,
      @JsonKey(name: 'tax_amount') final int taxAmount,
      @JsonKey(name: 'cgst_total') final int cgstTotal,
      @JsonKey(name: 'sgst_total') final int sgstTotal,
      @JsonKey(name: 'igst_total') final int igstTotal,
      @JsonKey(name: 'ugst_total') final int ugstTotal,
      @JsonKey(name: 'total') final int total,
      @JsonKey(name: 'amount_paid') final int amountPaid,
      @JsonKey(name: 'currency_code') final String currencyCode,
      @JsonKey(name: 'currency_symbol') final String currencySymbol,
      @JsonKey(name: 'use_lakh_format') final bool useLakhFormat,
      final String? notes,
      final String? terms,
      @JsonKey(name: 'created_by') final String? createdBy,
      @JsonKey(name: 'created_at') final DateTime? createdAt,
      @JsonKey(name: 'updated_at') final DateTime? updatedAt,
      @JsonKey(name: 'converted_to_invoice_id')
      final String? convertedToInvoiceId,
      @JsonKey(includeFromJson: false, includeToJson: false)
      @JsonKey(name: 'customer_gstin')
      final String? customerGstin,
      @JsonKey(name: 'customer_name') final String? customerName,
      @JsonKey(name: 'place_of_supply') final String? placeOfSupply,
      @JsonKey(name: 'einvoice_status') final String einvoiceStatus,
      @JsonKey(name: 'irn') final String? irn,
      @JsonKey(name: 'ack_number') final String? ackNumber,
      @JsonKey(name: 'ack_date') final DateTime? ackDate,
      @JsonKey(name: 'signed_qr_code') final String? signedQrCode,
      final List<InvoiceItem> items}) = _$InvoiceImpl;

  factory _Invoice.fromJson(Map<String, dynamic> json) = _$InvoiceImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'business_id')
  String get businessId;
  @override
  @JsonKey(name: 'customer_id')
  String? get customerId;
  @override
  @JsonKey(name: 'invoice_number')
  String get invoiceNumber;
  @override
  @JsonKey(name: 'document_type')
  String get documentType;
  @override
  String get status;
  @override
  @JsonKey(name: 'issue_date')
  DateTime get issueDate;
  @override
  @JsonKey(name: 'due_date')
  DateTime? get dueDate; // Amounts in smallest currency unit
  @override
  @JsonKey(name: 'subtotal')
  int get subtotal;
  @override
  @JsonKey(name: 'discount_amount')
  int get discountAmount;
  @override
  @JsonKey(name: 'tax_amount')
  int get taxAmount;
  @override
  @JsonKey(name: 'cgst_total')
  int get cgstTotal;
  @override
  @JsonKey(name: 'sgst_total')
  int get sgstTotal;
  @override
  @JsonKey(name: 'igst_total')
  int get igstTotal;
  @override
  @JsonKey(name: 'ugst_total')
  int get ugstTotal;
  @override
  @JsonKey(name: 'total')
  int get total;
  @override
  @JsonKey(name: 'amount_paid')
  int get amountPaid; // Currency snapshot at time of invoice creation
  @override
  @JsonKey(name: 'currency_code')
  String get currencyCode;
  @override
  @JsonKey(name: 'currency_symbol')
  String get currencySymbol;
  @override
  @JsonKey(name: 'use_lakh_format')
  bool get useLakhFormat;
  @override
  String? get notes;
  @override
  String? get terms;
  @override
  @JsonKey(name: 'created_by')
  String? get createdBy;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;
  @override
  @JsonKey(name: 'converted_to_invoice_id')
  String?
      get convertedToInvoiceId; // Populated by join — not stored in invoices table
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @JsonKey(name: 'customer_gstin')
  String? get customerGstin;
  @override
  @JsonKey(name: 'customer_name')
  String? get customerName;
  @override
  @JsonKey(name: 'place_of_supply')
  String? get placeOfSupply;
  @override
  @JsonKey(name: 'einvoice_status')
  String get einvoiceStatus;
  @override
  @JsonKey(name: 'irn')
  String? get irn;
  @override
  @JsonKey(name: 'ack_number')
  String? get ackNumber;
  @override
  @JsonKey(name: 'ack_date')
  DateTime? get ackDate;
  @override
  @JsonKey(name: 'signed_qr_code')
  String? get signedQrCode;
  @override
  List<InvoiceItem> get items;

  /// Create a copy of Invoice
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InvoiceImplCopyWith<_$InvoiceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

InvoiceItem _$InvoiceItemFromJson(Map<String, dynamic> json) {
  return _InvoiceItem.fromJson(json);
}

/// @nodoc
mixin _$InvoiceItem {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'invoice_id')
  String get invoiceId => throw _privateConstructorUsedError;
  @JsonKey(name: 'business_id')
  String get businessId => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_id')
  String? get productId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  double get quantity => throw _privateConstructorUsedError;
  String get unit => throw _privateConstructorUsedError;
  @JsonKey(name: 'unit_price')
  int get unitPrice => throw _privateConstructorUsedError;
  @JsonKey(name: 'discount_pct')
  double get discountPct => throw _privateConstructorUsedError;
  @JsonKey(name: 'tax_rate')
  double get taxRate => throw _privateConstructorUsedError;
  @JsonKey(name: 'tax_inclusive')
  bool get taxInclusive => throw _privateConstructorUsedError;
  @JsonKey(name: 'tax_amount')
  int get taxAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'line_total')
  int get lineTotal => throw _privateConstructorUsedError;
  @JsonKey(name: 'sort_order')
  int get sortOrder =>
      throw _privateConstructorUsedError; //GST calc, tax amount
  @JsonKey(name: 'cgst_amount')
  int get cgstAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'sgst_amount')
  int get sgstAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'igst_amount')
  int get igstAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'ugst_amount')
  int get ugstAmount => throw _privateConstructorUsedError; //GST calc tax total
  @JsonKey(name: 'cgst_total')
  int get cgstTotal => throw _privateConstructorUsedError;
  @JsonKey(name: 'sgst_total')
  int get sgstTotal => throw _privateConstructorUsedError;
  @JsonKey(name: 'igst_total')
  int get igstTotal => throw _privateConstructorUsedError;
  @JsonKey(name: 'ugst_total')
  int get ugstTotal => throw _privateConstructorUsedError;
  @JsonKey(name: 'hsn_sac_code')
  String? get hsnSacCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'commodity_code')
  String? get commodityCode => throw _privateConstructorUsedError;

  /// Serializes this InvoiceItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of InvoiceItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InvoiceItemCopyWith<InvoiceItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvoiceItemCopyWith<$Res> {
  factory $InvoiceItemCopyWith(
          InvoiceItem value, $Res Function(InvoiceItem) then) =
      _$InvoiceItemCopyWithImpl<$Res, InvoiceItem>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'invoice_id') String invoiceId,
      @JsonKey(name: 'business_id') String businessId,
      @JsonKey(name: 'product_id') String? productId,
      String name,
      String? description,
      double quantity,
      String unit,
      @JsonKey(name: 'unit_price') int unitPrice,
      @JsonKey(name: 'discount_pct') double discountPct,
      @JsonKey(name: 'tax_rate') double taxRate,
      @JsonKey(name: 'tax_inclusive') bool taxInclusive,
      @JsonKey(name: 'tax_amount') int taxAmount,
      @JsonKey(name: 'line_total') int lineTotal,
      @JsonKey(name: 'sort_order') int sortOrder,
      @JsonKey(name: 'cgst_amount') int cgstAmount,
      @JsonKey(name: 'sgst_amount') int sgstAmount,
      @JsonKey(name: 'igst_amount') int igstAmount,
      @JsonKey(name: 'ugst_amount') int ugstAmount,
      @JsonKey(name: 'cgst_total') int cgstTotal,
      @JsonKey(name: 'sgst_total') int sgstTotal,
      @JsonKey(name: 'igst_total') int igstTotal,
      @JsonKey(name: 'ugst_total') int ugstTotal,
      @JsonKey(name: 'hsn_sac_code') String? hsnSacCode,
      @JsonKey(name: 'commodity_code') String? commodityCode});
}

/// @nodoc
class _$InvoiceItemCopyWithImpl<$Res, $Val extends InvoiceItem>
    implements $InvoiceItemCopyWith<$Res> {
  _$InvoiceItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InvoiceItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? invoiceId = null,
    Object? businessId = null,
    Object? productId = freezed,
    Object? name = null,
    Object? description = freezed,
    Object? quantity = null,
    Object? unit = null,
    Object? unitPrice = null,
    Object? discountPct = null,
    Object? taxRate = null,
    Object? taxInclusive = null,
    Object? taxAmount = null,
    Object? lineTotal = null,
    Object? sortOrder = null,
    Object? cgstAmount = null,
    Object? sgstAmount = null,
    Object? igstAmount = null,
    Object? ugstAmount = null,
    Object? cgstTotal = null,
    Object? sgstTotal = null,
    Object? igstTotal = null,
    Object? ugstTotal = null,
    Object? hsnSacCode = freezed,
    Object? commodityCode = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      invoiceId: null == invoiceId
          ? _value.invoiceId
          : invoiceId // ignore: cast_nullable_to_non_nullable
              as String,
      businessId: null == businessId
          ? _value.businessId
          : businessId // ignore: cast_nullable_to_non_nullable
              as String,
      productId: freezed == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      unitPrice: null == unitPrice
          ? _value.unitPrice
          : unitPrice // ignore: cast_nullable_to_non_nullable
              as int,
      discountPct: null == discountPct
          ? _value.discountPct
          : discountPct // ignore: cast_nullable_to_non_nullable
              as double,
      taxRate: null == taxRate
          ? _value.taxRate
          : taxRate // ignore: cast_nullable_to_non_nullable
              as double,
      taxInclusive: null == taxInclusive
          ? _value.taxInclusive
          : taxInclusive // ignore: cast_nullable_to_non_nullable
              as bool,
      taxAmount: null == taxAmount
          ? _value.taxAmount
          : taxAmount // ignore: cast_nullable_to_non_nullable
              as int,
      lineTotal: null == lineTotal
          ? _value.lineTotal
          : lineTotal // ignore: cast_nullable_to_non_nullable
              as int,
      sortOrder: null == sortOrder
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int,
      cgstAmount: null == cgstAmount
          ? _value.cgstAmount
          : cgstAmount // ignore: cast_nullable_to_non_nullable
              as int,
      sgstAmount: null == sgstAmount
          ? _value.sgstAmount
          : sgstAmount // ignore: cast_nullable_to_non_nullable
              as int,
      igstAmount: null == igstAmount
          ? _value.igstAmount
          : igstAmount // ignore: cast_nullable_to_non_nullable
              as int,
      ugstAmount: null == ugstAmount
          ? _value.ugstAmount
          : ugstAmount // ignore: cast_nullable_to_non_nullable
              as int,
      cgstTotal: null == cgstTotal
          ? _value.cgstTotal
          : cgstTotal // ignore: cast_nullable_to_non_nullable
              as int,
      sgstTotal: null == sgstTotal
          ? _value.sgstTotal
          : sgstTotal // ignore: cast_nullable_to_non_nullable
              as int,
      igstTotal: null == igstTotal
          ? _value.igstTotal
          : igstTotal // ignore: cast_nullable_to_non_nullable
              as int,
      ugstTotal: null == ugstTotal
          ? _value.ugstTotal
          : ugstTotal // ignore: cast_nullable_to_non_nullable
              as int,
      hsnSacCode: freezed == hsnSacCode
          ? _value.hsnSacCode
          : hsnSacCode // ignore: cast_nullable_to_non_nullable
              as String?,
      commodityCode: freezed == commodityCode
          ? _value.commodityCode
          : commodityCode // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InvoiceItemImplCopyWith<$Res>
    implements $InvoiceItemCopyWith<$Res> {
  factory _$$InvoiceItemImplCopyWith(
          _$InvoiceItemImpl value, $Res Function(_$InvoiceItemImpl) then) =
      __$$InvoiceItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'invoice_id') String invoiceId,
      @JsonKey(name: 'business_id') String businessId,
      @JsonKey(name: 'product_id') String? productId,
      String name,
      String? description,
      double quantity,
      String unit,
      @JsonKey(name: 'unit_price') int unitPrice,
      @JsonKey(name: 'discount_pct') double discountPct,
      @JsonKey(name: 'tax_rate') double taxRate,
      @JsonKey(name: 'tax_inclusive') bool taxInclusive,
      @JsonKey(name: 'tax_amount') int taxAmount,
      @JsonKey(name: 'line_total') int lineTotal,
      @JsonKey(name: 'sort_order') int sortOrder,
      @JsonKey(name: 'cgst_amount') int cgstAmount,
      @JsonKey(name: 'sgst_amount') int sgstAmount,
      @JsonKey(name: 'igst_amount') int igstAmount,
      @JsonKey(name: 'ugst_amount') int ugstAmount,
      @JsonKey(name: 'cgst_total') int cgstTotal,
      @JsonKey(name: 'sgst_total') int sgstTotal,
      @JsonKey(name: 'igst_total') int igstTotal,
      @JsonKey(name: 'ugst_total') int ugstTotal,
      @JsonKey(name: 'hsn_sac_code') String? hsnSacCode,
      @JsonKey(name: 'commodity_code') String? commodityCode});
}

/// @nodoc
class __$$InvoiceItemImplCopyWithImpl<$Res>
    extends _$InvoiceItemCopyWithImpl<$Res, _$InvoiceItemImpl>
    implements _$$InvoiceItemImplCopyWith<$Res> {
  __$$InvoiceItemImplCopyWithImpl(
      _$InvoiceItemImpl _value, $Res Function(_$InvoiceItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of InvoiceItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? invoiceId = null,
    Object? businessId = null,
    Object? productId = freezed,
    Object? name = null,
    Object? description = freezed,
    Object? quantity = null,
    Object? unit = null,
    Object? unitPrice = null,
    Object? discountPct = null,
    Object? taxRate = null,
    Object? taxInclusive = null,
    Object? taxAmount = null,
    Object? lineTotal = null,
    Object? sortOrder = null,
    Object? cgstAmount = null,
    Object? sgstAmount = null,
    Object? igstAmount = null,
    Object? ugstAmount = null,
    Object? cgstTotal = null,
    Object? sgstTotal = null,
    Object? igstTotal = null,
    Object? ugstTotal = null,
    Object? hsnSacCode = freezed,
    Object? commodityCode = freezed,
  }) {
    return _then(_$InvoiceItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      invoiceId: null == invoiceId
          ? _value.invoiceId
          : invoiceId // ignore: cast_nullable_to_non_nullable
              as String,
      businessId: null == businessId
          ? _value.businessId
          : businessId // ignore: cast_nullable_to_non_nullable
              as String,
      productId: freezed == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      unitPrice: null == unitPrice
          ? _value.unitPrice
          : unitPrice // ignore: cast_nullable_to_non_nullable
              as int,
      discountPct: null == discountPct
          ? _value.discountPct
          : discountPct // ignore: cast_nullable_to_non_nullable
              as double,
      taxRate: null == taxRate
          ? _value.taxRate
          : taxRate // ignore: cast_nullable_to_non_nullable
              as double,
      taxInclusive: null == taxInclusive
          ? _value.taxInclusive
          : taxInclusive // ignore: cast_nullable_to_non_nullable
              as bool,
      taxAmount: null == taxAmount
          ? _value.taxAmount
          : taxAmount // ignore: cast_nullable_to_non_nullable
              as int,
      lineTotal: null == lineTotal
          ? _value.lineTotal
          : lineTotal // ignore: cast_nullable_to_non_nullable
              as int,
      sortOrder: null == sortOrder
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int,
      cgstAmount: null == cgstAmount
          ? _value.cgstAmount
          : cgstAmount // ignore: cast_nullable_to_non_nullable
              as int,
      sgstAmount: null == sgstAmount
          ? _value.sgstAmount
          : sgstAmount // ignore: cast_nullable_to_non_nullable
              as int,
      igstAmount: null == igstAmount
          ? _value.igstAmount
          : igstAmount // ignore: cast_nullable_to_non_nullable
              as int,
      ugstAmount: null == ugstAmount
          ? _value.ugstAmount
          : ugstAmount // ignore: cast_nullable_to_non_nullable
              as int,
      cgstTotal: null == cgstTotal
          ? _value.cgstTotal
          : cgstTotal // ignore: cast_nullable_to_non_nullable
              as int,
      sgstTotal: null == sgstTotal
          ? _value.sgstTotal
          : sgstTotal // ignore: cast_nullable_to_non_nullable
              as int,
      igstTotal: null == igstTotal
          ? _value.igstTotal
          : igstTotal // ignore: cast_nullable_to_non_nullable
              as int,
      ugstTotal: null == ugstTotal
          ? _value.ugstTotal
          : ugstTotal // ignore: cast_nullable_to_non_nullable
              as int,
      hsnSacCode: freezed == hsnSacCode
          ? _value.hsnSacCode
          : hsnSacCode // ignore: cast_nullable_to_non_nullable
              as String?,
      commodityCode: freezed == commodityCode
          ? _value.commodityCode
          : commodityCode // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InvoiceItemImpl implements _InvoiceItem {
  const _$InvoiceItemImpl(
      {required this.id,
      @JsonKey(name: 'invoice_id') required this.invoiceId,
      @JsonKey(name: 'business_id') required this.businessId,
      @JsonKey(name: 'product_id') this.productId,
      required this.name,
      this.description,
      this.quantity = 1.0,
      this.unit = 'pcs',
      @JsonKey(name: 'unit_price') this.unitPrice = 0,
      @JsonKey(name: 'discount_pct') this.discountPct = 0.0,
      @JsonKey(name: 'tax_rate') this.taxRate = 0.0,
      @JsonKey(name: 'tax_inclusive') this.taxInclusive = false,
      @JsonKey(name: 'tax_amount') this.taxAmount = 0,
      @JsonKey(name: 'line_total') this.lineTotal = 0,
      @JsonKey(name: 'sort_order') this.sortOrder = 0,
      @JsonKey(name: 'cgst_amount') this.cgstAmount = 0,
      @JsonKey(name: 'sgst_amount') this.sgstAmount = 0,
      @JsonKey(name: 'igst_amount') this.igstAmount = 0,
      @JsonKey(name: 'ugst_amount') this.ugstAmount = 0,
      @JsonKey(name: 'cgst_total') this.cgstTotal = 0,
      @JsonKey(name: 'sgst_total') this.sgstTotal = 0,
      @JsonKey(name: 'igst_total') this.igstTotal = 0,
      @JsonKey(name: 'ugst_total') this.ugstTotal = 0,
      @JsonKey(name: 'hsn_sac_code') this.hsnSacCode,
      @JsonKey(name: 'commodity_code') this.commodityCode});

  factory _$InvoiceItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$InvoiceItemImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'invoice_id')
  final String invoiceId;
  @override
  @JsonKey(name: 'business_id')
  final String businessId;
  @override
  @JsonKey(name: 'product_id')
  final String? productId;
  @override
  final String name;
  @override
  final String? description;
  @override
  @JsonKey()
  final double quantity;
  @override
  @JsonKey()
  final String unit;
  @override
  @JsonKey(name: 'unit_price')
  final int unitPrice;
  @override
  @JsonKey(name: 'discount_pct')
  final double discountPct;
  @override
  @JsonKey(name: 'tax_rate')
  final double taxRate;
  @override
  @JsonKey(name: 'tax_inclusive')
  final bool taxInclusive;
  @override
  @JsonKey(name: 'tax_amount')
  final int taxAmount;
  @override
  @JsonKey(name: 'line_total')
  final int lineTotal;
  @override
  @JsonKey(name: 'sort_order')
  final int sortOrder;
//GST calc, tax amount
  @override
  @JsonKey(name: 'cgst_amount')
  final int cgstAmount;
  @override
  @JsonKey(name: 'sgst_amount')
  final int sgstAmount;
  @override
  @JsonKey(name: 'igst_amount')
  final int igstAmount;
  @override
  @JsonKey(name: 'ugst_amount')
  final int ugstAmount;
//GST calc tax total
  @override
  @JsonKey(name: 'cgst_total')
  final int cgstTotal;
  @override
  @JsonKey(name: 'sgst_total')
  final int sgstTotal;
  @override
  @JsonKey(name: 'igst_total')
  final int igstTotal;
  @override
  @JsonKey(name: 'ugst_total')
  final int ugstTotal;
  @override
  @JsonKey(name: 'hsn_sac_code')
  final String? hsnSacCode;
  @override
  @JsonKey(name: 'commodity_code')
  final String? commodityCode;

  @override
  String toString() {
    return 'InvoiceItem(id: $id, invoiceId: $invoiceId, businessId: $businessId, productId: $productId, name: $name, description: $description, quantity: $quantity, unit: $unit, unitPrice: $unitPrice, discountPct: $discountPct, taxRate: $taxRate, taxInclusive: $taxInclusive, taxAmount: $taxAmount, lineTotal: $lineTotal, sortOrder: $sortOrder, cgstAmount: $cgstAmount, sgstAmount: $sgstAmount, igstAmount: $igstAmount, ugstAmount: $ugstAmount, cgstTotal: $cgstTotal, sgstTotal: $sgstTotal, igstTotal: $igstTotal, ugstTotal: $ugstTotal, hsnSacCode: $hsnSacCode, commodityCode: $commodityCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvoiceItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.invoiceId, invoiceId) ||
                other.invoiceId == invoiceId) &&
            (identical(other.businessId, businessId) ||
                other.businessId == businessId) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.unitPrice, unitPrice) ||
                other.unitPrice == unitPrice) &&
            (identical(other.discountPct, discountPct) ||
                other.discountPct == discountPct) &&
            (identical(other.taxRate, taxRate) || other.taxRate == taxRate) &&
            (identical(other.taxInclusive, taxInclusive) ||
                other.taxInclusive == taxInclusive) &&
            (identical(other.taxAmount, taxAmount) ||
                other.taxAmount == taxAmount) &&
            (identical(other.lineTotal, lineTotal) ||
                other.lineTotal == lineTotal) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(other.cgstAmount, cgstAmount) ||
                other.cgstAmount == cgstAmount) &&
            (identical(other.sgstAmount, sgstAmount) ||
                other.sgstAmount == sgstAmount) &&
            (identical(other.igstAmount, igstAmount) ||
                other.igstAmount == igstAmount) &&
            (identical(other.ugstAmount, ugstAmount) ||
                other.ugstAmount == ugstAmount) &&
            (identical(other.cgstTotal, cgstTotal) ||
                other.cgstTotal == cgstTotal) &&
            (identical(other.sgstTotal, sgstTotal) ||
                other.sgstTotal == sgstTotal) &&
            (identical(other.igstTotal, igstTotal) ||
                other.igstTotal == igstTotal) &&
            (identical(other.ugstTotal, ugstTotal) ||
                other.ugstTotal == ugstTotal) &&
            (identical(other.hsnSacCode, hsnSacCode) ||
                other.hsnSacCode == hsnSacCode) &&
            (identical(other.commodityCode, commodityCode) ||
                other.commodityCode == commodityCode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        invoiceId,
        businessId,
        productId,
        name,
        description,
        quantity,
        unit,
        unitPrice,
        discountPct,
        taxRate,
        taxInclusive,
        taxAmount,
        lineTotal,
        sortOrder,
        cgstAmount,
        sgstAmount,
        igstAmount,
        ugstAmount,
        cgstTotal,
        sgstTotal,
        igstTotal,
        ugstTotal,
        hsnSacCode,
        commodityCode
      ]);

  /// Create a copy of InvoiceItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InvoiceItemImplCopyWith<_$InvoiceItemImpl> get copyWith =>
      __$$InvoiceItemImplCopyWithImpl<_$InvoiceItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InvoiceItemImplToJson(
      this,
    );
  }
}

abstract class _InvoiceItem implements InvoiceItem {
  const factory _InvoiceItem(
          {required final String id,
          @JsonKey(name: 'invoice_id') required final String invoiceId,
          @JsonKey(name: 'business_id') required final String businessId,
          @JsonKey(name: 'product_id') final String? productId,
          required final String name,
          final String? description,
          final double quantity,
          final String unit,
          @JsonKey(name: 'unit_price') final int unitPrice,
          @JsonKey(name: 'discount_pct') final double discountPct,
          @JsonKey(name: 'tax_rate') final double taxRate,
          @JsonKey(name: 'tax_inclusive') final bool taxInclusive,
          @JsonKey(name: 'tax_amount') final int taxAmount,
          @JsonKey(name: 'line_total') final int lineTotal,
          @JsonKey(name: 'sort_order') final int sortOrder,
          @JsonKey(name: 'cgst_amount') final int cgstAmount,
          @JsonKey(name: 'sgst_amount') final int sgstAmount,
          @JsonKey(name: 'igst_amount') final int igstAmount,
          @JsonKey(name: 'ugst_amount') final int ugstAmount,
          @JsonKey(name: 'cgst_total') final int cgstTotal,
          @JsonKey(name: 'sgst_total') final int sgstTotal,
          @JsonKey(name: 'igst_total') final int igstTotal,
          @JsonKey(name: 'ugst_total') final int ugstTotal,
          @JsonKey(name: 'hsn_sac_code') final String? hsnSacCode,
          @JsonKey(name: 'commodity_code') final String? commodityCode}) =
      _$InvoiceItemImpl;

  factory _InvoiceItem.fromJson(Map<String, dynamic> json) =
      _$InvoiceItemImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'invoice_id')
  String get invoiceId;
  @override
  @JsonKey(name: 'business_id')
  String get businessId;
  @override
  @JsonKey(name: 'product_id')
  String? get productId;
  @override
  String get name;
  @override
  String? get description;
  @override
  double get quantity;
  @override
  String get unit;
  @override
  @JsonKey(name: 'unit_price')
  int get unitPrice;
  @override
  @JsonKey(name: 'discount_pct')
  double get discountPct;
  @override
  @JsonKey(name: 'tax_rate')
  double get taxRate;
  @override
  @JsonKey(name: 'tax_inclusive')
  bool get taxInclusive;
  @override
  @JsonKey(name: 'tax_amount')
  int get taxAmount;
  @override
  @JsonKey(name: 'line_total')
  int get lineTotal;
  @override
  @JsonKey(name: 'sort_order')
  int get sortOrder; //GST calc, tax amount
  @override
  @JsonKey(name: 'cgst_amount')
  int get cgstAmount;
  @override
  @JsonKey(name: 'sgst_amount')
  int get sgstAmount;
  @override
  @JsonKey(name: 'igst_amount')
  int get igstAmount;
  @override
  @JsonKey(name: 'ugst_amount')
  int get ugstAmount; //GST calc tax total
  @override
  @JsonKey(name: 'cgst_total')
  int get cgstTotal;
  @override
  @JsonKey(name: 'sgst_total')
  int get sgstTotal;
  @override
  @JsonKey(name: 'igst_total')
  int get igstTotal;
  @override
  @JsonKey(name: 'ugst_total')
  int get ugstTotal;
  @override
  @JsonKey(name: 'hsn_sac_code')
  String? get hsnSacCode;
  @override
  @JsonKey(name: 'commodity_code')
  String? get commodityCode;

  /// Create a copy of InvoiceItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InvoiceItemImplCopyWith<_$InvoiceItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
