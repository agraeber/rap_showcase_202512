*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

CLASS event_handler DEFINITION INHERITING FROM cl_abap_behavior_event_handler.

  PUBLIC SECTION.
  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS created FOR ENTITY EVENT created_orders FOR Order~created.

ENDCLASS.

CLASS event_handler IMPLEMENTATION.
  METHOD created.
    MODIFY ENTITY ZAGR_R_Order01TP
           EXECUTE SetToNew FROM VALUE  #( FOR key IN created_orders
                            ( %key          = key-%key ) )
           FAILED FINAL(failed_create)
           REPORTED FINAL(reported_create) ##NEEDED.

  ENDMETHOD.


ENDCLASS.
