CLASS lhc_order DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS: get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
        REQUEST requested_authorizations FOR Order
        RESULT result,
             get_instance_features FOR INSTANCE FEATURES
                   IMPORTING keys REQUEST requested_features FOR Order RESULT result.
ENDCLASS.

CLASS lhc_order IMPLEMENTATION.
  METHOD get_global_authorizations.
    result = VALUE #( %update      = if_abap_behv=>auth-allowed
                      %action-edit = if_abap_behv=>auth-allowed
                      %delete      = if_abap_behv=>auth-allowed
                      %create      = if_abap_behv=>auth-allowed ).
  ENDMETHOD.


  METHOD get_instance_features.
  ENDMETHOD.

ENDCLASS.
