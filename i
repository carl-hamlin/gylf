;==================================================================================================================================================================================================================

    section   .bss

    %include  "./b"
    %include  "./definitions/include.def"

;==================================================================================================================================================================================================================

    section   .data

    %include  "./raw.data/include.dat"

;==================================================================================================================================================================================================================

    section   .text

    %include  "./commands/i"
    %include  "./functions/i"

    %include  "./code/comms/send.to.world.asm"
