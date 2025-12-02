CLASS zcl_agr_customer_creator DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_AGR_CUSTOMER_CREATOR IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    " clear data

    TYPES ty_dataset TYPE zagr_customer.

    DATA new_customers TYPE TABLE OF zagr_customer.

    DELETE FROM zagr_customer.

    new_customers = VALUE #( ( customerid = '0001'  city = 'Hamburg'    name = 'Nordic Trading GmbH' )
                             ( customerid = '0002'  city = 'Berlin'     name = 'Capital Consulting AG' )
                             ( customerid = '0003'  city = 'Munich'     name = 'Bavaria Tech Solutions' )
                             ( customerid = '0004'  city = 'Cologne'    name = 'Rheinland Logistics KG' )
                             ( customerid = '0005'  city = 'Stuttgart'  name = 'Swabian Automotive Group' )
                             ( customerid = '0006'  city = 'Frankfurt'  name = 'Main Finance Partners' )
                             ( customerid = '0007'  city = 'Dresden'    name = 'Elbe Software Systems' )
                             ( customerid = '0008'  city = 'Leipzig'    name = 'Saxon Digital Services' )
                             ( customerid = '0009'  city = 'Bremen'     name = 'Hanseatic Marine Supplies' )
                             ( customerid = '0010' city = 'Hamburg'    name = 'Portline Global Logistics' ) ).

    INSERT zagr_customer FROM TABLE @new_customers.

    COMMIT WORK.
    out->write( |Demo data generated for table ZAGR_CUSTOMER. | ).
  ENDMETHOD.
ENDCLASS.
