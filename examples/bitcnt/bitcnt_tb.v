/*
 *  Copyright (C) 2020  Claire Wolf <claire@symbioticeda.com>
 *
 *  Permission to use, copy, modify, and/or distribute this software for any
 *  purpose with or without fee is hereby granted, provided that the above
 *  copyright notice and this permission notice appear in all copies.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 *  WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 *  MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 *  ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 *  WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 *  ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 *  OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *
 */

// Example usage:
// iverilog -s testbench -o bitcnt_tb bitcnt_tb.v bitcnt.v && vvp -N bitcnt_tb

module testbench;
	reg  [63:0] din_data;
	reg  [ 2:0] din_func;
	wire [63:0] dout_data;

	bitcnt uut (
		.din_data  (din_data ),
		.din_func  (din_func ),
		.dout_data (dout_data)
	);

	task test;
		input [ 2:0] f;
		input [63:0] di;
		input [63:0] do;
		begin
			din_func = f;
			din_data = di;
			#5;
			if (do === dout_data) begin
				$display("OK f=%x di=%x do(ref)=do(uut)=%x", f, di, do);
			end else begin
				$display("ERROR f=%x di=%x do(ref)=%x do(uut)=%x", f, di, do, dout_data);
				$stop;
			end
			#5;
		end
	endtask

	localparam F_CLZ_64 = 3'b 000;
	localparam F_CLZ_32 = 3'b 001;
	localparam F_CTZ_64 = 3'b 010;
	localparam F_CTZ_32 = 3'b 011;
	localparam F_CNT_64 = 3'b 100;
	localparam F_CNT_32 = 3'b 101;

	initial begin
		test(F_CTZ_64, 64'b 0000000000000000000000000000000000000000000000000000000000000001,  0);
		test(F_CTZ_64, 64'b 0000000000000000000000000000000000000000000000000000000000000010,  1);
		test(F_CTZ_64, 64'b 0000000000000000000000000000000000000000000000000000000000000100,  2);
		test(F_CTZ_64, 64'b 0000000000000000000000000000000000000000000000000000000000001000,  3);
		test(F_CTZ_64, 64'b 0000000000000000000000000000000000000000000000000000000000010000,  4);
		test(F_CTZ_64, 64'b 0000000000000000000000000000000000000000000000000000000000100000,  5);
		test(F_CTZ_64, 64'b 0000000000000000000000000000000000000000000000000000000001000000,  6);
		test(F_CTZ_64, 64'b 0000000000000000000000000000000000000000000000000000000010000000,  7);
		test(F_CTZ_64, 64'b 0000000000000000000000000000000000000000000000000000000100000000,  8);
		test(F_CTZ_64, 64'b 0000000000000000000000000000000000000000000000000000001000000000,  9);
		test(F_CTZ_64, 64'b 0000000000000000000000000000000000000000000000000000010000000000, 10);
		test(F_CTZ_64, 64'b 0000000000000000000000000000000000000000000000000000100000000000, 11);
		test(F_CTZ_64, 64'b 0000000000000000000000000000000000000000000000000001000000000000, 12);
		test(F_CTZ_64, 64'b 0000000000000000000000000000000000000000000000000010000000000000, 13);
		test(F_CTZ_64, 64'b 0000000000000000000000000000000000000000000000000100000000000000, 14);
		test(F_CTZ_64, 64'b 0000000000000000000000000000000000000000000000001000000000000000, 15);
		test(F_CTZ_64, 64'b 0000000000000000000000000000000000000000000000010000000000000000, 16);
		test(F_CTZ_64, 64'b 0000000000000000000000000000000000000000000000100000000000000000, 17);
		test(F_CTZ_64, 64'b 0000000000000000000000000000000000000000000001000000000000000000, 18);
		test(F_CTZ_64, 64'b 0000000000000000000000000000000000000000000010000000000000000000, 19);
		test(F_CTZ_64, 64'b 0000000000000000000000000000000000000000000100000000000000000000, 20);
		test(F_CTZ_64, 64'b 0000000000000000000000000000000000000000001000000000000000000000, 21);
		test(F_CTZ_64, 64'b 0000000000000000000000000000000000000000010000000000000000000000, 22);
		test(F_CTZ_64, 64'b 0000000000000000000000000000000000000000100000000000000000000000, 23);
		test(F_CTZ_64, 64'b 0000000000000000000000000000000000000001000000000000000000000000, 24);
		test(F_CTZ_64, 64'b 0000000000000000000000000000000000000010000000000000000000000000, 25);
		test(F_CTZ_64, 64'b 0000000000000000000000000000000000000100000000000000000000000000, 26);
		test(F_CTZ_64, 64'b 0000000000000000000000000000000000001000000000000000000000000000, 27);
		test(F_CTZ_64, 64'b 0000000000000000000000000000000000010000000000000000000000000000, 28);
		test(F_CTZ_64, 64'b 0000000000000000000000000000000000100000000000000000000000000000, 29);
		test(F_CTZ_64, 64'b 0000000000000000000000000000000001000000000000000000000000000000, 30);
		test(F_CTZ_64, 64'b 0000000000000000000000000000000010000000000000000000000000000000, 31);
		test(F_CTZ_64, 64'b 0000000000000000000000000000000100000000000000000000000000000000, 32);
		test(F_CTZ_64, 64'b 0000000000000000000000000000001000000000000000000000000000000000, 33);
		test(F_CTZ_64, 64'b 0000000000000000000000000000010000000000000000000000000000000000, 34);
		test(F_CTZ_64, 64'b 0000000000000000000000000000100000000000000000000000000000000000, 35);
		test(F_CTZ_64, 64'b 0000000000000000000000000001000000000000000000000000000000000000, 36);
		test(F_CTZ_64, 64'b 0000000000000000000000000010000000000000000000000000000000000000, 37);
		test(F_CTZ_64, 64'b 0000000000000000000000000100000000000000000000000000000000000000, 38);
		test(F_CTZ_64, 64'b 0000000000000000000000001000000000000000000000000000000000000000, 39);
		test(F_CTZ_64, 64'b 0000000000000000000000010000000000000000000000000000000000000000, 40);
		test(F_CTZ_64, 64'b 0000000000000000000000100000000000000000000000000000000000000000, 41);
		test(F_CTZ_64, 64'b 0000000000000000000001000000000000000000000000000000000000000000, 42);
		test(F_CTZ_64, 64'b 0000000000000000000010000000000000000000000000000000000000000000, 43);
		test(F_CTZ_64, 64'b 0000000000000000000100000000000000000000000000000000000000000000, 44);
		test(F_CTZ_64, 64'b 0000000000000000001000000000000000000000000000000000000000000000, 45);
		test(F_CTZ_64, 64'b 0000000000000000010000000000000000000000000000000000000000000000, 46);
		test(F_CTZ_64, 64'b 0000000000000000100000000000000000000000000000000000000000000000, 47);
		test(F_CTZ_64, 64'b 0000000000000001000000000000000000000000000000000000000000000000, 48);
		test(F_CTZ_64, 64'b 0000000000000010000000000000000000000000000000000000000000000000, 49);
		test(F_CTZ_64, 64'b 0000000000000100000000000000000000000000000000000000000000000000, 50);
		test(F_CTZ_64, 64'b 0000000000001000000000000000000000000000000000000000000000000000, 51);
		test(F_CTZ_64, 64'b 0000000000010000000000000000000000000000000000000000000000000000, 52);
		test(F_CTZ_64, 64'b 0000000000100000000000000000000000000000000000000000000000000000, 53);
		test(F_CTZ_64, 64'b 0000000001000000000000000000000000000000000000000000000000000000, 54);
		test(F_CTZ_64, 64'b 0000000010000000000000000000000000000000000000000000000000000000, 55);
		test(F_CTZ_64, 64'b 0000000100000000000000000000000000000000000000000000000000000000, 56);
		test(F_CTZ_64, 64'b 0000001000000000000000000000000000000000000000000000000000000000, 57);
		test(F_CTZ_64, 64'b 0000010000000000000000000000000000000000000000000000000000000000, 58);
		test(F_CTZ_64, 64'b 0000100000000000000000000000000000000000000000000000000000000000, 59);
		test(F_CTZ_64, 64'b 0001000000000000000000000000000000000000000000000000000000000000, 60);
		test(F_CTZ_64, 64'b 0010000000000000000000000000000000000000000000000000000000000000, 61);
		test(F_CTZ_64, 64'b 0100000000000000000000000000000000000000000000000000000000000000, 62);
		test(F_CTZ_64, 64'b 1000000000000000000000000000000000000000000000000000000000000000, 63);
		test(F_CTZ_64, 64'b 0000000000000000000000000000000000000000000000000000000000000000, 64);

		test(F_CTZ_32, 64'b 0000000000000000000000000000000000000000000000000000000000000001,  0);
		test(F_CTZ_32, 64'b 0000000000000000000000000000000000000000000000000000000000000010,  1);
		test(F_CTZ_32, 64'b 0000000000000000000000000000000000000000000000000000000000000100,  2);
		test(F_CTZ_32, 64'b 0000000000000000000000000000000000000000000000000000000000001000,  3);
		test(F_CTZ_32, 64'b 0000000000000000000000000000000000000000000000000000000000010000,  4);
		test(F_CTZ_32, 64'b 0000000000000000000000000000000000000000000000000000000000100000,  5);
		test(F_CTZ_32, 64'b 0000000000000000000000000000000000000000000000000000000001000000,  6);
		test(F_CTZ_32, 64'b 0000000000000000000000000000000000000000000000000000000010000000,  7);
		test(F_CTZ_32, 64'b 0000000000000000000000000000000000000000000000000000000100000000,  8);
		test(F_CTZ_32, 64'b 0000000000000000000000000000000000000000000000000000001000000000,  9);
		test(F_CTZ_32, 64'b 0000000000000000000000000000000000000000000000000000010000000000, 10);
		test(F_CTZ_32, 64'b 0000000000000000000000000000000000000000000000000000100000000000, 11);
		test(F_CTZ_32, 64'b 0000000000000000000000000000000000000000000000000001000000000000, 12);
		test(F_CTZ_32, 64'b 0000000000000000000000000000000000000000000000000010000000000000, 13);
		test(F_CTZ_32, 64'b 0000000000000000000000000000000000000000000000000100000000000000, 14);
		test(F_CTZ_32, 64'b 0000000000000000000000000000000000000000000000001000000000000000, 15);
		test(F_CTZ_32, 64'b 0000000000000000000000000000000000000000000000010000000000000000, 16);
		test(F_CTZ_32, 64'b 0000000000000000000000000000000000000000000000100000000000000000, 17);
		test(F_CTZ_32, 64'b 0000000000000000000000000000000000000000000001000000000000000000, 18);
		test(F_CTZ_32, 64'b 0000000000000000000000000000000000000000000010000000000000000000, 19);
		test(F_CTZ_32, 64'b 0000000000000000000000000000000000000000000100000000000000000000, 20);
		test(F_CTZ_32, 64'b 0000000000000000000000000000000000000000001000000000000000000000, 21);
		test(F_CTZ_32, 64'b 0000000000000000000000000000000000000000010000000000000000000000, 22);
		test(F_CTZ_32, 64'b 0000000000000000000000000000000000000000100000000000000000000000, 23);
		test(F_CTZ_32, 64'b 0000000000000000000000000000000000000001000000000000000000000000, 24);
		test(F_CTZ_32, 64'b 0000000000000000000000000000000000000010000000000000000000000000, 25);
		test(F_CTZ_32, 64'b 0000000000000000000000000000000000000100000000000000000000000000, 26);
		test(F_CTZ_32, 64'b 0000000000000000000000000000000000001000000000000000000000000000, 27);
		test(F_CTZ_32, 64'b 0000000000000000000000000000000000010000000000000000000000000000, 28);
		test(F_CTZ_32, 64'b 0000000000000000000000000000000000100000000000000000000000000000, 29);
		test(F_CTZ_32, 64'b 0000000000000000000000000000000001000000000000000000000000000000, 30);
		test(F_CTZ_32, 64'b 0000000000000000000000000000000010000000000000000000000000000000, 31);
		test(F_CTZ_32, 64'b 0000000000000000000000000000000000000000000000000000000000000000, 32);

		test(F_CLZ_64, 64'b 1000000000000000000000000000000000000000000000000000000000000000,  0);
		test(F_CLZ_64, 64'b 0100000000000000000000000000000000000000000000000000000000000000,  1);
		test(F_CLZ_64, 64'b 0010000000000000000000000000000000000000000000000000000000000000,  2);
		test(F_CLZ_64, 64'b 0001000000000000000000000000000000000000000000000000000000000000,  3);
		test(F_CLZ_64, 64'b 0000100000000000000000000000000000000000000000000000000000000000,  4);
		test(F_CLZ_64, 64'b 0000010000000000000000000000000000000000000000000000000000000000,  5);
		test(F_CLZ_64, 64'b 0000001000000000000000000000000000000000000000000000000000000000,  6);
		test(F_CLZ_64, 64'b 0000000100000000000000000000000000000000000000000000000000000000,  7);
		test(F_CLZ_64, 64'b 0000000010000000000000000000000000000000000000000000000000000000,  8);
		test(F_CLZ_64, 64'b 0000000001000000000000000000000000000000000000000000000000000000,  9);
		test(F_CLZ_64, 64'b 0000000000100000000000000000000000000000000000000000000000000000, 10);
		test(F_CLZ_64, 64'b 0000000000010000000000000000000000000000000000000000000000000000, 11);
		test(F_CLZ_64, 64'b 0000000000001000000000000000000000000000000000000000000000000000, 12);
		test(F_CLZ_64, 64'b 0000000000000100000000000000000000000000000000000000000000000000, 13);
		test(F_CLZ_64, 64'b 0000000000000010000000000000000000000000000000000000000000000000, 14);
		test(F_CLZ_64, 64'b 0000000000000001000000000000000000000000000000000000000000000000, 15);
		test(F_CLZ_64, 64'b 0000000000000000100000000000000000000000000000000000000000000000, 16);
		test(F_CLZ_64, 64'b 0000000000000000010000000000000000000000000000000000000000000000, 17);
		test(F_CLZ_64, 64'b 0000000000000000001000000000000000000000000000000000000000000000, 18);
		test(F_CLZ_64, 64'b 0000000000000000000100000000000000000000000000000000000000000000, 19);
		test(F_CLZ_64, 64'b 0000000000000000000010000000000000000000000000000000000000000000, 20);
		test(F_CLZ_64, 64'b 0000000000000000000001000000000000000000000000000000000000000000, 21);
		test(F_CLZ_64, 64'b 0000000000000000000000100000000000000000000000000000000000000000, 22);
		test(F_CLZ_64, 64'b 0000000000000000000000010000000000000000000000000000000000000000, 23);
		test(F_CLZ_64, 64'b 0000000000000000000000001000000000000000000000000000000000000000, 24);
		test(F_CLZ_64, 64'b 0000000000000000000000000100000000000000000000000000000000000000, 25);
		test(F_CLZ_64, 64'b 0000000000000000000000000010000000000000000000000000000000000000, 26);
		test(F_CLZ_64, 64'b 0000000000000000000000000001000000000000000000000000000000000000, 27);
		test(F_CLZ_64, 64'b 0000000000000000000000000000100000000000000000000000000000000000, 28);
		test(F_CLZ_64, 64'b 0000000000000000000000000000010000000000000000000000000000000000, 29);
		test(F_CLZ_64, 64'b 0000000000000000000000000000001000000000000000000000000000000000, 30);
		test(F_CLZ_64, 64'b 0000000000000000000000000000000100000000000000000000000000000000, 31);
		test(F_CLZ_64, 64'b 0000000000000000000000000000000010000000000000000000000000000000, 32);
		test(F_CLZ_64, 64'b 0000000000000000000000000000000001000000000000000000000000000000, 33);
		test(F_CLZ_64, 64'b 0000000000000000000000000000000000100000000000000000000000000000, 34);
		test(F_CLZ_64, 64'b 0000000000000000000000000000000000010000000000000000000000000000, 35);
		test(F_CLZ_64, 64'b 0000000000000000000000000000000000001000000000000000000000000000, 36);
		test(F_CLZ_64, 64'b 0000000000000000000000000000000000000100000000000000000000000000, 37);
		test(F_CLZ_64, 64'b 0000000000000000000000000000000000000010000000000000000000000000, 38);
		test(F_CLZ_64, 64'b 0000000000000000000000000000000000000001000000000000000000000000, 39);
		test(F_CLZ_64, 64'b 0000000000000000000000000000000000000000100000000000000000000000, 40);
		test(F_CLZ_64, 64'b 0000000000000000000000000000000000000000010000000000000000000000, 41);
		test(F_CLZ_64, 64'b 0000000000000000000000000000000000000000001000000000000000000000, 42);
		test(F_CLZ_64, 64'b 0000000000000000000000000000000000000000000100000000000000000000, 43);
		test(F_CLZ_64, 64'b 0000000000000000000000000000000000000000000010000000000000000000, 44);
		test(F_CLZ_64, 64'b 0000000000000000000000000000000000000000000001000000000000000000, 45);
		test(F_CLZ_64, 64'b 0000000000000000000000000000000000000000000000100000000000000000, 46);
		test(F_CLZ_64, 64'b 0000000000000000000000000000000000000000000000010000000000000000, 47);
		test(F_CLZ_64, 64'b 0000000000000000000000000000000000000000000000001000000000000000, 48);
		test(F_CLZ_64, 64'b 0000000000000000000000000000000000000000000000000100000000000000, 49);
		test(F_CLZ_64, 64'b 0000000000000000000000000000000000000000000000000010000000000000, 50);
		test(F_CLZ_64, 64'b 0000000000000000000000000000000000000000000000000001000000000000, 51);
		test(F_CLZ_64, 64'b 0000000000000000000000000000000000000000000000000000100000000000, 52);
		test(F_CLZ_64, 64'b 0000000000000000000000000000000000000000000000000000010000000000, 53);
		test(F_CLZ_64, 64'b 0000000000000000000000000000000000000000000000000000001000000000, 54);
		test(F_CLZ_64, 64'b 0000000000000000000000000000000000000000000000000000000100000000, 55);
		test(F_CLZ_64, 64'b 0000000000000000000000000000000000000000000000000000000010000000, 56);
		test(F_CLZ_64, 64'b 0000000000000000000000000000000000000000000000000000000001000000, 57);
		test(F_CLZ_64, 64'b 0000000000000000000000000000000000000000000000000000000000100000, 58);
		test(F_CLZ_64, 64'b 0000000000000000000000000000000000000000000000000000000000010000, 59);
		test(F_CLZ_64, 64'b 0000000000000000000000000000000000000000000000000000000000001000, 60);
		test(F_CLZ_64, 64'b 0000000000000000000000000000000000000000000000000000000000000100, 61);
		test(F_CLZ_64, 64'b 0000000000000000000000000000000000000000000000000000000000000010, 62);
		test(F_CLZ_64, 64'b 0000000000000000000000000000000000000000000000000000000000000001, 63);
		test(F_CLZ_64, 64'b 0000000000000000000000000000000000000000000000000000000000000000, 64);


		test(F_CLZ_32, 64'b 0000000000000000000000000000000010000000000000000000000000000000,  0);
		test(F_CLZ_32, 64'b 0000000000000000000000000000000001000000000000000000000000000000,  1);
		test(F_CLZ_32, 64'b 0000000000000000000000000000000000100000000000000000000000000000,  2);
		test(F_CLZ_32, 64'b 0000000000000000000000000000000000010000000000000000000000000000,  3);
		test(F_CLZ_32, 64'b 0000000000000000000000000000000000001000000000000000000000000000,  4);
		test(F_CLZ_32, 64'b 0000000000000000000000000000000000000100000000000000000000000000,  5);
		test(F_CLZ_32, 64'b 0000000000000000000000000000000000000010000000000000000000000000,  6);
		test(F_CLZ_32, 64'b 0000000000000000000000000000000000000001000000000000000000000000,  7);
		test(F_CLZ_32, 64'b 0000000000000000000000000000000000000000100000000000000000000000,  8);
		test(F_CLZ_32, 64'b 0000000000000000000000000000000000000000010000000000000000000000,  9);
		test(F_CLZ_32, 64'b 0000000000000000000000000000000000000000001000000000000000000000, 10);
		test(F_CLZ_32, 64'b 0000000000000000000000000000000000000000000100000000000000000000, 11);
		test(F_CLZ_32, 64'b 0000000000000000000000000000000000000000000010000000000000000000, 12);
		test(F_CLZ_32, 64'b 0000000000000000000000000000000000000000000001000000000000000000, 13);
		test(F_CLZ_32, 64'b 0000000000000000000000000000000000000000000000100000000000000000, 14);
		test(F_CLZ_32, 64'b 0000000000000000000000000000000000000000000000010000000000000000, 15);
		test(F_CLZ_32, 64'b 0000000000000000000000000000000000000000000000001000000000000000, 16);
		test(F_CLZ_32, 64'b 0000000000000000000000000000000000000000000000000100000000000000, 17);
		test(F_CLZ_32, 64'b 0000000000000000000000000000000000000000000000000010000000000000, 18);
		test(F_CLZ_32, 64'b 0000000000000000000000000000000000000000000000000001000000000000, 19);
		test(F_CLZ_32, 64'b 0000000000000000000000000000000000000000000000000000100000000000, 20);
		test(F_CLZ_32, 64'b 0000000000000000000000000000000000000000000000000000010000000000, 21);
		test(F_CLZ_32, 64'b 0000000000000000000000000000000000000000000000000000001000000000, 22);
		test(F_CLZ_32, 64'b 0000000000000000000000000000000000000000000000000000000100000000, 23);
		test(F_CLZ_32, 64'b 0000000000000000000000000000000000000000000000000000000010000000, 24);
		test(F_CLZ_32, 64'b 0000000000000000000000000000000000000000000000000000000001000000, 25);
		test(F_CLZ_32, 64'b 0000000000000000000000000000000000000000000000000000000000100000, 26);
		test(F_CLZ_32, 64'b 0000000000000000000000000000000000000000000000000000000000010000, 27);
		test(F_CLZ_32, 64'b 0000000000000000000000000000000000000000000000000000000000001000, 28);
		test(F_CLZ_32, 64'b 0000000000000000000000000000000000000000000000000000000000000100, 29);
		test(F_CLZ_32, 64'b 0000000000000000000000000000000000000000000000000000000000000010, 30);
		test(F_CLZ_32, 64'b 0000000000000000000000000000000000000000000000000000000000000001, 31);
		test(F_CLZ_32, 64'b 0000000000000000000000000000000000000000000000000000000000000000, 32);

		$display("PASS");
	end
endmodule
