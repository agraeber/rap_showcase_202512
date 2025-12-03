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
ENDCLASS.



CLASS ZCL_AGR_ORDER_state_CREATOR IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    " clear data


    DATA new_order_statuss TYPE TABLE OF zagr_order_state.

    DELETE FROM zagr_order_state.

    new_order_statuss = VALUE #( client = sy-mandt
                                ( status = co_order_state-new        description = 'Neu angelegt' )
                                ( status = co_order_state-released   description = 'Freigegeben' )
                                ( status = co_order_state-inprocess     description = 'In Bearbeitung' )
                                ( status = co_order_state-cancelled     description = 'Storniert' )
                                ( status = co_order_state-shipped     description = 'Versendet' ) ).

    INSERT zagr_order_state FROM TABLE @new_order_statuss.

    COMMIT WORK.
    out->write( |Demo data generated for table ZAGR_ORDER_STATE. | ).
  ENDMETHOD.
ENDCLASS.
