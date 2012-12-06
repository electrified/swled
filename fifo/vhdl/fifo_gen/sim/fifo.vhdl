--
-- Copyright (C) 2009-2012 Chris McClelland
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU Lesser General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU Lesser General Public License for more details.
--
-- You should have received a copy of the GNU Lesser General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.
--
library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fifo_wrapper is
	port(
		-- Clock and depth
		clk_in          : in  std_logic;
		depth_out       : out std_logic_vector(7 downto 0);

		-- Data is clocked into the FIFO on each clock edge where both valid & ready are high
		inputData_in    : in  std_logic_vector(7 downto 0);
		inputValid_in   : in  std_logic;
		inputReady_out  : out std_logic;

		-- Data is clocked out of the FIFO on each clock edge where both valid & ready are high
		outputData_out  : out std_logic_vector(7 downto 0);
		outputValid_out : out std_logic;
		outputReady_in  : in  std_logic
	);
end fifo_wrapper;

architecture structural of fifo_wrapper is
begin
	-- The encapsulated FIFO
	fifo: entity work.fifo
		generic map(
			WIDTH => 8,
			DEPTH => 7
		)
		port map(
			clk_in          => clk_in,
			reset_in        => '0',
			depth_out       => depth_out,

			-- Input pipe
			inputData_in    => inputData_in,
			inputValid_in   => inputValid_in,
			inputReady_out  => inputReady_out,

			-- Output pipe
			outputData_out  => outputData_out,
			outputValid_out => outputValid_out,
			outputReady_in  => outputReady_in
		);
	
end structural;