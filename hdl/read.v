// read.v

module read(
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

	//MODULE I/O
	input ready,
	inout data
);

wire controller_read = (PADDR[2:0] == 3'b000) & PSEL & PENABLE & ~PWRITE;

assign PSLVERR = 0; //assumes no error generation 
assign PREADY = 1; //assumes zero wait 

//assign buttonData[7:0] = PRDATA[31:24];

reg A, B, X, Y, Start, L, R, Z, D_Up, D_Down, D_Left, D_Right;
reg [7:0] Joystick_X, Joystick_Y;

reg [20:0] count;			//Count cycles after each negedge of data
reg [7:0] buttonCount;		//Counts number of negedges
reg [1:0] dataSync;	//Synchronizes data input 
//Associate each button with correct negedge
always @(posedge PCLK)
begin

	//Bit assignment matches order in section "Polling the Controller for Joystick/Button Data" at http://www.int03.co.uk/crema/hardware/gamecube/gc-control.html
	if(controller_read)
	begin
		PRDATA[31:29] <= 0;
		PRDATA[28] <= Start;
		PRDATA[27] <= Y;
		PRDATA[26] <= X;
		PRDATA[25] <= B;
		PRDATA[24] <= A;
		PRDATA[23] <= 0;
		PRDATA[22] <= L;
		PRDATA[21] <= R;
		PRDATA[20] <= Z;
		PRDATA[19] <= D_Up;
		PRDATA[18] <= D_Down;
		PRDATA[17] <= D_Right;
		PRDATA[16] <= D_Left;
		PRDATA[15:8] <= Joystick_X[7:0];
		PRDATA[7:0] <= Joystick_Y[7:0];
	end
	
	//Detect a negedge on data and increment button count if detected and module has received ready signal
	dataSync[1] <= data;
	dataSync[0] <= dataSync[1];

	if (~dataSync[1] & dataSync[0])
	begin
		if (ready)
			buttonCount <= buttonCount + 1;
		else
			buttonCount <= 0;
	end

	//Sample data in the middle of each bit
	if(ready)
	begin
		if(~dataSync[1] & dataSync[0])			//Increment count after each negedge
			count <= 0;
		else
			count <= count + 1;

		if(count >= 190 && count <= 210)		//Sample in the middle (count goes up to 400)
		begin
			if(buttonCount == 3)
				Start <= dataSync[0];
			else if(buttonCount == 4)
				Y <= dataSync[0];
			else if(buttonCount == 5)
				X <= dataSync[0];
			else if(buttonCount == 6)
				B <= dataSync[0];
			else if(buttonCount == 7)
				A <= dataSync[0];
			else if(buttonCount == 9)
				L <= dataSync[0];
			else if(buttonCount == 10)
				R <= dataSync[0];
			else if(buttonCount == 11)
				Z <= dataSync[0];
			else if(buttonCount == 12)
				D_Up <= dataSync[0];
			else if(buttonCount == 13)
				D_Down <= dataSync[0];
			else if(buttonCount == 14)
				D_Right <= dataSync[0];
			else if(buttonCount == 15)
				D_Left <= dataSync[0];
			else if(buttonCount == 16)
				Joystick_X[7] <= dataSync[0];
			else if(buttonCount == 17)
				Joystick_X[6] <= dataSync[0];
			else if(buttonCount == 18)
				Joystick_X[5] <= dataSync[0];
			else if(buttonCount == 19)
				Joystick_X[4] <= dataSync[0];
			else if(buttonCount == 20)
				Joystick_X[3] <= dataSync[0];
			else if(buttonCount == 21)
				Joystick_X[2] <= dataSync[0];
			else if(buttonCount == 22)
				Joystick_X[1] <= dataSync[0];
			else if(buttonCount == 23)
				Joystick_X[0] <= dataSync[0];
			else if(buttonCount == 24)
				Joystick_Y[7] <= dataSync[0];
			else if(buttonCount == 25)
				Joystick_Y[6] <= dataSync[0];
			else if(buttonCount == 26)
				Joystick_Y[5] <= dataSync[0];
			else if(buttonCount == 27)
				Joystick_Y[4] <= dataSync[0];
			else if(buttonCount == 28)
				Joystick_Y[3] <= dataSync[0];
			else if(buttonCount == 29)
				Joystick_Y[2] <= dataSync[0];
			else if(buttonCount == 30)
				Joystick_Y[1] <= dataSync[0];
			else if(buttonCount == 31)
				Joystick_Y[0] <= dataSync[0];
		end
	end
end

endmodule