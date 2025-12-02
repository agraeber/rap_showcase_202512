
@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'material value help'

@Metadata.ignorePropagatedAnnotations: true

define view entity zagr_i_Material_VH
  as select from zagr_material

{
  key productid   as Productid,

      description as Description
}
