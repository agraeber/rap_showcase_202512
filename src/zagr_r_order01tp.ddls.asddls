@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'CDS View forOrder'

@Metadata.allowExtensions: true

define root view entity ZAGR_R_Order01TP
  as select from zagr_orderhd as Orderdata

  composition [0..*] of ZAGR_R_ItemTP as _Item

{
  key salesorder_id         as SalesorderID,

      customer_id           as CustomerID,
      order_date            as OrderDate,
      status                as Status,

      @Semantics.user.createdBy: true
      local_created_by      as LocalCreatedBy,

      @Semantics.systemDateTime.createdAt: true
      local_created_at      as LocalCreatedAt,

      local_last_changed_by as LocalLastChangedBy,

      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,

      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at       as LastChangedAt,

      _Item
}
