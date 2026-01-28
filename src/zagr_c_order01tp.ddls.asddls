@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Projection View forOrder'

@Metadata.allowExtensions: true

@ObjectModel.semanticKey: [ 'SalesorderID' ]

@Search.searchable: true

define root view entity zagr_c_Order01TP
  provider contract transactional_query
  as projection on ZAGR_R_Order01TP as Orderdata
{
      @Search.defaultSearchElement:true
  key SalesorderID,
      @Consumption.valueHelpDefinition: [{entity: {name: 'ZAGR_I_CUSTOMER_VH', element: 'Customerid' }, useForValidation: true}]
      CustomerID,
      OrderDate,
      Status,
      StatusText,
      FileContent,
      FileName,
      
      MimeType,
      LocalCreatedBy,
      LocalCreatedAt,
      LocalLastChangedBy,
      LocalLastChangedAt,
      LastChangedAt,

      /* Associations */
      _Item : redirected to composition child ZAGR_C_ItemTP
}
