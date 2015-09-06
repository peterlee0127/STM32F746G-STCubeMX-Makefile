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

HAL_Driver_Dir = ./Drivers/STM32F7xx_HAL_Driver

DEFS = -D_RTE_ -DSTM32F7xx -DUSE_HAL_DRIVER -DSTM32F7xx -DUSE_STM32F746G_DISCO

MCU = cortex-m4
MCFLAGS = -mcpu=$(MCU) -mthumb -mlittle-endian -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb-interwork
STM32_INCLUDES = -I./inc \
	       -I./Drivers/CMSIS/Device/ST/STM32F7xx/Include \
				 -I ./$(HAL_Driver_Dir)/Inc \
				 -I./Drivers/BSP/STM32746G-Discovery \
			   -I./Drivers/CMSIS/Include \

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
