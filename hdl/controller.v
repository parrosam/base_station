module controller_interface(
	input PCLK, 				// clock 
 	//input PRESERN, 				// system reset 
 
 	/*APB3 BUS INTERFACE 
	input PSEL, 				// peripheral select 
	input PENABLE, 			// distinguishes access phase 
	output wire PREADY, 		// peripheral ready signal 
	output wire PSLVERR, 		// error signal 
	input PWRITE,				// read/write control bit 
	input [31:0] PADDR, 		// IO address 
	input wire [31:0] PWDATA, 	// (processor) bus is writing data to 
	 							// this device 32 bits 
 	output reg [31:0] PRDATA, 	// (processor) bus is reading data from this device*/

	//Controller in/out
	input wire contREAD,	//bi-directional wire for red data line
	output wire contWRITE, 
	output wire RDATA
	//output wire contCLK
);

	//Divided clock to 4 us period
	//clockDiv c1(PCLK, contCLK);
	
	/*
	reg write;
	always @(posedge contCLK)
	begin
		write <= ~write;
	end

	assign contWrite = write;
	*/

	reg [20:0]count;			//Need to count up to 6 milliseconds; 6ms/10ns = 600000
	reg contRead;
	reg contWrite;
	reg [7:0]numPollEdges;
	wire read;

	assign contWRITE = contWrite;
	assign RDATA = contRead;
	assign read = (numPollEdges > 25) ? 1 : 0;	//After counting 25 negedges of contWRITE, data from the controller should be on the line

	/*read is always true ... WHY??????*/

	
	always @(negedge contWRITE)
	begin
		if(count < 599999)
			numPollEdges <= numPollEdges + 1;
		else
			numPollEdges <= 0;
	end

	//Get data from the line
	always @(posedge PCLK)
	begin
		if (read)
			contRead <= 0;
		else
			contRead <= 1;
	end

	//Send polling commmand:  0100 0000 0000 0011 0000 0010 + 1 (stop bit) = 
	always @(posedge PCLK)
	begin
	//Write the first half-byte
		//Write the first 0
		if (count < 300)
		begin
			count <= count + 1;
			contWrite <= 0;
		end
		else if (count < 400)
		begin
			count <= count + 1;
			contWrite <= 1;
		end

		//Write the first 1
		else if (count < 500)
		begin
			count <= count + 1;
			contWrite <= 0;
		end
		else if (count < 800)
		begin
			count <= count + 1;
			contWrite <= 1;
		end
		
		//Write 0
		else if (count < 1100)
		begin
			count <= count + 1;
			contWrite <= 0;
		end
		else if (count < 1200)
		begin
			count <= count + 1;
			contWrite <= 1;
		end

		//Write 0
		else if (count < 1500)
		begin
			count <= count + 1;
			contWrite <= 0;
		end
		else if (count < 1600)
		begin
			count <= count + 1;
			contWrite <= 1;
		end	

	//Write the second half-byte
		//Write 0
		else if (count < 1900)
		begin
			count <= count + 1;
			contWrite <= 0;
		end
		else if (count < 2000)
		begin
			count <= count + 1;
			contWrite <= 1;
		end

		//Write 0
		else if (count < 2300)
		begin
			count <= count + 1;
			contWrite <= 0;
		end
		else if (count < 2400)
		begin
			count <= count + 1;
			contWrite <= 1;
		end
		
		//Write 0
		else if (count < 2700)
		begin
			count <= count + 1;
			contWrite <= 0;
		end
		else if (count < 2800)
		begin
			count <= count + 1;
			contWrite <= 1;
		end

		//Write 0
		else if (count < 3100)
		begin
			count <= count + 1;
			contWrite <= 0;
		end
		else if (count < 3200)
		begin
			count <= count + 1;
			contWrite <= 1;
		end	

	//Write the third half-byte
		//Write 0
		else if (count < 3500)
		begin
			count <= count + 1;
			contWrite <= 0;
		end
		else if (count < 3600)
		begin
			count <= count + 1;
			contWrite <= 1;
		end

		//Write 0
		else if (count < 3900)
		begin
			count <= count + 1;
			contWrite <= 0;
		end
		else if (count < 4000)
		begin
			count <= count + 1;
			contWrite <= 1;
		end
		
		//Write 0
		else if (count < 4300)
		begin
			count <= count + 1;
			contWrite <= 0;
		end
		else if (count < 4400)
		begin
			count <= count + 1;
			contWrite <= 1;
		end

		//Write 0
		else if (count < 4700)
		begin
			count <= count + 1;
			contWrite <= 0;
		end
		else if (count < 4800)
		begin
			count <= count + 1;
			contWrite <= 1;
		end	

	//Write the fourth half-byte
		//Write 0
		else if (count < 5100)
		begin
			count <= count + 1;
			contWrite <= 0;
		end
		else if (count < 5200)
		begin
			count <= count + 1;
			contWrite <= 1;
		end

		//Write 0
		else if (count < 5500)
		begin
			count <= count + 1;
			contWrite <= 0;
		end
		else if (count < 5600)
		begin
			count <= count + 1;
			contWrite <= 1;
		end
		
		//Write 1
		else if (count < 5700)
		begin
			count <= count + 1;
			contWrite <= 0;
		end
		else if (count < 6000)
		begin
			count <= count + 1;
			contWrite <= 1;
		end

		//Write 1
		else if (count < 6100)
		begin
			count <= count + 1;
			contWrite <= 0;
		end
		else if (count < 6400)
		begin
			count <= count + 1;
			contWrite <= 1;
		end

	//Write the fifth half-byte
		//Write 0
		else if (count < 6700)
		begin
			count <= count + 1;
			contWrite <= 0;
		end
		else if (count < 6800)
		begin
			count <= count + 1;
			contWrite <= 1;
		end

		//Write 0
		else if (count < 7100)
		begin
			count <= count + 1;
			contWrite <= 0;
		end
		else if (count < 7200)
		begin
			count <= count + 1;
			contWrite <= 1;
		end
		
		//Write 0
		else if (count < 7500)
		begin
			count <= count + 1;
			contWrite <= 0;
		end
		else if (count < 7600)
		begin
			count <= count + 1;
			contWrite <= 1;
		end

		//Write 0
		else if (count < 7900)
		begin
			count <= count + 1;
			contWrite <= 0;
		end
		else if (count < 8000)
		begin
			count <= count + 1;
			contWrite <= 1;
		end

	//Write the sixth half-byte
		//Write 0
		else if (count < 8300)
		begin
			count <= count + 1;
			contWrite <= 0;
		end
		else if (count < 8400)
		begin
			count <= count + 1;
			contWrite <= 1;
		end

		//Write 0
		else if (count < 8700)
		begin
			count <= count + 1;
			contWrite <= 0;
		end
		else if (count < 8800)
		begin
			count <= count + 1;
			contWrite <= 1;
		end
		
		//Write 1
		else if (count < 8900)
		begin
			count <= count + 1;
			contWrite <= 0;
		end
		else if (count < 9200)
		begin
			count <= count + 1;
			contWrite <= 1;
		end

		//Write 0
		else if (count < 9500)
		begin
			count <= count + 1;
			contWrite <= 0;
		end
		else if (count < 9600)
		begin
			count <= count + 1;
			contWrite <= 1;
		end

	//Write the stop bit
		//Write 1
		else if (count < 9700)
		begin
			count <= count + 1;
			contWrite <= 0;
		end
		else if (count < 10000)
		begin
			count <= count + 1;
			contWrite <= 1;
		end

	//Wait for 6 ms to pass
		else if (count < 600000)
		begin
			count <= count + 1;
			contWrite <= 1;
		end
		else
			count <= 0;
	end

endmodule

/*
module clockDiv(input wire PCLK, output wire contCLK);
	reg [8:0]count;
	reg divCLK;

	always @(posedge PCLK)
	begin
		if (count < 200)
		begin
			count <= count + 1;
			divCLK <= 0;
		end
		else if (count < 400)
		begin
			count <= count + 1;
			divCLK <= 1;
		end
		else
			count <= 0;
	end
	
	assign contCLK = divCLK;
endmodule
*/

/*This module takes a clock
module contPoll(input wire contCLK, output wire contWrite);*/