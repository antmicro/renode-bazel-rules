*** Settings ***
Documentation                 Testing the NXP K64F platform
Suite Setup                   Setup
Suite Teardown                Teardown
Test Setup                    Reset Emulation
Resource                      ${RENODEKEYWORDS}

*** Variables ***
${UART}                       sysbus.uart0
${URI}                        @https://dl.antmicro.com/projects/renode

*** Keywords ***
Create Machine
    [Arguments]  ${elf}

    Execute Command           mach create
    Execute Command           machine LoadPlatformDescription @platforms/cpus/nxp-k6xf.repl

    Execute Command           sysbus LoadELF ${URI}/${elf}

    Create Terminal Tester    ${UART}

*** Test Cases ***
Should Run Zephyr Tests for UART
    [Documentation]           Runs Zephyr's basic uart tests
    Create Machine            ${mach_arg}

    Start Emulation
    Wait For Line On Uart     Please send characters to serial console    
    Write Line To Uart        The quick brown fox jumps over the lazy dog
    Wait For Line On Uart     Please send characters to serial console    
    Write Line To Uart        The quick brown fox jumps over the lazy dog
    Wait For Line On Uart     PROJECT EXECUTION SUCCESSFUL
