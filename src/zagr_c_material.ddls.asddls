@AccessControl.authorizationCheck: #MANDATORY

@EndUserText.label: '###GENERATED Core Data Service Entity'

@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true

@ObjectModel.sapObjectNodeType.name: 'ZAGR_MATERIAL000'

define root view entity ZAGR_C_MATERIAL
  provider contract transactional_query
  as projection on ZAGR_R_MATERIAL

  association [1..1] to ZAGR_R_MATERIAL as _BaseEntity on $projection.Productid = _BaseEntity.Productid

{
  key Productid,

      Description,

      @Semantics.amount.currencyCode: 'Currency'
      Price,

      @Consumption.valueHelpDefinition: [ { entity: { element: 'Currency', name: 'I_CurrencyStdVH' },
                                            useForValidation: true } ]
      Currency,

      @Semantics.imageUrl: true
      @Semantics.largeObject: { mimeType: 'MimeType',
                                fileName: 'FileName',
                                acceptableMimeTypes: [ 'image/jpeg' ] }
      
      FileContentList,
      @Semantics.largeObject: { mimeType: 'MimeType',
                                fileName: 'FileName',
                                acceptableMimeTypes: [ 'image/jpeg' ] }

      FileContent,
      FileName,
      MimeType,

      @Semantics.user.createdBy: true
      LocalCreatedBy,

      @Semantics.systemDateTime.createdAt: true
      LocalCreatedAt,

      @Semantics.user.localInstanceLastChangedBy: true
      LocalLastChangedBy,

      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      LocalLastChangedAt,

      @Semantics.systemDateTime.lastChangedAt: true
      LastChangedAt,

      _BaseEntity
}
