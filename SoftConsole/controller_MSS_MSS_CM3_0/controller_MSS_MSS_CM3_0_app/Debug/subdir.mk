################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../controller.c \
../display.c \
../main.c 

OBJS += \
./controller.o \
./display.o \
./main.o 

C_DEPS += \
./controller.d \
./display.d \
./main.d 


# Each subdirectory must supply rules for building sources it contributes
%.o: ../%.c
	@echo 'Building file: $<'
	@echo 'Invoking: GNU C Compiler'
	arm-none-eabi-gcc -mthumb -mcpu=cortex-m3 -IN:\373\base_station-master\SoftConsole\controller_MSS_MSS_CM3_0\controller_MSS_MSS_CM3_0_hw_platform -IN:/eecs373/IntegratedSegway-master -IN:\373\base_station-master\SoftConsole\controller_MSS_MSS_CM3_0\controller_MSS_MSS_CM3_0_hw_platform\CMSIS -IN:\373\base_station-master\SoftConsole\controller_MSS_MSS_CM3_0\controller_MSS_MSS_CM3_0_hw_platform\CMSIS\startup_gcc -IN:\373\base_station-master\SoftConsole\controller_MSS_MSS_CM3_0\controller_MSS_MSS_CM3_0_hw_platform\drivers -IN:\373\base_station-master\SoftConsole\controller_MSS_MSS_CM3_0\controller_MSS_MSS_CM3_0_hw_platform\drivers\mss_gpio -IN:\373\base_station-master\SoftConsole\controller_MSS_MSS_CM3_0\controller_MSS_MSS_CM3_0_hw_platform\drivers\mss_nvm -IN:\373\base_station-master\SoftConsole\controller_MSS_MSS_CM3_0\controller_MSS_MSS_CM3_0_hw_platform\drivers\mss_pdma -IN:\373\base_station-master\SoftConsole\controller_MSS_MSS_CM3_0\controller_MSS_MSS_CM3_0_hw_platform\drivers\mss_rtc -IN:\373\base_station-master\SoftConsole\controller_MSS_MSS_CM3_0\controller_MSS_MSS_CM3_0_hw_platform\drivers\mss_timer -IN:\373\base_station-master\SoftConsole\controller_MSS_MSS_CM3_0\controller_MSS_MSS_CM3_0_hw_platform\hal -IN:\373\base_station-master\SoftConsole\controller_MSS_MSS_CM3_0\controller_MSS_MSS_CM3_0_hw_platform\hal\CortexM3 -IN:\373\base_station-master\SoftConsole\controller_MSS_MSS_CM3_0\controller_MSS_MSS_CM3_0_hw_platform\hal\CortexM3\GNU -O0 -ffunction-sections -fdata-sections -g3 -Wall -c -fmessage-length=0 -v -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o"$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


