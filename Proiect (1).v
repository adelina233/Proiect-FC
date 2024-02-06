//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:18:08 12/07/2021 
// Design Name: 
// Module Name:    RegFile_Addr_tb 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module RegFile_Addr_tb;

reg wr_en, clr, rst_b, clk;
reg [31:0]wr_data;
reg [1:0] wr_addr, rd_add;
reg [31:0] rd_data_expected;
wire [31:0] rd_data_actual;

integer n_tests, tests_passed;


/* Modify these variables to change display options */
	/* MONITOR: 
		1 <== Call the monitor function to see what your module does
		0 <== Do not call the monitor function
		
		DISPLAY_FAILED:
		1 <== Display expected vs actual for FAILED testcases
		0 <== Do not display expected vs actual
		
		DISPLAY_PASSED:
		1 <== Display PASSED test cases
		0 <== Do not display PASSED test cases
	*/
integer MONITOR = 1, DISPLAY_FAILED = 1, DISPLAY_PASSED = 0;


RegFile_Addr DUT(	.wr_data(wr_data), 
					.wr_addr(wr_addr), 
					.wr_en(wr_en), 
					.clr(clr), 
					.rst_b(rst_b), 
					.rd_add(rd_add), 
					.clk(clk), 
					.rd_data(rd_data_actual));
	
initial begin
		if(MONITOR) $monitor("Test %d: clk <= %b, rst_b <= %b, clr <= %b, wr_en <= %b, wr_data[hex] <= %x, wr_addr[bin] <= %b, rd_add[bin] <= %b, rd_data[hex] <= %x", n_tests, clk, rst_b, clr, wr_en, wr_data, wr_addr, rd_add, rd_data_actual);
		n_tests <= 0;
		tests_passed <= 0;
	end

