    include "unit_tests.inc"

    UNITTEST_INITIALIZE
    ; initialize
    ret

    module TestSuite_ScreenLib    

UT_test1:
    ld  hl,$8976
    nop ; ASSERTION HL == 6
  TC_END

    endmodule