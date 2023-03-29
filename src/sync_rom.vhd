library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

entity sync_rom is
    generic (
        ADDR_WIDTH: integer := 16;
        DATA_WIDTH: integer := 8 );
  port(
     clk    : in std_logic;
     addr_r : in std_logic_vector(ADDR_WIDTH  -1 downto 0);
     data   : out std_logic_vector(DATA_WIDTH -1 downto 0)
  );
end sync_rom;

architecture arch of sync_rom is 
constant ROM_DEPTH: integer := (2**ADDR_WIDTH); --rows in ROM 

type rom_type is array (0 to ROM_DEPTH-1) of std_logic_vector(DATA_WIDTH -1 downto 0);--ROM type

impure function init_rom return rom_type is
--declarative region 
    file text_file_8_bit: text open READ_MODE is "./cpp_result_8_bit.txt ";
    file text_file_16_bit: text open READ_MODE is "./cpp_result_16_bit.txt ";

    variable text_line: line; --store the lines
    variable value: std_logic_vector(DATA_WIDTH-1 downto 0); --store the single values that are read per each line 

    variable rom_content : rom_type; --store the text line results in an array of rom type 
    

begin
--sequential code 
    for i in 0 to ROM_DEPTH-1 loop
        if ADDR_WIDTH =8 then
        --reading file
            readline(text_file_8_bit,text_line);
        else
            readline(text_file_16_bit,text_line);
        end if;
        
        read(text_line,value);
        --store in array
        rom_content(i) := value;
        end loop;
        
        return rom_content; --return the contents of the array 
end function;

      signal rom: rom_type := init_rom;
      begin
        process(clk)
        begin
          if (rising_edge (clk)) then
             data <= rom(to_integer(unsigned(addr_r))); --convert to integer and store in data
          end if; 
        end process;
      end arch;