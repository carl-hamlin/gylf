;==================================================================================================================================================================================================================

    section   .bss

    %include  "./definitions/include.def"

;==================================================================================================================================================================================================================

    section   .data

    %include  "./raw.data/include.dat"

;==================================================================================================================================================================================================================

    section   .text

    %include  "./commands/i"
    %include  "./functions/i"

    %include  "./code/comms/send.to.area.asm"
    %include  "./code/comms/send.to.player.asm"
    %include  "./code/comms/send.to.world.asm"

    %include  "./code/functions/set.up.listener.asm"
    %include  "./code/functions/system.check.asm"
    %include  "./code/functions/time.in.seconds.since.epoch.asm"
    %include  "./code/functions/write.bad.command.error.asm"
    %include  "./code/functions/write.bad.help.command.error.asm"
    %include  "./code/functions/write.descriptor.asm"
    %include  "./code/functions/write.prompt.asm"
    %include  "./code/functions/write.welcome.asm"

    %include  "./code/socket/accept.socket.asm"
    %include  "./code/socket/active.socket.poll.asm"
    %include  "./code/socket/answer.active.socket.asm"
    %include  "./code/socket/bind.socket.asm"
    %include  "./code/socket/clean.socket.asm"
    %include  "./code/socket/create.socket.asm"
    %include  "./code/socket/listening.socket.poll.asm"
    %include  "./code/socket/listen.socket.asm"
    %include  "./code/socket/recv.from.socket.asm"
    %include  "./code/socket/socket.errors.asm"
    %include  "./code/socket/socket.send.asm"
