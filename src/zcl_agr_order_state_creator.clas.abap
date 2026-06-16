CLASS zcl_agr_order_state_creator DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    CONSTANTS: BEGIN OF co_order_state,
                 new       TYPE zagr_order_state-status VALUE 'NEW' ##NO_TEXT,
                 released  TYPE zagr_order_state-status VALUE 'RELEASED' ##NO_TEXT,
                 inprocess TYPE zagr_order_state-status VALUE 'INPROCESS' ##NO_TEXT,
                 shipped   TYPE zagr_order_state-status VALUE 'SHIPPED' ##NO_TEXT,
                 cancelled TYPE zagr_order_state-status VALUE 'CANCELLED' ##NO_TEXT,
               END OF co_order_state.
    TYPES ty_dataset TYPE zagr_order_state.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS create_order_status
      IMPORTING
        i_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS create_orders
      IMPORTING
        i_out TYPE REF TO if_oo_adt_classrun_out.
ENDCLASS.



CLASS ZCL_AGR_ORDER_state_CREATOR IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    " clear data

    create_orders( out ).
    create_order_status( out ).
  ENDMETHOD.

  METHOD create_order_status.

    DATA new_order_statuses TYPE TABLE OF zagr_order_state.

    DELETE FROM zagr_order_state.

    new_order_statuses = VALUE #( client = sy-mandt
                                ( status = co_order_state-new        description = 'Neu angelegt' )
                                ( status = co_order_state-released   description = 'Freigegeben' )
                                ( status = co_order_state-inprocess     description = 'In Bearbeitung' )
                                ( status = co_order_state-cancelled     description = 'Storniert' )
                                ( status = co_order_state-shipped     description = 'Versendet' ) ).

    INSERT zagr_order_state FROM TABLE @new_order_statuses.

    COMMIT WORK.
    i_out->write( |Demo data generated for table ZAGR_ORDER_STATE. | ).

  ENDMETHOD.

  METHOD create_orders.
    DATA new_orders TYPE TABLE OF zagr_orderhd.

    DELETE FROM zagr_orderhd where salesorder_id ne '0001000001'.
    SELECT FROM zagr_orderhd FIELDS MAX( salesorder_id ) INTO @DATA(max_salesorder).

    new_orders = VALUE #( client = sy-mandt
                          status = co_order_state-new
                          ( salesorder_id = max_salesorder + 1
                            customer_id   = '0001' )
                          ( salesorder_id = max_salesorder + 2
                            customer_id   = '0002' ) ).
    INSERT zagr_orderhd FROM TABLE @new_orders.

    COMMIT WORK.
    i_out->write( |Demo data generated for table ZAGR_ORDERHD. | ).
  ENDMETHOD.

ENDCLASS.