initial begin
	wr_en <= 0;
	clr <= 0;
	rst_b <= 1;
	clk <= 0;
	wr_addr <= 0;
	rd_add <= 0;
	wr_data <=0;
	#1;
	clr <= 1;
	clk <= 1;
	#1;
	clk <= 0;
	rd_add <= 2'b00;
	clr <= 0;
	#1;
	// Verificam daca toti registrii s-au pus pe valoarea 0xAA55
	clk <= 1;
	rd_data_expected <= 'hAA55;
	n_tests <= n_tests + 1;
	#1; 
	clk <= 0;
	rd_add <= 2'b01;
	#1;
	clk <= 1;
	rd_data_expected <= 'hAA55;
	n_tests <= n_tests + 1;
	#1; 
	clk <= 0;
	rd_add <= 2'b10;
	#1;
	clk <= 1;
	rd_data_expected <= 'hAA55;
	n_tests <= n_tests + 1;
	#1; 
	clk <= 0;
	rd_add <= 2'b11;
	#1;
	clk <= 1;
	rd_data_expected <= 'hAA55;
	n_tests <= n_tests + 1;
	#1;
	// Scriem in primul registru
	clk <= 0;
	wr_addr <= 2'b00;
	wr_en <= 1'b1;
	wr_data <= 32'h00112233;
	#1;
	clk <= 1;
	#1;
	// Scriem in al doilea registru
	clk <= 0;
	wr_addr <= 2'b01;
	wr_en <= 1'b1;
	wr_data <= 32'h44556677;
	#1;
	clk <= 1;
	#1; 
	// Scriem in al treilea registru
	clk <= 0;
	wr_addr <= 2'b10;
	wr_en <= 1'b1;
	wr_data <= 32'h8899AABB;
	#1;
	clk <= 1;
	#1; 
	clk <= 0;
	wr_en <= 1'b0;
	wr_data <= 32'h11557799;
	rd_add <= 2'b11;
	#1;
	clk <= 1;
	rd_data_expected <= 'hAA55;
	n_tests <= n_tests + 1;
	#1; 
	// Verificam daca modulul reactioneaza doar pe frontul crescator al clk
	wr_data <= 32'h11557799;
	wr_addr <= 2'b01;
	wr_en <= 1'b1;
	clk <= 0;
	#1; 
	clk <= 0;
	#1;
	wr_en <= 1'b0;
	#1;
	wr_data <= 32'd0;
	wr_addr <= 2'b11;
	clk <= 1;
	#1; 
	clk <= 0;
	#1; 
	rd_add <= 2'b11;
	#1;
	clk <= 1;
	rd_data_expected <= 'hAA55;
	n_tests <= n_tests + 1;
	#1;
	clk <= 0;
	rd_add <= 2'b00;
	rd_data_expected <= 'hAA55;
	n_tests <= n_tests + 1;
	#1;
	clk <= 1;
	rd_data_expected <= 32'h00112233;
	n_tests <= n_tests + 1;
	#1; 
	clk <= 0;
	rd_add <= 2'b01;
	n_tests <= n_tests + 1;
	#1;
	clk <= 1;
	rd_data_expected <= 32'h44556677;
	n_tests <= n_tests + 1;
	#1;
	clk <= 0;
	rd_add <= 2'b10;
	#1;
	clk <= 1;
	rd_data_expected <= 32'h8899AABB;
	n_tests <= n_tests + 1;
	#1; 
	clk <= 0;
	wr_data <= 32'h1;
	wr_addr <= 2'b11;
	wr_en <= 1;
	#1;
	clk <= 1;
	#1;
	clk <= 0;
	wr_en <= 0;
	rd_add <= 2'b11;
	#1;
	clk <= 1;
	rd_data_expected <= 32'h1;
	n_tests <= n_tests + 1;
	
	// Verificam daca datele se retin in timp
	#100;
	#1;
	clk <= 0;
	rd_add <= 2'b00;
	#1;
	clk <= 1;
	rd_data_expected <= 32'h00112233;
	n_tests <= n_tests + 1;
	#1; 
	clk <= 0;
	rd_add <= 2'b01;
	n_tests <= n_tests + 1;
	#1;
	clk <= 1;
	rd_data_expected <= 32'h44556677;
	n_tests <= n_tests + 1;
	#1;
	clk <= 0;
	rd_add <= 2'b10;
	#1;
	clk <= 1;
	rd_data_expected <= 32'h8899AABB;
	n_tests <= n_tests + 1;
	#1;
	clk <= 0;
	rd_add <= 2'b11;
	#1;
	clk <= 1;
	rd_data_expected <= 32'h1;
	n_tests <= n_tests + 1;
	
	// Verificam resetarea modului
	#1;
	clk <= 0;
	rst_b <= 0;
	#1;
	clk <= 1;
	#1;
	clk <= 0;
	rst_b <= 1;
	#1;
	clk <= 1;
	#1;
	clk <= 0;
	rd_add <= 2'b00;
	#1;
	clk <= 1;
	rd_data_expected <= 0;
	n_tests <= n_tests + 1;
	#1; 
	clk <= 0;
	rd_add <= 2'b01;
	n_tests <= n_tests + 1;
	#1;
	clk <= 1;
	rd_data_expected <= 0;
	n_tests <= n_tests + 1;
	#1;
	clk <= 0;
	rd_add <= 2'b10;
	#1;
	clk <= 1;
	rd_data_expected <= 0;
	n_tests <= n_tests + 1;
	#1;
	clk <= 0;
	rd_add <= 2'b11;
	#1;
	clk <= 1;
	rd_data_expected <= 0;
	n_tests <= n_tests + 1;
	#1;
	
	
	wr_en <= 0;
	clr <= 0;
	rst_b <= 1;
	clk <= 0;
	wr_addr <= 0;
	rd_add <= 0;
	wr_data <=0;
	#1;
	clr <= 1;
	#1;
	clk <= 1;
	#1;
	clk <= 0;
	rd_add <= 2'b00;
	clr <= 0;
	#1;
	// Verificam daca toti registrii s-au pus pe valoarea 0xAA55
	clk <= 1;
	#1; 
	rd_data_expected <= 'hAA55;
	n_tests <= n_tests + 1;
	#1; 
	clk <= 0;
	rd_add <= 2'b01;
	#1;
	clk <= 1;
	rd_data_expected <= 'hAA55;
	n_tests <= n_tests + 1;
	#1; 
	clk <= 0;
	rd_add <= 2'b10;
	#1;
	clk <= 1;
	rd_data_expected <= 'hAA55;
	n_tests <= n_tests + 1;
	#1; 
	clk <= 0;
	rd_add <= 2'b11;
	#1;
	clk <= 1;
	rd_data_expected <= 'hAA55;
	n_tests <= n_tests + 1;
	#1;
	$display("Tests Passed/Total Tests: %0d/%0d", tests_passed, n_tests);
end

always @(n_tests) begin
		if(n_tests != 0) begin
			if(rd_data_actual === rd_data_expected) begin
				tests_passed <= tests_passed + 1;
				if(DISPLAY_PASSED) $display("[DISPLAY PASSED] Test %d: rd_data_expected <= %X [PASSED]", n_tests, rd_data_expected);
			end
			else if(DISPLAY_FAILED) 
				$display("[DISPLAY FAILED] Test %d: rd_data_expected <= %X, rd_data_actual <= %X [%s]", 
							n_tests, rd_data_expected, rd_data_actual, rd_data_actual === rd_data_expected ? "PASSED": "FAILED");
		end
	end   	

endmodule