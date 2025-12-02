@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'CDS View forItem'

@Metadata.allowExtensions: true

define view entity ZAGR_R_ItemTP
  as select from zagr_orderitm

  association to parent ZAGR_R_Order01TP as _Order on $projection.SalesorderID = _Order.SalesorderID

{
  key salesorder_id as SalesorderID, 
  key item_no       as ItemNo,

      material_id   as MaterialID,
      quantity      as Quantity,

      @Semantics.amount.currencyCode: 'Currency'
      item_price    as ItemPrice,

      @Semantics.amount.currencyCode: 'Currency'
      total_price   as TotalPrice,

      currency      as Currency,

      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,

      _Order
}
