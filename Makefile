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

# ..\Inc;..\..\..\..
# \Drivers\CMSIS\Device\ST\STM32F7xx\Include;..\..\..\..
# \Drivers\STM32F7xx_HAL_Driver\Inc;..\..\..\..
# \Drivers\BSP\STM32746G-Discovery;..\..\..\..
# \Drivers\BSP\Components\Common;..\..\..\..
# \Drivers\BSP\Components\ft5336;..\..\..\..
# \Drivers\BSP\Components\ov9655;..\..\..\..
# \Drivers\BSP\Components\rk043fn48;..\..\..\..
# \Drivers\BSP\Components\n25q128a;..\..\..\..
# \Drivers\BSP\Components\wm8994;..\..\..\..
# \Utilities\Log;..\..\..\..
# \Utilities\Fonts;..\..\..\..
# \Utilities\CPU

# -c --cpu Cortex-M7.fp.sp --fpu=FPv4-SP -D__MICROLIB -g -O3 --apcs=interwork --split_sections
# -I..\Inc -I..\..\..\..\Drivers\CMSIS\Device\ST\STM32F7xx\Include
# -I..\..\..\..\Drivers\STM32F7xx_HAL_Driver\Inc
# -I..\..\..\..\Drivers\BSP\STM32746G-Discovery
#  -I..\..\..\..\Drivers\BSP\Components\Common
#  -I..\..\..\..\Drivers\BSP\Components\ft5336
#  -I..\..\..\..\Drivers\BSP\Components\ov9655
#  -I..\..\..\..\Drivers\BSP\Components\rk043fn48
#  -I..\..\..\..\Drivers\BSP\Components\n25q128a
#  -I..\..\..\..\Drivers\BSP\Components\wm8994
#  -I..\..\..\..\Utilities\Log
#  -I..\..\..\..\Utilities\Fonts
#  -I..\..\..\..\Utilities\CPU --C99
# -I Y:\Documents\ARM\Stm32f7\STM32Cube_FW_F7_V1.1.0\Projects\STM32746G-Discovery\Templates\MDK-ARM\RTE
# -I C:\Keil_v5\ARM\PACK\ARM\CMSIS\4.3.0\CMSIS\Include
# -I C:\Keil_v5\ARM\PACK\Keil\STM32F7xx_DFP\2.1.0\Drivers\CMSIS\Device\ST\STM32F7xx\Include
# -D__UVISION_VERSION="515" -D_RTE_ -DSTM32F746xx -DUSE_HAL_DRIVER -DSTM32F746xx -o "STM32746G_Discovery(AXIM-FLASH)\*.o" --omf_browse "STM32746G_Discovery(AXIM-FLASH)\*.crf" --depend "STM32746G_Discovery(AXIM-FLASH)\*.d"

HAL_Driver_Dir = ./Drivers/STM32F7xx_HAL_Driver
BSP_Components_Dir = ./Drivers/BSP/Components

DEFS =-D_RTE_ -DSTM32F746xx -DUSE_HAL_DRIVER -DSTM32F746xx

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
