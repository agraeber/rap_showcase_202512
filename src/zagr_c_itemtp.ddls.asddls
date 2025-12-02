@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Projection View forItem'

@Metadata.allowExtensions: true

@ObjectModel.semanticKey: [ 'ItemNo' ]

@Search.searchable: true

define view entity ZAGR_C_ItemTP
  as projection on ZAGR_R_ItemTP as Item

{
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.90
  key SalesorderID,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.90
  key ItemNo,

      @Consumption.valueHelpDefinition: [ { entity: { name: 'ZAGR_I_MATERIAL_VH', element: 'Productid' },
                                            useForValidation: true } ]
      MaterialID,

      Quantity,

      @Semantics.amount.currencyCode: 'Currency'
      ItemPrice,

      @Semantics.amount.currencyCode: 'Currency'
      TotalPrice,

      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_Currency', element: 'Currency' },
                                            useForValidation: true } ]
      Currency,

      LocalLastChangedAt,
      _Order : redirected to parent zagr_c_Order01TP
}
