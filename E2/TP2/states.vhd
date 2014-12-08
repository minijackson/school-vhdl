library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity states is
	port (
		n : in std_logic_vector(2 downto 0);

		--    _A
		--  F|_|B
		--  E|_|C
		--    D

		a : out std_logic;
		c : out std_logic;
		d : out std_logic;
		e : out std_logic;
		f : out std_logic;
		g : out std_logic;
	);
end states

architecture statesArch of states is
begin

	-- State 0:   State 1:   State 2:   State 3:
	--                                   _
	--                        _         |
	--             _         | |        |

	a <= '1' when unsigned(n) = 3 else '0';
	c <= '1' when unsigned(n) = 2 else '0';
	d <= '1' when unsigned(n) = 1 else '0';
	e <= '1' when unsigned(n) = 2 or unsigned(n) = 3 else '0';
	f <= '1' when unsigned(n) = 3 else '0';
	g <= '1' when unsigned(n) = 2 else '0';
end statesArch;
