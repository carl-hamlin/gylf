;=================================================================================================================================================================================================
;
;   dna.lab
;
;   This function combines the dna of two parent gylf to create a new gylf.
;
;   Assumptions:    Populated egg.data fields.
;
;   Returns:        Populated character fields.
;

dna.lab:                                    mov     ebx, egg.father                                     ; ebx - pointer to filename for father.
                                            call    open.descriptor                                     ; Associate a descriptor with the file for the father.

                                            push    eax                                                 ; Preserve the associated descriptor.

                                            mov     ebx, eax                                            ; ebx - descriptor associated with the father's character file.
                                            mov     ecx, character.father.data                          ; ecx - pointer to buffer into which to read the father's DNA.
                                            mov     edx, character.father.dna.l                         ; edx - length of the father's DNA.
                                            call    read.descriptor                                     ; Read the father's DNA into memory.

                                            pop     ebx                                                 ; ebx - descriptor associated with the father's character file.
                                            call    close.descriptor                                    ; Disassociate the descriptor.

                                            mov     ebx, egg.mother                                     ; ebx - pointer to filename for mother.
                                            call    open.descriptor                                     ; Associate a descriptor with the file for the mother.

                                            push    eax                                                 ; Preserve the associated descriptor.

                                            mov     ebx, eax                                            ; ebx - descriptor associated with the mother's character file.
                                            mov     ecx, character.mother.data                          ; ecx - pointer to buffer into which to read the mother's DNA.
                                            mov     edx, character.mother.dna.l                         ; edx - length of the mother's DNA.
                                            call    read.descriptor                                     ; Read the mother's DNA into memory.

                                            pop     ebx                                                 ; ebx - descriptor associated with the mother's character file.
                                            call    close.descriptor                                    ; Disassociate the descriptor.

dna.lab.base.color:                         sub     ebx, ebx                                            ; ebx - return ticks in eax.
                                            call    get.ticks                                           ; eax - ticks.

                                            cmp     al, 00h                                             ; Did we happen upon a zero lsb?
                                            jz      dna.lab.mutation.base.color                         ; YES! Go mutate the embryo!
    
                                            shr     al, 01h                                             ; Is the least significant bit high?
                                            jc      dna.lab.mother.base.color                           ; Yes. The embryo inherits its mother's base color.

dna.lab.father.base.color:                  mov     al, byte [character.father.base.color]              ; al - father's base color.
                                            mov     byte [character.base.color], al                     ; Give the embryo its father's base color.

                                            jmp     dna.lab.secondary.color                             ; Go see which parent the embryo will take afer in secondary coloring.

dna.lab.mother.base.color:                  mov     al, byte [character.mother.base.color]              ; al - mother's base color.
                                            mov     byte [character.base.color], al                     ; Give the embryo its mother's base color.

                                            jmp     dna.lab.secondary.color                             ; Go see which parent the embryo will take after in secondary coloring.

dna.lab.mutation.base.color:                cmp     ah, character.base.color.number                     ; Is ah higher than the total number of base colorings?
                                            ja      dna.lab.mutation.base.color.fix                     ; Yes. Go fix that.
                    
                                            mov     byte [character.base.color], ah                     ; Use ah as the mutation factor for the embryo's base coloring.

                                            jmp     dna.lab.secondary.color                             ; Go see which parent the embryo will take after in secondary coloring.

dna.lab.mutation.base.color.fix:            sub     ebx, ebx                                            ; ebx - return ticks in eax.
                                            call    get.ticks                                           ; eax - ticks.

                                            sub     ah, al                                              ; ah - potential mutation factore for the embryo's base coloring.
                                            jmp     dna.lab.mutation.base.color                         ; Go see if we can safely mutate the embryo yet.

dna.lab.secondary.color:                    sub     ebx, ebx                                            ; ebx - return ticks in eax.
                                            call    get.ticks                                           ; eax - ticks.

                                            cmp     al, 00h                                             ; Did we happen upon a zero lsb?
                                            jz      dna.lab.mutation.secondary.color                    ; YES! Go mutate the embryo!

                                            shr     al, 01h                                             ; Is the least significant bit high?
                                            jc      dna.lab.mother.base.color                           ; Yes. The embryo inherits its mother's secondary coloring.

