--------------------------------------------------------------------------------
--  Author: Caio Iriarte
--  Project: Memory Pseudo Code

--  Code:   VHDL Memory Package
--  File:   mem_package.vhd
--------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

-- Package Declaration Section
package mem_package is
    --  Function meant to check data correspondence - return
    --  true:   Everything went well
    --  false:  Failure in correspondence/process
    function check_data(    data_in : in std_logic_vector;
                            data_str : in string(4 downto 1))
            return boolean;
            
    --  Function of std_logic_vector obtention from string - return
    --  'std_logic_vector' value of string
    function obtain_vec_str( in_str : in string(4 downto 1))
            return std_logic_vector;
            
    --  Obtention of string from std_logic_vector - return
    --  string value of 'std_logic_vector'
    function vec_to_string(in_vec : std_logic_vector) return string;
    
    --  Obtain std_logic_vector from string text chain
    function obtain_vec_txt(    in_str : string(2 downto 1))
        return std_logic_vector;
        
end package mem_package;
 
-- Package Body Section
package body mem_package is
    ------------------------------------------------------------
    function check_data(   data_in : in std_logic_vector;
                            data_str : in string(4 downto 1))
            return boolean is
    variable STR_AUX : std_logic_vector(15 downto 0);
    variable PROC : boolean := true;
    begin
        if(data_str'length /= 4) then
            PROC := false;  --  Error
        else
            STR_AUX := obtain_vec_str(data_str);
            
            --  Data values don't coincide
            if(STR_AUX /= data_in) then
                PROC := false;
            end if;
        end if;
        
        return PROC;
    end function;
    
    ------------------------------------------------------------
    function obtain_vec_txt(    in_str : string(2 downto 1))
        return std_logic_vector is
    variable str_def : string(2 downto 1) := in_str;
    variable vec_ret : std_logic_vector(3 downto 0);
    begin
        case str_def is
            when "00" =>
                vec_ret := "0000";
            when "01" =>
                vec_ret := "0001";
            when "02" =>
                vec_ret := "0010";
            when "03" =>
                vec_ret := "0011";
            when "04" =>
                vec_ret := "0100";
            when "05" =>
                vec_ret := "0101";
            when "06" =>
                vec_ret := "0110";
            when "07" =>
                vec_ret := "0111";
            when "08" =>
                vec_ret := "1000";
            when "09" =>
                vec_ret := "1001";
            when "10" =>
                vec_ret := "1010";
            when "11" =>
                vec_ret := "1011";
            when "12" =>
                vec_ret := "1100";
            when "13" =>
                vec_ret := "1101";
            when "14" =>
                vec_ret := "1110";
            when others =>
                vec_ret := "1111";
        end case;
        
        return vec_ret;
    end function;
    
    ------------------------------------------------------------
    function obtain_vec_str( in_str : in string(4 downto 1))
        return std_logic_vector is
    variable STR_AUX : std_logic_vector(16 downto 1);
    variable DATA : character;
    begin
        --  'i' goes from 4 to 1
        for i in in_str'range loop
            DATA := in_str(i);
            
            case DATA is
                when '1' =>
                    STR_AUX(i*4 downto (i*4 - 3)) := "0001";
                when '2' =>
                    STR_AUX(i*4 downto (i*4 - 3)) := "0010";
                when '3' =>
                    STR_AUX(i*4 downto (i*4 - 3)) := "0011";
                when '4' =>
                    STR_AUX(i*4 downto (i*4 - 3)) := "0100";
                when '5' =>
                    STR_AUX(i*4 downto (i*4 - 3)) := "0101";
                when '6' =>
                    STR_AUX(i*4 downto (i*4 - 3)) := "0110";
                when '7' =>
                    STR_AUX(i*4 downto (i*4 - 3)) := "0111";
                when '8' =>
                    STR_AUX(i*4 downto (i*4 - 3)) := "1000";
                when '9' =>
                    STR_AUX(i*4 downto (i*4 - 3)) := "1001";
                when 'A' =>
                    STR_AUX(i*4 downto (i*4 - 3)) := "1010";
                when 'B' =>
                    STR_AUX(i*4 downto (i*4 - 3)) := "1011";
                when 'C' =>
                    STR_AUX(i*4 downto (i*4 - 3)) := "1100";
                when 'D' =>
                    STR_AUX(i*4 downto (i*4 - 3)) := "1101";
                when 'E' =>
                    STR_AUX(i*4 downto (i*4 - 3)) := "1110";
                when 'F' =>
                    STR_AUX(i*4 downto (i*4 - 3)) := "1111";
                when others =>
                    STR_AUX(i*4 downto (i*4 - 3)) := "0000";
            end case;
        end loop;
        
        return STR_AUX;
    end function;
    
    ------------------------------------------------------------
    function vec_to_string(in_vec : std_logic_vector) return string is
        constant hex_map : string(1 to 16) := "0123456789ABCDEF";
        variable result : string(in_vec'length/4 downto 1);
        variable idx : integer;
    begin
        for i in result'range loop
            idx := to_integer(unsigned(in_vec((4*i-1) downto 4*i-4)));
            result(i) := hex_map(idx + 1);
        end loop;
        return result;
    end function;

    ------------------------------------------------------------
end package body mem_package;
