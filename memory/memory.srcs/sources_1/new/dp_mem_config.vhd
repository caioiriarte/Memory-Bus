--------------------------------------------------------------------------------
--  Author: Caio Iriarte
--  Project: Memory Pseudo Code

--  Code:   VHDL DP_MEM configuration file
--  File:   dp_mem_config.vhd
--------------------------------------------------------------------------------

--  Don't forget to include default library

library xil_defaultlib;

configuration RTL_TEST of mem_bus is
    for BEHAVE
        for U2 : dp_mem
            --  'RTL' for inferred version
            use entity xil_defaultlib.dp_mem(RTL);
        end for;
    end for;
end configuration;