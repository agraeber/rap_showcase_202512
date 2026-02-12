@AccessControl.authorizationCheck: #MANDATORY

@EndUserText.label: '###GENERATED Core Data Service Entity'

@Metadata.allowExtensions: true

@ObjectModel.sapObjectNodeType.name: 'ZAGR_MATERIAL000'

define root view entity ZAGR_R_MATERIAL
  as select from zagr_material as Material

{
  key productid             as Productid,

      description           as Description,

      @Semantics.amount.currencyCode: 'Currency'
      price                 as Price,

      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_CurrencyStdVH', element: 'Currency' },
                                            useForValidation: true } ]
      currency              as Currency,

      @Semantics.largeObject: { mimeType: 'MimeType',
                                fileName: 'FileName',
                                acceptableMimeTypes: [ 'image/jpeg' ] }
      filecontent           as FileContent,

      @Semantics.largeObject: { mimeType: 'MimeType',
                                fileName: 'FileName',
                                acceptableMimeTypes: [ 'image/jpeg' ] }
      filecontent           as FileContentList,

      filename              as FileName,

      @Semantics.mimeType: true
      mimetype              as MimeType,

      @Semantics.user.createdBy: true
      local_created_by      as LocalCreatedBy,

      @Semantics.systemDateTime.createdAt: true
      local_created_at      as LocalCreatedAt,

      @Semantics.user.localInstanceLastChangedBy: true
      local_last_changed_by as LocalLastChangedBy,

      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,

      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at       as LastChangedAt
}
