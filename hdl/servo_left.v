module servo_left(
	input PCLK, // clock 
	input PRESERN, // system reset 
 
	//APB3 BUS INTERFACE 
	input PSEL, // peripheral select 
	input PENABLE, // distinguishes access phase 
	output wire PREADY, // peripheral ready signal 
	output wire PSLVERR, // error signal 
	input PWRITE, // read/write control bit 
	input [31:0] PADDR, // IO address 
	input wire [31:0] PWDATA, // (processor) bus is writing data to 
	output reg [31:0] PRDATA, // (processor) bus is reading data from this device 

	output reg pwm
);

assign PSLVERR = 0; //assumes no error generation 
assign PREADY = 1; //assumes zero wait 

wire servo_left_edit = PSEL & PENABLE & PWRITE;

reg [20:0] count;			//Count cycles after each negedge of data

reg [31:0] pulseWidth;

initial begin
	pulseWidth = 150000;

end

`define period 2000000

always @(posedge PCLK)
begin
	if (servo_left_edit)
		pulseWidth <= PWDATA;
	else
	begin
		if (count == `period) 
	 		count <= 0; 
	 	else 
	 		count <= count + 1; 
	
	 	if (count < pulseWidth) 
	 		pwm <= 1; 
	 	else 
	 		pwm <= 0; 
	end
end

endmodule