@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZAGR_MATERIAL000'
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZAGR_R_MATERIAL
  as select from ZAGR_MATERIAL as Material
{
  key productid as Productid,
  description as Description,
  @Semantics.amount.currencyCode: 'Currency'
  price as Price,
  @Consumption.valueHelpDefinition: [ {
    entity.name: 'I_CurrencyStdVH', 
    entity.element: 'Currency', 
    useForValidation: true
  } ]
  currency as Currency,
  filecontent as Filecontent,
  filename as Filename,
  mimetype as Mimetype,
  @Semantics.user.createdBy: true
  local_created_by as LocalCreatedBy,
  @Semantics.systemDateTime.createdAt: true
  local_created_at as LocalCreatedAt,
  @Semantics.user.localInstanceLastChangedBy: true
  local_last_changed_by as LocalLastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  local_last_changed_at as LocalLastChangedAt,
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed_at as LastChangedAt
}
