################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../drivers/mss_pdma/mss_pdma.c 

OBJS += \
./drivers/mss_pdma/mss_pdma.o 

C_DEPS += \
./drivers/mss_pdma/mss_pdma.d 


# Each subdirectory must supply rules for building sources it contributes
drivers/mss_pdma/%.o: ../drivers/mss_pdma/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: GNU C Compiler'
	arm-none-eabi-gcc -mthumb -mcpu=cortex-m3 -DACTEL_STDIO_THRU_UART -IN:\373\base_station-master\SoftConsole\controller_MSS_MSS_CM3_0\controller_MSS_MSS_CM3_0_hw_platform -IN:\373\base_station-master\SoftConsole\controller_MSS_MSS_CM3_0\controller_MSS_MSS_CM3_0_hw_platform\CMSIS -IN:\373\base_station-master\SoftConsole\controller_MSS_MSS_CM3_0\controller_MSS_MSS_CM3_0_hw_platform\CMSIS\startup_gcc -IN:\373\base_station-master\SoftConsole\controller_MSS_MSS_CM3_0\controller_MSS_MSS_CM3_0_hw_platform\drivers -IN:\373\base_station-master\SoftConsole\controller_MSS_MSS_CM3_0\controller_MSS_MSS_CM3_0_hw_platform\drivers\mss_gpio -IN:\373\base_station-master\SoftConsole\controller_MSS_MSS_CM3_0\controller_MSS_MSS_CM3_0_hw_platform\drivers\mss_nvm -IN:\373\base_station-master\SoftConsole\controller_MSS_MSS_CM3_0\controller_MSS_MSS_CM3_0_hw_platform\drivers\mss_pdma -IN:\373\base_station-master\SoftConsole\controller_MSS_MSS_CM3_0\controller_MSS_MSS_CM3_0_hw_platform\drivers\mss_rtc -IN:\373\base_station-master\SoftConsole\controller_MSS_MSS_CM3_0\controller_MSS_MSS_CM3_0_hw_platform\drivers\mss_timer -IN:\373\base_station-master\SoftConsole\controller_MSS_MSS_CM3_0\controller_MSS_MSS_CM3_0_hw_platform\hal -IN:\373\base_station-master\SoftConsole\controller_MSS_MSS_CM3_0\controller_MSS_MSS_CM3_0_hw_platform\hal\CortexM3 -IN:\373\base_station-master\SoftConsole\controller_MSS_MSS_CM3_0\controller_MSS_MSS_CM3_0_hw_platform\hal\CortexM3\GNU -O1 -ffunction-sections -fdata-sections -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o"$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


