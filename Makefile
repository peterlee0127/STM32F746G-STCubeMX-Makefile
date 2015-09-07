TARGET=demo.hex
EXECUTABLE=demo.elf

CC=arm-none-eabi-gcc
LD=arm-none-eabi-ld
#LD=arm-none-eabi-gcc
AR=arm-none-eabi-ar
AS=arm-none-eabi-as
CP=arm-none-eabi-objcopy
OD=arm-none-eabi-objdump

BIN=$(CP) -O ihex

# ..\inc;..\STemWin_Addons;
# ..\Config;
# ..\Core\inc;
# ..\STemWin_Addons;
# ..\Modules\vnc_server;
# ..\..\..\..\Utilities\CPU;
# ..\..\..\..\Drivers\CMSIS\Include;
# ..\..\..\..\Drivers\CMSIS\Device\ST\STM32F7xx\Include;
# ..\..\..\..\Drivers\STM32F7xx_HAL_Driver\Inc;
# ..\..\..\..\Drivers\BSP\STM32746G-Discovery;
# ..\..\..\..\Drivers\BSP\Components;
# ..\..\..\..\Drivers\BSP\Components\Common;
# ..\..\..\..\Middlewares\ST\STM32_USB_Host_Library\Core\Inc;
# ..\..\..\..\Middlewares\ST\STM32_USB_Host_Library\Class\MSC\Inc;
# ..\..\..\..\Middlewares\ST\STM32_USB_Device_Library\Class\MSC\Inc;
# ..\..\..\..\Middlewares\Third_Party\LwIP\src\include\;
# ..\..\..\..\Middlewares\Third_Party\LwIP\src\include\ipv4                                                              ;..\..\..\..\Middlewares\Third_Party\LwIP\system;..\..\..\..\Middlewares\Third_Party\LwIP\system\OS;..\..\..\..\Middlewares\ST\STemWin\inc;..\..\..\..\Middlewares\Third_Party\FatFs\src;
# ..\..\..\..\Middlewares\Third_Party\FatFs\src\drivers;
# ..\..\..\..\Middlewares\Third_Party\FreeRTOS\Source\portable\RVDS\ARM_CM7\r0p1;
# ..\..\..\..\Middlewares\Third_Party\FreeRTOS\Source\include;
# ..\..\..\..\Middlewares\Third_Party\FreeRTOS\Source\CMSIS_RTOS;
# ..\Modules\audio_player\Addons\SpiritDSP_Equalizer;
# ..\Modules\audio_player\Addons\SpiritDSP_LoudnessControl


HAL_Driver_Dir = ./Drivers/STM32F7xx_HAL_Driver
BSP_Components_Dir = ./Drivers/BSP/Components

DEFS = -DSTM32F746xx -DUSE_HAL_DRIVER -DSTM32F746xx

# -c --cpu Cortex-M7.fp.sp --fpu=FPv4-SP -D__MICROLIB -g -O3 --apcs=interwork --split_sections
# -I..\inc
# -I..\STemWin_Addons
# -I..\Config
# -I..\Core\inc
# -I..\STemWin_Addons
# -I..\Modules\vnc_server
# -I..\..\..\..\Utilities\CPU
# -I..\..\..\..\Drivers\CMSIS\Include
# -I..\..\..\..\Drivers\CMSIS\Device\ST\STM32F7xx\Include
# -I..\..\..\..\Drivers\STM32F7xx_HAL_Driver\Inc
#  -I..\..\..\..\Drivers\BSP\STM32746G-Discovery
#  -I..\..\..\..\Drivers\BSP\Components
#  -I..\..\..\..\Drivers\BSP\Components\Common
#  -I..\..\..\..\Middlewares\ST\STM32_USB_Host_Library\Core\Inc
#  -I..\..\..\..\Middlewares\ST\STM32_USB_Host_Library\Class\MSC\Inc
#   -I..\..\..\..\Middlewares\ST\STM32_USB_Device_Library\Class\MSC\Inc
#   -I..\..\..\..\Middlewares\Third_Party\LwIP\src\include\
#   -I..\..\..\..\Middlewares\Third_Party\LwIP\src\include\ipv4
#   -I..\..\..\..\Middlewares\Third_Party\LwIP\system
#   -I..\..\..\..\Middlewares\Third_Party\LwIP\system\OS
#   -I..\..\..\..\Middlewares\ST\STemWin\inc
#   -I..\..\..\..\Middlewares\Third_Party\FatFs\src
#   -I..\..\..\..\Middlewares\Third_Party\FatFs\src\drivers
#    -I..\..\..\..\Middlewares\Third_Party\FreeRTOS\Source\portable\RVDS\ARM_CM7\r0p1
#    -I..\..\..\..\Middlewares\Third_Party\FreeRTOS\Source\include
#    -I..\..\..\..\Middlewares\Third_Party\FreeRTOS\Source\CMSIS_RTOS
#    -I..\Modules\audio_player\Addons\SpiritDSP_Equalizer
# 	-I..\Modules\audio_player\Addons\SpiritDSP_LoudnessControl --C99
# -I X:\Documents\ARM\Stm32f7\STM32Cube_FW_F7_V1.1.0\Projects\STM32746G-Discovery\Demonstration\MDK-ARM\RTE
# -I C:\Keil_v5\ARM\PACK\ARM\CMSIS\4.3.0\CMSIS\Include
# -I C:\Keil_v5\ARM\PACK\Keil\STM32F7xx_DFP\2.1.0\Drivers\CMSIS\Device\ST\STM32F7xx\Include

