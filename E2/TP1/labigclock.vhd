library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bigClock is
	port (
		    minuteUnits  : out std_logic_vector(3 downto 0);
		    minuteTenths : out std_logic_vector(3 downto 0);

		    hoursUnits   : out std_logic_vector(3 downto 0);
		    hoursTenths  : out std_logic_vector(3 downto 0);
		    ctr          : out std_logic_vector(42 downto 7);

		    clk          : in std_logic;
		    reset        : in std_logic
	     );
end bigClock;

architecture bigClockArch of bigClock is
	signal mu_eq9, mt_eq5, m_eq59, mhu_eq959, hu_eq3, hu_eq9, ht_eq2, mh_eq2359, generalEnable, muEnable, mtEnable, htEnable, huEnable, mtRazs: std_logic;
	signal mUnits, mTenths, hUnits, hTenths : std_logic_vector(3 downto 0);
	signal counter : std_logic_vector(42 downto 7); -- Yeah!

begin
	process (clk, reset) is
	begin
		if reset = '1'         then counter <= (others => '0');
		elsif rising_edge(clk) then
			if unsigned(counter) >= 499 then
				counter <= (others => '0');
			else counter <= std_logic_vector(unsigned(counter) + 1);
			end if;
		end if;
	end process;
	ctr           <= counter;
	minuteUnits   <= mUnits;
	minuteTenths  <= mTenths;
	hoursUnits    <= hUnits;
	hoursTenths   <= hTenths;
	generalEnable <= '1' when unsigned(counter) >= 499 else '0';

	minuteUnitsComponent : entity work.clockCounter port map (
			enable   => muEnable,
			razs     => mh_eq2359,
			equalMax => mu_eq9,
			clk      => clk,
			reset    => reset,
			dataOut  => mUnits
		);
	minuteTenthsComponent : entity work.clockCounter
		generic map (
			max => 5
		)
		port map (
			enable   => mtEnable,
			razs     => mtRazs,
			equalMax => mt_eq5,
			clk      => clk,
			reset    => reset,
			dataOut  => mTenths
		);


	hoursUnitsComponent : entity work.clockCounter port map (
			enable   => huEnable,
			razs     => mh_eq2359,
			equalMax => hu_eq9,
			clk      => clk,
			reset    => reset,
			dataOut  => hUnits
		);
	hoursTenthsComponent : entity work.clockCounter port map (
			enable  => htEnable,
			razs    => mh_eq2359,
			clk     => clk,
			reset   => reset,
			dataOut => hTenths
		);
	m_eq59    <= mt_eq5 and mu_eq9;
	mhu_eq959 <= m_eq59 and hu_eq9;
	hu_eq3    <= '1' when hUnits  = "0011" else '0';
	ht_eq2    <= '1' when hTenths = "0010" else '0';
	mh_eq2359 <= ht_eq2 and hu_eq3 and m_eq59;
	muEnable  <= generalEnable;
	mtEnable  <= generalEnable and mu_eq9;
	huEnable  <= generalEnable and m_eq59;
	htEnable  <= generalEnable and mhu_eq959;
	mtRazs    <= m_eq59 or mh_eq2359;

end bigClockArch;
