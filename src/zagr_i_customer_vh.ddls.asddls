@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'customer value help'

@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true

define view entity ZAGR_I_CUSTOMER_VH
  as select from zagr_customer

{
      @UI.identification: [ { position: 10, label: 'Element Name' } ]
      @UI.lineItem: [ { position: 10, importance: #HIGH, label: 'CustomerName' } ]
      @UI.selectionField: [ { position: 10 } ]
  key customerid as CustomerID,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @Semantics.text: true
      @UI.lineItem: [ { position: 20, importance: #HIGH, label: 'Name' } ]
      @UI.selectionField: [ { position: 20 } ]
      name       as Name
}
