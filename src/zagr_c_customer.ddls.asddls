@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@Endusertext: {
  Label: '###GENERATED Core Data Service Entity'
}
@Objectmodel: {
  Sapobjectnodetype.Name: 'ZAGR_CUSTOMER'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZAGR_C_CUSTOMER
  provider contract TRANSACTIONAL_QUERY
  as projection on ZAGR_R_CUSTOMER
  association [1..1] to ZAGR_R_CUSTOMER as _BaseEntity on $projection.CUSTOMERID = _BaseEntity.CUSTOMERID
{
  key Customerid,
  Name,
  City,
  Country,
  Filecontent,
  Filename,
  Mimetype,
  @Semantics: {
    User.Createdby: true
  }
  LocalCreatedBy,
  @Semantics: {
    Systemdatetime.Createdat: true
  }
  LocalCreatedAt,
  @Semantics: {
    User.Localinstancelastchangedby: true
  }
  LocalLastChangedBy,
  @Semantics: {
    Systemdatetime.Localinstancelastchangedat: true
  }
  LocalLastChangedAt,
  @Semantics: {
    Systemdatetime.Lastchangedat: true
  }
  LastChangedAt,
  _BaseEntity
}
