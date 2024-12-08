--------------------------------------------------------------------------------
--  Author: Caio Iriarte
--  Project: Memory Pseudo Code

--  Code:   VHDL Memory Bus entity
--  File:   mem_bus.vhd
--------------------------------------------------------------------------------


library IEEE;
library mem_lib;
use mem_lib.mem_package.all;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity mem_bus is
    port(   addrv : std_logic_vector(3 downto 0);
            wrfb : in std_logic;
            csfb : in std_logic;
            dt_in : in string(4 downto 1);
            dt_out : out string(4 downto 1) := "0000";
            ackb : out std_logic;
            bus_clk : in std_logic;
            
            --  Clock signals for DP memory
            clk_a1 : in std_logic;
            clk_b1 : in std_logic
            );
end mem_bus;

--------    -------------   --------------  -------------   --------------

architecture BEHAVE of mem_bus is

--  Memory component definition
--  The bus instance connects with the memory instance
component dp_mem is
	port (
	addra: IN std_logic_VECTOR(3 downto 0);
	addrb: IN std_logic_VECTOR(3 downto 0);
	clka: IN std_logic;
	clkb: IN std_logic;
	dina: IN std_logic_VECTOR(15 downto 0);
	dinb: IN std_logic_VECTOR(15 downto 0);
	douta: OUT std_logic_VECTOR(15 downto 0);
	doutb: OUT std_logic_VECTOR(15 downto 0);
	wea: IN std_logic;
	web: IN std_logic);
end component;


--  Memory signals definition
signal we_a : std_logic := '1';
signal we_b : std_logic := '0';
signal din_a,din_b,dout_a,dout_b : std_logic_vector(15 downto 0) := (others => '0');
signal addr_a,addr_b : std_logic_vector(3 downto 0) := "0000";
signal dina_prev : std_logic_vector(15 downto 0) := (others => '0');
signal adb_prev : std_logic_vector(3 downto 0) := "0000";

signal ack : std_logic := '0';
signal read_op : integer := 0;
signal wrf_b : std_logic := '0';
signal ret_a: integer := 1;


begin


--  Instance for DP memory
U2 : dp_mem
    port map(
        wea => we_a,
        web => we_b,
        dina => din_a,
        dinb => din_b,
        douta => dout_a,
        doutb => dout_b,
        clka => clk_a1,
        clkb => clk_b1,
        addra => addr_a,
        addrb => addr_b
    );



process(clk_a1)
begin
    --  Writing port clock process
    if clk_a1'event and clk_a1 = '1' then
        if dina_prev /= din_a and ack = '1' and wrfb = '0' then
            we_a <= '1';
            ret_a <= 1;
            dina_prev <= din_a;
            
        elsif we_a = '1' then
            if ret_a > 0 then
                ret_a <= 0;
            else
                we_a <= '0';
            end if;
        end if;
    end if;
end process;



process(clk_b1)
begin
    --  Reading port clock process
    if clk_b1'event and clk_b1 = '1' then
        if wrfb = '1' then
            dt_out <= vec_to_string(dout_b);
        end if;
    end if;
end process;



--  Bus process operation
process(bus_clk)

    procedure write_data is
    begin
        --  Update value to FIFO memory
        addr_a <= addrv;
        din_a <= obtain_vec_str(dt_in);
    end procedure;
    
    procedure read_data is
    begin
        --  Get data for port B
        addr_b <= addrv;
    end procedure;
    
    variable a_addr : std_logic_vector(3 downto 0);
    variable a_din : std_logic_vector(15 downto 0);
    variable read_pm : integer;
begin
    
    --  Bus clock process
    if bus_clk'event and bus_clk = '1' and csfb = '0' then
        if(read_op > 0) then
            read_pm := read_op - 1;
            
            --  Acknowledge bit received
            if(read_pm = 0 and ack = '1') then
                ack <= '0';
            end if;
            
            read_op <= read_pm;
            
        else
            --  Read operation
            if wrfb = '1' then
                read_data;
            
            --  Write operation
            elsif wrfb = '0' then
                write_data;   
            end if;
            
            --  Detect changes in wrf bit
            if  wrf_b /= wrfb then
                ack <= '1';
                read_op <= 1;
            
                wrf_b <= wrfb;
            end if;
        end if;
    end if;
end process;

ackb <= ack;

end BEHAVE;
