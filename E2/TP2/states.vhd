library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity states is
	port (
		n : in std_logic_vector(1 downto 0);

		--    _A
		--  F|_|B
		--  E|_|C
		--    D

		a : out std_logic;
		b : out std_logic;
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

	a <= '0' when unsigned(n) = 3 else '1';
	b <= '1';
	c <= '0' when unsigned(n) = 2 else '1';
	d <= '0' when unsigned(n) = 1 else '1';
	e <= '0' when unsigned(n) = 2 or unsigned(n) = 3 else '1';
	f <= '0' when unsigned(n) = 3 else '1';
	g <= '0' when unsigned(n) = 2 else '1';
end statesArch;