dna.lab.father.secondary.color:             mov     al, byte [character.father.secondary.color]         ; al - father's secondary coloring.
                                            mov     byte [character.secondary.color], al                ; Give the embryo its father's secondary coloring.

                                            jmp     dna.lab.base.fur.quality                            ; Go see which parent the embryo will take after in fur quality.

dna.lab.mother.secondary.color:             mov     al, byte [character.mother.secondary.color]         ; al - mother's secondary coloring.
                                            mov     byte [character.secondary.color], al                ; Give the embryo its mother's secondary coloring.

                                            jmp     dna.lab.base.fur.quality                            ; Go see which parent the embryo will take after in fur quality.

dna.lab.mutation.secondary.color:           cmp     ah, character.secondary.color.number                ; Is ah higher than the total number of secondary colorings?
                                            ja      dna.lab.mutation.secondary.color.fix                ; Yes. Go fix that.
                    
                                            mov     byte [character.secondary.color], ah                ; Use ah as the mutation factor for the embryo's secondary coloring.

                                            jmp     dna.lab.base.fur.quality                            ; Go see which parent the embryo will take after in fur quality.

dna.lab.mutation.secondary.color.fix:       sub     ebx, ebx                                            ; ebx - return ticks in eax.
                                            call    get.ticks                                           ; eax - ticks.

                                            sub     ah, al                                              ; ah - potential mutation factor for embryo's secondary coloring.
                                            jmp     dna.lab.mutation.secondary.color                    ; Go see if we can safely mutate the embryo yet.

dna.lab.base.fur.quality:                   sub     ebx, ebx                                            ; ebx - return ticks in eax.
                                            call    get.ticks                                           ; eax - ticks.

                                            cmp     al, 00h                                             ; Did we happen upon a zero lsb?
                                            jz      dna.lab.mutation.base.fur.quality                   ; YES! Go mutate the embryo!

                                            shr     al, 01h                                             ; Is the least significant bit high?
                                            jc      dna.lab.mother.base.fur.quality                     ; Yes. The embryo inherits its mother's base fur quality.

dna.lab.father.base.fur.quality:            mov     al, byte [character.father.base.fur.quality]        ; al - father's base fur quality.
                                            mov     byte [character.base.fur.quality], al               ; Give the embryo its father's base fur quality.

                                            jmp     dna.lab.secondary.fur.quality                       ; Go see which parent the embryo will take after in secondary fur quality.

dna.lab.mother.base.fur.quality:            mov     al, byte [character.mother.base.fur.quality]        ; al - mother's base fur quality.
                                            mov     byte [character.base.fur.quality], al               ; Give the embryo its mother's base fur quality.

                                            jmp     dna.lab.secondary.fur.quality                       ; Go see which parent the embryo will take after in secondary fur quality.

dna.lab.mutation.base.fur.quality:          cmp     ah, character.base.fur.quality.number               ; Is ah higher than the total number of base fur qualities?
                                            ja      dna.lab.mutation.base.fur.quality.fix               ; Yes. Go fix that.

                                            mov     byte [character.base.fur.quality], ah               ; Use ah as the mutation factor for the embryo's base fur quality.

                                            jmp     dna.lab.secondary.fur.quality                       ; Go see which parent the embryo will take after in secondary fur quality.

dna.lab.mutation.base.fur.quality.fix:      sub     ebx, ebx                                            ; ebx - return ticks in eax.
                                            call    get.ticks                                           ; eax - ticks.

                                            sub     ah, al                                              ; ah - potential mutation factor for embryo's base fur quality.
                                            jmp     dna.lab.mutation.base.fur.quality                   ; Go see if we can safely mutate the embryo yet.

dna.lab.secondary.fur.quality:              sub     ebx, ebx                                            ; ebx - return ticks in eax.
                                            call    get.ticks                                           ; eax - ticks.

                                            cmp     al, 00h                                             ; Did we happen upon a zero lsb?
                                            jz      dna.lab.mutation.secondary.fur.quality              ; YES! Go mutate the embryo!

                                            shr     al, 01h                                             ; Is the least significant bit high?
                                            jc      dna.lab.mother.secondary.fur.quality                ; Yes. The embryo inherits its mother's secondary fur quality.

