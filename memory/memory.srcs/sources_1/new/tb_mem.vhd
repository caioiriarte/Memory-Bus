--------------------------------------------------------------------------------
--  Author: Caio Iriarte
--  Project: Dual port memory

--  Code:   VHDL DP_MEM testbench
--  File:   tb_mem.vhd
--------------------------------------------------------------------------------


library IEEE;
library mem_lib;
library std;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use mem_lib.mem_package.all;
use std.textio.all;

--  Entity definition
entity tb_mem is
end tb_mem;


--  Behaviour definition
architecture TEST of tb_mem is

--  Bus component definition
component mem_bus is
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
end component;

--  Signals definition - bus port
signal csf_b,ack_b : std_logic := '0';
signal wrf_b : std_logic;
signal addr_v : std_logic_vector(3 downto 0);
signal data_in : string(4 downto 1) := "0000";
signal data_out : string(4 downto 1);
signal clk_bus : std_logic := '0';
signal clk_a,clk_b : std_logic := '0';


--  File read definition
file data_file : text;


begin

    
    U1 : mem_bus
    port map(
        addrv => addr_v,
        wrfb => wrf_b,
        csfb => csf_b,
        dt_in => data_in,
        dt_out => data_out,
        ackb => ack_b,
        bus_clk => clk_bus,
        clk_a1 => clk_a,
        clk_b1 => clk_b
    );
    
    clk_bus <= not clk_bus after 15ns;
    clk_a <= not clk_a after 5ns;
    clk_b <= not clk_b after 10ns;
    
    
    --  Test definition
    test_mem : process
        variable line_in : line;
        variable dummy : character;
        variable instruction : string(5 downto 1);
        variable address : string(2 downto 1);
        variable data : string(4 downto 1);
        variable ins : string(5 downto 1);
        
        --  Retards needed for writing and reading operations
        --  Given the periods of 10ns (CLK_A), 20ns (CLK_B) and
        --  30ns (CLK_BUS)
        procedure wait_process is
        begin
            wait until rising_edge(clk_bus);
            wait until rising_edge(clk_bus);
        end procedure;
    
        begin
            --  Initial conditions
            addr_v <= "0000";
            csf_b <= '0';
            wrf_b <= '1';
            data_in <= "0000";
            
            --  Needed for establishing addr_a
            --  for writing address
            wait_process;
            wrf_b <= '0';
            
            --  Return to default state (read mode from bus)
            wait_process;
            wrf_b <= '1';
            
            --  Start data processing
            file_open(data_file,"../instructions.txt",READ_MODE);
            readline(data_file, line_in);
            readline(data_file, line_in);
            read(line_in,instruction);
            
            --  Simulation start (all values and components set)
            wait_process;
            wait_process;
            
            while instruction /= "END  " loop
                read(line_in,dummy);
                read(line_in,address);
                read(line_in,dummy);
                read(line_in,data);
                
                if(instruction = "READ ") then      --  Read process
                    addr_v <= obtain_vec_txt(address);
                    wait_process;
                    
                    --  State read and wait to get value
                    wrf_b <= '1';
                    wait_process;
                    
                    assert check_data(obtain_vec_str(data_out),data) report 
                        "Data not coincident." severity error;
                        
                else    --  Write process
                    --  Update value to bus
                    data_in <= data;
                    addr_v <= obtain_vec_txt(address);
                    wait_process;
                    wrf_b <= '0';
                    
                    --  Wait for process to finish
                    wait_process;
                end if;
                
                readline(data_file, line_in);
                read(line_in,instruction);
            end loop;
            
        -- Close the archive
        file_close(data_file);
        
        wait;
    end process;

end TEST;
