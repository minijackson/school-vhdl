library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity clock is
	port (
		    enable       : in std_logic;
		    razs         : in std_logic;

		    minuteUnits  : out std_logic_vector(3 downto 0);
		    minuteTenths : out std_logic_vector(2 downto 0);

		    hoursUnits   : out std_logic_vector(3 downto 0);
		    hoursTenths  : out std_logic_vector(1 downto 0);

		    clk          : in std_logic;
		    reset        : in std_logic;
	     );
end clock;

architecture clockArch of clock is
begin
	minuteUnitsComponent : entity clockCounter port map (
	        enable  => enable,
			razs    => razs,
			clk     => clk,
			reset   => reset,
			dataOut => minuteUnitsValue
		);
	minuteTenthsComponent : entity clockCounter
		generic map (
			n   => 3,
			max => 5
		);
		port map (
			enable  => enable,
			razs    => razs,
			clk     => clk,
			reset   => reset,
			dataOut => minuteTenthsValue
		);


	hoursUnitsComponent : entity clockCounter
		port map (
			enable  => enable,
			razs    => razs,
			clk     => clk,
			reset   => reset,
			dataOut => hoursUnitsValue
		);
	hoursTenthsComponent : entity clockCounter
		generic map (
			n   => 2,
			max => 2
		);
		port map (
			enable  => enable,
			razs    => razs,
			clk     => clk,
			reset   => reset,
			dataOut => hoursTenthsValue
		);
end clockArch;

entity clockCounter is
	generic (
		       n   : natural := 4;
		       max : natural := 9;
	        );
	port (
		    dataOut : out std_logic_vector(n-1 downto 0);

		    enable  : in std_logic;
		    razs    : in std_logic;

		    clk     : in std_logic;
		    reset   : in std_logic;
	     );
end clockCounter;

architecture clockCounterArch of clock is
	signal inc, eno, D, Q : std_logic_vector(n-1 downto 0);
begin
	dataOut <= Q
	Q       <= '0' when reset = '1'  else
	            D  when rising_edge(clk);

	inc     <=  0  when Q = max      else
	           Q+1;

	eno     <= inc when enable = '1' else
	            Q;

	D       <= '0' when razs = '1'   else
	           eno;
end clockCounterArch;
