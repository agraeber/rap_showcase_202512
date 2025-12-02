@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View forItem'
define view entity ZAGR_I_ItemTP
  as projection on ZAGR_R_ItemTP 
{
  key SalesorderID,
  key ItemNo,
  
  MaterialID,
  Quantity, 
  ItemPrice,
  TotalPrice,
  Currency,
  LocalLastChangedAt,
  _Order: redirected to parent ZAGR_I_Order01TP
}
