*"* use this source file for your ABAP unit test classes
CLASS ltcl_ZAGR_R_Order01TP DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    CLASS-METHODS class_setup.
    CLASS-METHODS class_teardown.

    DATA mapped        TYPE RESPONSE FOR MAPPED EARLY ZAGR_r_Order01TP.
    DATA failed        TYPE RESPONSE FOR FAILED EARLY ZAGR_r_Order01TP.
    DATA reported      TYPE RESPONSE FOR REPORTED EARLY ZAGR_r_Order01TP.
    DATA failed_late   TYPE RESPONSE FOR FAILED LATE ZAGR_r_Order01TP.
    DATA reported_late TYPE RESPONSE FOR REPORTED LATE ZAGR_r_Order01TP.

    CLASS-DATA class_under_test     TYPE REF TO lhc_order.
    CLASS-DATA sql_test_environment TYPE REF TO if_osql_test_environment.

    METHODS setup.
    METHODS teardown.
    METHODS t001_set_to_new FOR TESTING RAISING cx_static_check.
ENDCLASS.


CLASS ltcl_ZAGR_R_Order01TP IMPLEMENTATION.
  METHOD class_setup.
    CREATE OBJECT class_under_test FOR TESTING.

    sql_test_environment = cl_osql_test_environment=>create( i_dependency_list = VALUE #( ( 'ZAGR_r_Order01TP' ) ) ).

  ENDMETHOD.

  METHOD setup.
    sql_test_environment->clear_doubles( ).

    CLEAR mapped.
    CLEAR failed.
    CLEAR reported.
    CLEAR failed_late.
    CLEAR reported_late.
  ENDMETHOD.

  METHOD t001_set_to_new.
    DATA order  TYPE ZAGR_r_Order01TP.
    DATA orders TYPE STANDARD TABLE OF ZAGR_r_Order01TP.

    order = VALUE ZAGR_r_Order01TP( SalesorderID = '123' ).

    orders = VALUE #( ( order ) ).
    sql_test_environment->insert_test_data( orders ).

    class_under_test->settonew(
      EXPORTING keys     = VALUE #( ( %is_draft = if_abap_behv=>mk-off  SalesorderID = order-SalesorderID ) )
      CHANGING  reported = reported ).

    READ ENTITIES OF ZAGR_r_Order01TP IN LOCAL MODE
         ENTITY Order
         ALL FIELDS
         WITH VALUE #( ( %key-SalesorderID = '123' ) )
         RESULT FINAL(read_orders).

    FINAL(read_order) = read_orders[ 1 ].

    " Check that only %tky and %state_area is filled
    cl_abap_unit_assert=>assert_equals( exp = if_abap_behv=>mk-off
                                        act = read_order-%is_draft    ).
    cl_abap_unit_assert=>assert_equals( exp = order-SalesorderID
                                        act = read_order-SalesorderID ).
    cl_abap_unit_assert=>assert_equals( exp = zcl_agr_order_state_creator=>co_order_state-new
                                        act = read_order-Status ).
  ENDMETHOD.

  METHOD class_teardown.
    sql_test_environment->destroy( ).
  ENDMETHOD.


  METHOD teardown.
    ROLLBACK ENTITIES.                                 "#EC CI_ROLLBACK
  ENDMETHOD.

ENDCLASS.
