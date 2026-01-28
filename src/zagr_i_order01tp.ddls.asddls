@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Projection View forItem'

define root view entity ZAGR_I_Order01TP
  provider contract transactional_interface
  as projection on ZAGR_R_Order01TP as Orderdata

{
  key SalesorderID,

      CustomerID,
      OrderDate,
      Status,


      FileContent,
      FileName,

      MimeType,

      LocalCreatedBy,
      LocalCreatedAt,
      LocalLastChangedBy,
      LocalLastChangedAt,
      LastChangedAt,

      /* Associations */
      _Item : redirected to composition child ZAGR_I_ItemTP
}