-D__UVISION_VERSION="515" -D_RTE_ -DSTM32F746xx -DSTM32F756xx -DUSE_HAL_DRIVER -DUSE_STM32746G_DISCOVERY -DDEMO_VERSION="1.0.1" -o "STM32F7-DISCO\*.o" --omf_browse "STM32F7-DISCO\*.crf" --depend "STM32F7-DISCO\*.d"

MCU = cortex-m4
MCFLAGS = -mcpu=$(MCU) -mthumb -mlittle-endian -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb-interwork
STM32_INCLUDES = -I./inc \
	       -I./Drivers/CMSIS/Device/ST/STM32F7xx/Include \
				 -I./$(HAL_Driver_Dir)/Inc \
				 -I./Drivers/BSP/STM32746G-Discovery \
				 -I./$(BSP_Components_Dir)/Common \
			   -I./$(BSP_Components_Dir)/ft5336 \
			 	 -I./$(BSP_Components_Dir)/ov9655 \
			 	 -I./$(BSP_Components_Dir)/rk043fn48 \
				 -I./$(BSP_Components_Dir)/n25q128a \
				 -I./$(BSP_Components_Dir)/wm8994 \
				 -I./Utilities\Log \
				 -I./Utilities\Fonts \
				 -I./Utilities\CPU \
			   -I./Drivers/CMSIS/Include

OPTIMIZE       = -g -O0

CFLAGS	= $(MCFLAGS)  $(OPTIMIZE)  $(DEFS) -I./ $(STM32_INCLUDES)  -Wl,-T,stm32_flash.ld
AFLAGS	= $(MCFLAGS)
#-mapcs-float use float regs. small increase in code size

SRC = $(HAL_Driver_Dir)/Src/*.c \
  ./Drivers/BSP/STM32746G-Discovery/stm32746g_discovery.c \
	./src/stm32f7xx_hal_msp.c \
	./src/stm32f7xx_it.c \
	./src/system_stm32f7xx.c \
	./src/_exit.c \
	./src/main.c

STARTUP = ./src/startup_stm32f746xx.s

OBJDIR = .
OBJ = $(SRC:%.c=$(OBJDIR)/%.o)
OBJ += Startup.o

all: $(TARGET)

$(TARGET): $(EXECUTABLE)
	$(CP) -O ihex $^ $@
	$(CP) -O binary $(EXECUTABLE) demo.bin

$(EXECUTABLE): $(SRC) $(STARTUP)
	$(CC) $(CFLAGS) $^ -o $@

flash:
	st-flash write demo.bin 0x8000000
clean:
	rm -f Startup.lst  $(TARGET)  $(TARGET).lst $(OBJ) $(AUTOGEN)  $(TARGET).out  $(TARGET).hex  $(TARGET).map demo.elf \
	 $(TARGET).dmp  $(TARGET).elf