dna.lab.father.secondary.fur.quality:       mov     al, byte [character.father.secondary.fur.quality]   ; al - father's secondary fur quality.
                                            mov     byte [character.secondary.fur.quality], al          ; Give the embryo its father's secondary fur quality.

                                            jmp     dna.lab.strength                                    ; Go compute the embryo's base strength.

dna.lab.mother.secondary.fur.quality:       mov     al, byte [character.mother.secondary.fur.quality]   ; al - mother's secondary fur quality.
                                            mov     byte [character.secondary.fur.quality], al          ; Give the embryo its mother's secondary fur quality.

                                            jmp     dna.lab.strength                                    ; Go compute the embryo's base strength.

dna.lab.mutation.secondary.fur.quality:     cmp     ah, character.secondary.fur.quality.number          ; Is ah higher than the total number of secondary fur qualities?
                                            ja      dna.lab.mutation.secondary.fur.quality.fix          ; Yes. Go fix that.

                                            mov     [character.secondary.fur.quality], ah               ; Use ah as the mutation factor for the embryo's secondary fur quality.

                                            jmp     dna.lab.strength                                    ; Go compute the embryo's base strength.

dna.lab.mutation.secondary.fur.quality.fix: sub     ebx, ebx                                            ; ebx - return ticks in eax.
                                            call    get.ticks                                           ; eax - ticks.

                                            sub     ah, al                                              ; ah - potential mutation factor for embryo's secondary fur quality.
                                            jmp     dna.lab.mutation.secondary.fur.quality              ; Go see if we can safely mutate the embryo yet.

dna.lab.strength:                           mov     al, byte [character.father.strength]                ; al - father's strength.
                                            mov     ah, byte [character.mother.strength]                ; ah - mother's strength.

                                            add     al, ah                                              ; al - the sum of both strengths.
                                            sub     ah, ah                                              ; ah - prepared for averaging.
                                            mov     dl, number.of.parents                               ; dl - number of contributing parents.
                                            div     dl                                                  ; al - average of parental strengths.

                                            sub     ah, ah                                              ; ah - prepared for conversion to embryonic strength.
                                            mov     dl, child.attribute.computation.factor              ; dl - arbitrary factor for attribute conversion.
                                            div     dl                                                  ; al - embryonic strength.

                                            mov     byte [character.strength], al                       ; Assign embryonic strength value to embryo.

dna.lab.endurance:                          mov     al, byte [character.father.endurance]               ; al - father's endurance.
                                            mov     ah, byte [character.mother.endurance]               ; ah - mother's endurance.

                                            add     al, ah                                              ; al - the sum of both endurancii.
                                            sub     ah, ah                                              ; ah - prepared for averaging.
                                            mov     dl, number.of.parents                               ; dl - number of contributing parents.
                                            div     dl                                                  ; al - average of parental endurancii.

                                            sub     ah, ah                                              ; ah - prepared for conversion to embryonic endurance.
                                            mov     dl, child.attribute.computation.factor              ; dl - arbitrary factor for attribute conversion.
                                            div     dl                                                  ; al - embryonic endurance.

                                            mov     byte [character.endurance], al                      ; Assign embryonic endurance value to embryo.

dna.lab.agility:                            mov     al, byte [character.father.agility]                 ; al - father's agility.
                                            mov     ah, byte [character.mother.agility]                 ; ah - mother's agility.

                                            add     al, ah                                              ; al - the sum of both agilities.
                                            sub     ah, ah                                              ; ah - prepared for averaging.
                                            mov     dl, number.of.parents                               ; dl - number of contributing parents.
                                            div     dl                                                  ; al - average of parental agilities.

                                            sub     ah, ah                                              ; ah - prepared for conversion to embryonic agility.
                                            mov     dl, child.attribute.computation.factor              ; dl - arbitrary factor for attribute conversion.
                                            div     dl                                                  ; al - embryonic agility.

                                            mov     byte [character.agility], al                        ; Assign embryonic agility to embryo.

                                            ret                                                         ; Return to caller.
