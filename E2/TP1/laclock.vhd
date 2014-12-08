library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity clockCounter is
	generic (
		       n   : natural := 4;
		       max : natural := 9
	        );
	port (
		    dataOut  : out std_logic_vector(n-1 downto 0);
		    equalMax : out std_logic;
		    enable   : in std_logic;
		    razs     : in std_logic;

		    clk      : in std_logic;
		    reset    : in std_logic
	     );
end clockCounter;

architecture clockCounterArch of clockCounter is
	signal inc, eno, D, Q : std_logic_vector(n-1 downto 0);
begin
	dataOut  <= Q;
	process (clk, reset) is
	begin
		if reset = '1'         then Q <= (others => '0');
		elsif rising_edge(clk) then Q <= D;
		end if;
	end process;

	inc      <= (others => '0') when unsigned(Q) = max   else
	            std_logic_vector(unsigned(Q)+1);

	eno      <= inc when enable = '1'                    else
	            Q;

	D        <= (others => '0')  when razs = '1'         else
	            eno;

	equalMax <= '1' when unsigned(Q) = max               else
	            '0';
end clockCounterArch;
