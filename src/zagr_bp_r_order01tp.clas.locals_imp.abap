CLASS ltcl_ZAGR_R_Order01TP DEFINITION DEFERRED FOR TESTING.
CLASS lsc_order DEFINITION INHERITING FROM cl_abap_behavior_saver.

  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.
ENDCLASS.

CLASS lsc_order IMPLEMENTATION.
  METHOD save_modified.
    IF create IS NOT INITIAL.
      LOOP AT create-order REFERENCE INTO DATA(created_order).

        RAISE ENTITY EVENT ZAGR_R_Order01TP~created
              FROM VALUE #( ( %key   = created_order->%key
                              %param = CORRESPONDING #( created_order->%key ) ) ).
      ENDLOOP.
    ENDIF.

    IF update IS NOT INITIAL.
      LOOP AT update-order REFERENCE INTO DATA(updated_order).

        RAISE ENTITY EVENT ZAGR_R_Order01TP~updated
              FROM VALUE #( ( %key   = updated_order->%key ) ).
      ENDLOOP.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
CLASS lhc_order DEFINITION INHERITING FROM cl_abap_behavior_handler
FRIENDS ltcl_ZAGR_R_Order01TP.
  PRIVATE SECTION.

    TYPES: tty_action_result TYPE TABLE FOR ACTION RESULT ZAGR_R_Order01TP\\Order~SetToNew.

    CLASS-METHODS set_status
      IMPORTING i_keys     TYPE any
                i_status   TYPE any
      EXPORTING
                e_failed   TYPE any
                e_reported TYPE any
                e_result   TYPE tty_action_result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING
      REQUEST requested_authorizations FOR Order
      RESULT result.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Order RESULT result.
    METHODS SetToNew FOR MODIFY
      IMPORTING keys FOR ACTION Order~SetToNew RESULT result.
    METHODS SetInProcess FOR MODIFY
      IMPORTING keys FOR ACTION Order~SetInProcess RESULT result.
    METHODS Release FOR MODIFY
      IMPORTING keys FOR ACTION Order~Release RESULT result.
    METHODS Ship FOR MODIFY
      IMPORTING keys FOR ACTION Order~Ship RESULT result.
    METHODS Cancel FOR MODIFY
      IMPORTING keys FOR ACTION Order~Cancel RESULT result.
ENDCLASS.

CLASS lhc_order IMPLEMENTATION.
  METHOD get_global_authorizations.
    result = VALUE #( %update      = if_abap_behv=>auth-allowed
                      %action-edit = if_abap_behv=>auth-allowed
                      %delete      = if_abap_behv=>auth-allowed
                      %create      = if_abap_behv=>auth-allowed ).
  ENDMETHOD.

  METHOD get_instance_features.
    " -------------------------------------------------------------------------
    " Instance-based dynamic feature control
    " -------------------------------------------------------------------------
    " read relevant travel instance data
    READ ENTITIES OF ZAGR_R_Order01TP IN LOCAL MODE
         ENTITY Order
         FIELDS ( SalesorderID Status )
         WITH CORRESPONDING #( keys )
         RESULT FINAL(orders)
         FAILED failed.

    " evaluate the conditions, set the operation state, and set result parameter
    result = VALUE #(
        FOR order IN orders
        ( %tky                 = order-%tky

          %features-%update    = COND #( WHEN order-Status <> zcl_agr_order_state_creator=>co_order_state-new
                                          AND order-Status <> ''
                                         THEN if_abap_behv=>fc-o-disabled
                                         ELSE if_abap_behv=>fc-o-enabled   )
          %features-%delete    = COND #( WHEN order-Status = zcl_agr_order_state_creator=>co_order_state-new
                                          AND order-Status = zcl_agr_order_state_creator=>co_order_state-cancelled
                                          AND order-Status = ''
                                         THEN if_abap_behv=>fc-o-disabled
                                         ELSE if_abap_behv=>fc-o-enabled   )
          %action-Edit         = COND #( WHEN order-Status <> zcl_agr_order_state_creator=>co_order_state-new
                                          AND order-Status <> ''
                                         THEN if_abap_behv=>fc-o-disabled
                                         ELSE if_abap_behv=>fc-o-enabled   )
          %action-SetToNew     = COND #( WHEN order-Status <> zcl_agr_order_state_creator=>co_order_state-released
                                          AND order-Status <> ''
                                         THEN if_abap_behv=>fc-o-disabled
                                         ELSE if_abap_behv=>fc-o-enabled   )
          %action-Release      = COND #( WHEN order-Status <> zcl_agr_order_state_creator=>co_order_state-new
                                         THEN if_abap_behv=>fc-o-disabled
                                         ELSE if_abap_behv=>fc-o-enabled   )
          %action-SetInProcess = COND #( WHEN order-Status <> zcl_agr_order_state_creator=>co_order_state-released
                                         THEN if_abap_behv=>fc-o-disabled
                                         ELSE if_abap_behv=>fc-o-enabled   )
          %action-Ship         = COND #( WHEN order-Status <> zcl_agr_order_state_creator=>co_order_state-inprocess
                                         THEN if_abap_behv=>fc-o-disabled
                                         ELSE if_abap_behv=>fc-o-enabled   )
          %action-Cancel       = COND #( WHEN order-Status <> zcl_agr_order_state_creator=>co_order_state-shipped
                                         THEN if_abap_behv=>fc-o-disabled
                                         ELSE if_abap_behv=>fc-o-enabled   ) ) ).
  ENDMETHOD.

  METHOD settonew.

    set_status( i_keys = keys i_status = zcl_agr_order_state_creator=>co_order_state-new ).


  ENDMETHOD.

  METHOD Cancel.
    set_status( i_keys = keys i_status = zcl_agr_order_state_creator=>co_order_state-cancelled ).
  ENDMETHOD.

  METHOD setinprocess.
    set_status( i_keys = keys i_status = zcl_agr_order_state_creator=>co_order_state-inprocess ).
  ENDMETHOD.




  METHOD release.
    set_status( i_keys = keys i_status = zcl_agr_order_state_creator=>co_order_state-released ).
  ENDMETHOD.


  METHOD ship.
    set_status( i_keys = keys i_status = zcl_agr_order_state_creator=>co_order_state-shipped ).

  ENDMETHOD.
  METHOD set_status.
    READ ENTITIES OF ZAGR_R_Order01TP IN LOCAL MODE
         ENTITY Order
         FIELDS ( Status )
         WITH CORRESPONDING #( i_keys )
         RESULT DATA(Orders_Before).

    MODIFY ENTITIES OF ZAGR_R_Order01TP IN LOCAL MODE
           ENTITY Order
           UPDATE FIELDS ( Status )
           WITH VALUE #( FOR order IN Orders_Before
                         ( %tky   = order-%tky
                           Status = i_status ) )
           FAILED e_failed
           REPORTED e_reported.

    " read changed data for action result
    READ ENTITIES OF ZAGR_R_Order01TP IN LOCAL MODE
         ENTITY Order
         ALL FIELDS WITH
         CORRESPONDING #( i_keys )
         RESULT FINAL(Orders_After).

    " set the action result parameter
    e_result = VALUE #( FOR Order IN Orders_After
                      ( %tky   = Order-%tky
                        %param = Order ) ).


  ENDMETHOD.

ENDCLASS.
