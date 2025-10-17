*** Variables ***
${DMA_PERIHPERAL}                   dma
${LINUX_PLATFORM}                   ${CURDIR}/platform_linux.resc
${LINUX_PROMPT}                     zynq>
${LINUX_UART}                       sysbus.uart1
${FASTVDMA_DRIVER}                  /lib/modules/5.10.0-xilinx/kernel/drivers/dma/fastvdma/fastvdma.ko
${FASTVDMA_DEMO_DRIVER}             /lib/modules/5.10.0-xilinx/kernel/drivers/dma/fastvdma/fastvdma-demo.ko

*** Keywords ***
Set Search Path
    @{_RENODE_SEARCH_PATHS_LIST}    Split String  ${_RENODE_SEARCH_PATHS}  separator=:
    FOR  ${path}  IN  @{_RENODE_SEARCH_PATHS_LIST}
        Execute Command             path add "${path}"
    END

Set Resc Variables
    Set Search Path
    Execute Command                 $bin = "${bin}"
    Execute Command                 $rootfs = "${rootfs}"
    Execute Command                 $dtb = "${dtb}"
    Execute Command                 $dma_verilated = "${dma_verilated}"

Create Machine
    Execute Command                 include @${LINUX_PLATFORM}

Compare Parts Of Images On Linux
    [Arguments]                     ${img0}  ${img1}  ${count}  ${skip0}  ${skip1}

    Write Line To Uart              dd if=${img0} of=test.rgba bs=128 count=${count} skip=${skip0}
    Wait For Prompt On Uart         ${LINUX_PROMPT}
    Write Line To Uart              dd if=${img1} of=otest.rgba bs=128 count=${count} skip=${skip1}
    Wait For Prompt On Uart         ${LINUX_PROMPT}

    Write Line To Uart              cmp test.rgba otest.rgba
    Wait For Prompt On Uart         ${LINUX_PROMPT}

# Check if exit status is 0 (the input files are the same)
    Write Line To Uart              echo $?
    Wait For Line On Uart           0     timeout=2
    Wait For Prompt On Uart         ${LINUX_PROMPT}

Test DMA Driver On Linux
    Start Emulation

    Wait For Prompt On Uart         ${LINUX_PROMPT}  timeout=30

# Suppress messages from kernel space
    Write Line To Uart              echo 0 > /proc/sys/kernel/printk
    Wait For Prompt On Uart         ${LINUX_PROMPT}

# Write Line To Uart for some reason breaks this line into two.
    Write To Uart                   insmod ${FASTVDMA_DRIVER} ${\n}
    Wait For Prompt On Uart         ${LINUX_PROMPT}

    Write To Uart                   insmod ${FASTVDMA_DEMO_DRIVER} ${\n}
    Wait For Prompt On Uart         ${LINUX_PROMPT}

    Write Line To Uart              lsmod
    Wait For Line On Uart           Module
    Wait For Line On Uart           fastvdma_demo
    Wait For Line On Uart           fastvdma
    Wait For Prompt On Uart         ${LINUX_PROMPT}

    Write Line To Uart              ./demo
    Wait For Prompt On Uart         ${LINUX_PROMPT}  timeout=20

    Write Line To Uart              chmod +rw out.rgba
    Wait For Prompt On Uart         ${LINUX_PROMPT}  timeout=20

    Compare Parts Of Images On Linux  img0.rgba  out.rgba  2048  0  0
    FOR  ${i}  IN RANGE  8
        Compare Parts Of Images On Linux  img0.rgba  out.rgba  4  ${2048 + ${i} * 16}  ${2048 + ${i} * 16}
        Compare Parts Of Images On Linux  img1.rgba  out.rgba  8  ${${i} * 8}  ${2052 + ${i} * 16}
        Compare Parts Of Images On Linux  img0.rgba  out.rgba  4  ${2060 + ${i} * 16}  ${2060 + ${i} * 16}
    END
    Compare Parts Of Images On Linux  img0.rgba  out.rgba  2052  6140  6140

Should Boot Linux And User DMA
    [Arguments]                     ${peripheral}
    Create Machine
    Create Terminal Tester          ${LINUX_UART}

    Test DMA Driver On Linux


*** Test Cases ***
Should Boot Linux And User DMA In Verilator
    [Tags]                          verilator
    Set Resc Variables
    Should Boot Linux And User DMA  ${DMA_PERIHPERAL}
