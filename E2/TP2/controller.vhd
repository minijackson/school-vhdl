library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- clk,
-- reset,┌────────────────────────────────────┐
--  speed│ ┌───────┐segs┌───┐dat×4 ┌────────┐ │
--     ━━┿┳┥ ctrl  ┝━━━┱┤sta┝━━━━━━┥ basys2 ┝━┿━━
--       │┃│       │   ┃└───┘┏━━━━━┥ display│ │ seg,
--       │┃└───────┘   ┃┌───┐┃┏━━━━┥  ctrl  │ │  dp,
--       │┃    ↑       ┠┤sta┝┛┃┏━━━┥        │ │  an
--       │┃ You are    ┃└───┘ ┃┃   └──┰─────┘ │
--       │┃   here     ┃┌───┐ ┃┃      ┃       │
--       │┃            ┠┤sta┝━┛┃      ┃       │
--       │┃            ┃└───┘  ┃      ┃       │
--       │┃            ┃┌───┐  ┃      ┃       │
--       │┃            ┖┤sta┝━━┛      ┃       │
--       │┃             └───┘         ┃       │
--       │┗━━━━━━━━━━━━━━━━━━━━━━━━━━━┛       │
--       │                                    │
--       │                                    │
--       │                                    │
--       └────────────────────────────────────┘
--
-- Components:
-- ===========
--
-- controller (ctrl):
--      provides data for the foru 7-segments displayer considering
--      the clock and speed.
--
-- states (sta):
--      converts a data fragment provided by ctrl to actual bits for a
--      7-segment displayer
--
-- basys2_display_controller (basys2 display ctrl)
--      converter that provides data directly usable by the basys2 card
--
-- Internal signals:
-- =================
--
-- segs is a bus containing the states for the four 7-segments displayer
--
-- dat  contains data for a 7-segment displayer

entity controller is
	port (
		clk   : in std_logic;
		reset : in std_logic;

		segmentStates : out std_logic_vector(7 downto 0);
	);
end controller;

architecture controllerArch of controller is
	segmentStatesEx : std_logic_vector(15 downto 0);
begin
	segmentStates <= segmentStatesEx(7 downto 0);

	process (clk, reset) is
	begin
		if reset = '1' then segmentStatesEx <= "12130000";
		elsif rising_edge(clk) then segmentStatesEx <= segmentStatesEx ror 2;
		end if
	end process

end controllerArch;
