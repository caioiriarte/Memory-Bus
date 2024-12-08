--------------------------------------------------------------------------------
--  Author: Caio Iriarte
--  Project: Dual port memory

--  Code:   VHDL inferred description of DP_MEM entity behaviour
--  File:   inf_mem.vhd
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

architecture RTL of dp_mem is

--  MEMTYPE must be defined as 16-element matrix of vectors
type MEMTYPE is array (15 downto 0) of std_logic_vector(15 downto 0);
signal dp_memo : MEMTYPE := (others => (others => '0'));
signal addra_int,addrb_int : integer range 0 to 15;


begin

addra_int <= TO_INTEGER(unsigned(addra));
addrb_int <= TO_INTEGER(unsigned(addrb));

process(clka, clkb)
begin
    -- Memory writing (port A)
    if rising_edge(clka) and wea = '1' then
        dp_memo(addra_int) <= dina;
    end if;

    -- Memory reading (port B)
    if rising_edge(clkb) then
        doutb <= dp_memo(addrb_int);
    end if;
end process;

end RTL;
