@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'material value help'
@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@Search.searchable: true


define view entity zagr_i_Material_VH
  as select from zagr_material

{
      @Search.defaultSearchElement: true
  key productid   as Productid,

      description as Description
}
