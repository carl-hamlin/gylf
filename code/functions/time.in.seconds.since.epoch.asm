;====================================================================================================================================================================================================
;
;   time.in.seconds.since.epoch
;
;   This function returns the time in seconds since the epoch.
;
;   Assumptions:    ebx - null if results to be included in eax.
;                   ebx - pointer to buffer for results if results not only to be included in eax.
;
;   Returns:        eax - time in seconds since the epoch.
;                   [ebx] - time in seconds since the epoch if function entered with non-null ebx.
;

    time.in.seconds.since.epoch: mov eax, sys.get.time.in.seconds.since.the.epoch ; eax - get time in seconds since the epoch.
                                 int sys.system.call                              ; Get time in seconds since the epoch.

                                 ret                                              ; Return to caller.
