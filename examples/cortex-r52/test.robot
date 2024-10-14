*** Variables ***
${UART0}                            sysbus.uart0

*** Keywords ***
Create Machine
    Execute Command                 mach create
    Execute Command                 machine LoadPlatformDescription @platforms/cpus/cortex-r52.repl

Wait For Lines Per Thread
    [Arguments]                     @{lines}  ${testerId}
    FOR  ${thread}  IN RANGE  1  8
        ${id}=                          Evaluate  str(${thread}+1)
        ${prio}=                        Evaluate  str(31-${thread})
        ${thread}=                      Evaluate  str(${thread})
        FOR  ${line}  IN  @{lines}
            ${line}=                        Replace String  ${line}  %THREAD%  ${thread}
            ${line}=                        Replace String  ${line}  %ID%  ${id}
            ${line}=                        Replace String  ${line}  %PRIO%  ${prio}
            Wait For Line On Uart           ${line}  treatAsRegex=true  testerId=${testerId}
        END
    END

Wait For Hello Sample
    [Arguments]                     ${testerId}  ${cpu}=0
    Wait For Line On Uart           HiRTOS running on CPU ${cpu}  testerId=${testerId}

    Wait For Line On Uart           FVP ARMv8-R Hello running on CPU ${cpu}  testerId=${testerId}
    Wait For Line On Uart           HiRTOS: Thread scheduler started  testerId=${testerId}
    Wait For Line On Uart           HiRTOS: Timer thread started  testerId=${testerId}

    # First, check if all threads have been started
    Wait For Lines Per Thread       Thread %THREAD% \\(id %ID%, prio %PRIO%\\): .* Wakeups 1  testerId=${testerId}

    Wait For Line On Uart           HiRTOS: Idle thread started  testerId=${testerId}

    # Then, make sure each of them has been woken up at least once
    Wait For Lines Per Thread       Thread %THREAD% \\(id %ID%, prio %PRIO%\\): .* Wakeups [^1]\d*  testerId=${testerId}


*** Test Cases ***
Should Run Hello Sample On One Core
    Create Machine
    ${tester}=                      Create Terminal Tester  ${UART0}  defaultPauseEmulation=true
    Execute Command                 sysbus LoadELF @${EXECDIR}/${ELF}

    Wait For Hello Sample           ${tester}
