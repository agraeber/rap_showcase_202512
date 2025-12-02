CLASS zcl_agr_material_creator DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_AGR_MATERIAL_CREATOR IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    " clear data

    TYPES ty_dataset TYPE zagr_material.

    DATA new_materials TYPE TABLE OF zagr_material.

    DELETE FROM zagr_material.

    new_materials = VALUE #( currency = 'EUR'
                             ( productid = '1000' description = 'Laptop Pro 15" Business Edition' price = '1299.00' )
                             ( productid = '1001' description = 'Industrial Pump Model X500'      price = '4599.00' )
                             ( productid = '1002' description = 'Smart Sensor IoT v2.1'           price = '299.00' )
                             ( productid = '1003' description = 'High-Speed Router AX9000'        price = '199.00' )
                             ( productid = '1004' description = 'Electric Forklift E-Lift 3000'   price = '8999.00' )
                             ( productid = '1005' description = 'Solar Panel Kit 500W'            price = '799.00' )
                             ( productid = '1006' description = 'Industrial Drill ProMax'         price = '1499.00' )
                             ( productid = '1007' description = 'Smartphone Ultra X'              price = '999.00' )
                             ( productid = '1008' description = 'Warehouse Robot AutoMover'       price = '15999.00' )
                             ( productid = '1009' description = '3D Printer Precision 500'        price = '2499.00' ) ).

    INSERT zagr_material FROM TABLE @new_materials.

    COMMIT WORK.
    out->write( |Demo data generated for table ZAGR_MATERIAL. | ).
  ENDMETHOD.
ENDCLASS.
