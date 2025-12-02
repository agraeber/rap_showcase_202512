
@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'customer value help'

@Metadata.ignorePropagatedAnnotations: true

define view entity ZAGR_I_CUSTOMER_VH
  as select from zagr_customer

{
  key customerid as Customerid,

      name       as Name
}
