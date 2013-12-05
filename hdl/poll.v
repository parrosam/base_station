// pollSignal.v
module pollSignal(
	input PCLK,
	inout poll,
	output reg read
);
	reg[20:0] count;
	reg pollSignal;

assign poll = pollSignal;

always @(posedge PCLK)
	begin
	//Write the first half-byte
		//Write the first 0
		if (count < 300)
		begin
			read <= 0;
			count <= count + 1;
			pollSignal <= 0;
		end
		else if (count < 400)
		begin
			count <= count + 1;
			pollSignal <= 1;
		end

		//Write the first 1
		else if (count < 500)
		begin
			count <= count + 1;
			pollSignal <= 0;
		end
		else if (count < 800)
		begin
			count <= count + 1;
			pollSignal <= 1;
		end
		
		//Write 0
		else if (count < 1100)
		begin
			count <= count + 1;
			pollSignal <= 0;
		end
		else if (count < 1200)
		begin
			count <= count + 1;
			pollSignal <= 1;
		end

		//Write 0
		else if (count < 1500)
		begin
			count <= count + 1;
			pollSignal <= 0;
		end
		else if (count < 1600)
		begin
			count <= count + 1;
			pollSignal <= 1;
		end	

	//Write the second half-byte
		//Write 0
		else if (count < 1900)
		begin
			count <= count + 1;
			pollSignal <= 0;
		end
		else if (count < 2000)
		begin
			count <= count + 1;
			pollSignal <= 1;
		end

		//Write 0
		else if (count < 2300)
		begin
			count <= count + 1;
			pollSignal <= 0;
		end
		else if (count < 2400)
		begin
			count <= count + 1;
			pollSignal <= 1;
		end
		
		//Write 0
		else if (count < 2700)
		begin
			count <= count + 1;
			pollSignal <= 0;
		end
		else if (count < 2800)
		begin
			count <= count + 1;
			pollSignal <= 1;
		end

		//Write 0
		else if (count < 3100)
		begin
			count <= count + 1;
			pollSignal <= 0;
		end
		else if (count < 3200)
		begin
			count <= count + 1;
			pollSignal <= 1;
		end	

	//Write the third half-byte
		//Write 0
		else if (count < 3500)
		begin
			count <= count + 1;
			pollSignal <= 0;
		end
		else if (count < 3600)
		begin
			count <= count + 1;
			pollSignal <= 1;
		end

		//Write 0
		else if (count < 3900)
		begin
			count <= count + 1;
			pollSignal <= 0;
		end
		else if (count < 4000)
		begin
			count <= count + 1;
			pollSignal <= 1;
		end
		
		//Write 0
		else if (count < 4300)
		begin
			count <= count + 1;
			pollSignal <= 0;
		end
		else if (count < 4400)
		begin
			count <= count + 1;
			pollSignal <= 1;
		end

		//Write 0
		else if (count < 4700)
		begin
			count <= count + 1;
			pollSignal <= 0;
		end
		else if (count < 4800)
		begin
			count <= count + 1;
			pollSignal <= 1;
		end	

	//Write the fourth half-byte
		//Write 0
		else if (count < 5100)
		begin
			count <= count + 1;
			pollSignal <= 0;
		end
		else if (count < 5200)
		begin
			count <= count + 1;
			pollSignal <= 1;
		end

		//Write 0
		else if (count < 5500)
		begin
			count <= count + 1;
			pollSignal <= 0;
		end
		else if (count < 5600)
		begin
			count <= count + 1;
			pollSignal <= 1;
		end
		
		//Write 1
		else if (count < 5700)
		begin
			count <= count + 1;
			pollSignal <= 0;
		end
		else if (count < 6000)
		begin
			count <= count + 1;
			pollSignal <= 1;
		end

		//Write 1
		else if (count < 6100)
		begin
			count <= count + 1;
			pollSignal <= 0;
		end
		else if (count < 6400)
		begin
			count <= count + 1;
			pollSignal <= 1;
		end

	//Write the fifth half-byte
		//Write 0
		else if (count < 6700)
		begin
			count <= count + 1;
			pollSignal <= 0;
		end
		else if (count < 6800)
		begin
			count <= count + 1;
			pollSignal <= 1;
		end

		//Write 0
		else if (count < 7100)
		begin
			count <= count + 1;
			pollSignal <= 0;
		end
		else if (count < 7200)
		begin
			count <= count + 1;
			pollSignal <= 1;
		end
		
		//Write 0
		else if (count < 7500)
		begin
			count <= count + 1;
			pollSignal <= 0;
		end
		else if (count < 7600)
		begin
			count <= count + 1;
			pollSignal <= 1;
		end

		//Write 0
		else if (count < 7900)
		begin
			count <= count + 1;
			pollSignal <= 0;
		end
		else if (count < 8000)
		begin
			count <= count + 1;
			pollSignal <= 1;
		end

	//Write the sixth half-byte
		//Write 0
		else if (count < 8300)
		begin
			count <= count + 1;
			pollSignal <= 0;
		end
		else if (count < 8400)
		begin
			count <= count + 1;
			pollSignal <= 1;
		end

		//Write 0
		else if (count < 8700)
		begin
			count <= count + 1;
			pollSignal <= 0;
		end
		else if (count < 8800)
		begin
			count <= count + 1;
			pollSignal <= 1;
		end
		
		//Write 1
		else if (count < 8900)
		begin
			count <= count + 1;
			pollSignal <= 0;
		end
		else if (count < 9200)
		begin
			count <= count + 1;
			pollSignal <= 1;
		end

		//Write 0
		else if (count < 9500)
		begin
			count <= count + 1;
			pollSignal <= 0;
		end
		else if (count < 9600)
		begin
			count <= count + 1;
			pollSignal <= 1;
		end

	//Write the stop bit
		//Write 1
		else if (count < 9700)
		begin
			count <= count + 1;
			pollSignal <= 0;
		end
		else if (count < 10000)
		begin
			count <= count + 1;
			pollSignal <= 1;
		end

	//Wait for 6 ms to pass
		else if (count < 600000)
		begin
			read <= 1;
			count <= count + 1;
			pollSignal <= 1'bZ;
		end
		else
			count <= 0;
	end

endmodule