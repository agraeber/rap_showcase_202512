@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Order States'

define view entity ZAGR_I_ORDER_STATE
  as select from zagr_order_state

{
  key status       as Status,

      description as Description
}
