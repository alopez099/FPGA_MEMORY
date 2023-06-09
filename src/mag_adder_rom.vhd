library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;
entity sync_rom_template is
  port(
     clk    : in std_logic;
     addr_r : in std_logic_vector(7 downto 0);
     data   : out std_logic_vector(3 downto 0)
  );
end sync_rom_template;

architecture arch of sync_rom_template is
  constant ADDR_WIDTH : integer:=8;
  constant DATA_WIDTH : integer:=4;
  type rom_type is array (0 to 2**ADDR_WIDTH-1)
       of std_logic_vector(DATA_WIDTH-1 downto 0);
       -- ROM definition
  constant SIGN_MAG_ADDR_LUT: rom_type:=(  
    "0000",
    "0001",
    "0010",
    "0011",
    "0100",
    "0101",
    "0110",
    "0111",
    "0000",
    "0001",
    "0010",
    "0011",
    "0100",
    "0101",
    "0110",
    "0111",
    "0001",
    "0010",
    "0011",
    "0100",
    "0101",
    "0110",
    "0111",
    "0000",
    "0000",
    "0000",
    "0010",
    "0011",
    "0100",
    "0101",
    "0110",
    "0111",
    "0010",
    "0011",
    "0100",
    "0101",
    "0110",
    "0111",
    "0000",
    "0001",
    "0000",
    "0000",
    "0000",
    "0011",
    "0100",
    "0101",
    "0110",
    "0111",
    "0011",
    "0100",
    "0101",
    "0110",
    "0111",
    "0000",
    "0001",
    "0010",
    "0000",
    "0000",
    "0000",
    "0000",
    "0100",
    "0101",
    "0110",
    "0111",
    "0100",
    "0101",
    "0110",
    "0111",
    "0000",
    "0001",
    "0010",
    "0011",
    "0000",
    "0000",
    "0000",
    "0000",
    "0000",
    "0101",
    "0110",
    "0111",
    "0101",
    "0110",
    "0111",
    "0000",
    "0001",
    "0010",
    "0011",
    "0100",
    "0000",
    "0000",
    "0000",
    "0000",
    "0000",
    "0000",
    "0110",
    "0111",
    "0110",
    "0111",
    "0000",
    "0001",
    "0010",
    "0011",
    "0100",
    "0101",
    "0000",
    "0000",
    "0000",
    "0000",
    "0000",
    "0000",
    "0000",
    "0111",
    "0111",
    "0000",
    "0001",
    "0010",
    "0011",
    "0100",
    "0101",
    "0110",
    "0000",
    "0000",
    "0000",
    "0000",
    "0000",
    "0000",
    "0000",
    "0000",
    "0000",
    "0001",
    "0010",
    "0011",
    "0100",
    "0101",
    "0110",
    "0111",
    "0000",
    "1001",
    "1010",
    "1011",
    "1100",
    "1101",
    "1110",
    "1111",
    "1001",
    "0000",
    "0010",
    "0011",
    "0100",
    "0101",
    "0110",
    "0111",
    "1001",
    "1010",
    "1011",
    "1100",
    "1101",
    "1110",
    "1111",
    "1000",
    "1001",
    "1001",
    "0000",
    "0011",
    "0100",
    "0101",
    "0110",
    "0111",
    "1010",
    "1011",
    "1100",
    "1101",
    "1110",
    "1111",
    "1000",
    "1001",
    "1001",
    "1001",
    "1001",
    "0000",
    "0100",
    "0101",
    "0110",
    "0111",
    "1011",
    "1100",
    "1101",
    "1110",
    "1111",
    "1000",
    "1001",
    "1010",
    "1001",
    "1001",
    "1001",
    "1001",
    "0000",
    "0101",
    "0110",
    "0111",
    "1100",
    "1101",
    "1110",
    "1111",
    "1000",
    "1001",
    "1010",
    "1011",
    "1001",
    "1001",
    "1001",
    "1001",
    "1001",
    "0000",
    "0110",
    "0111",
    "1101",
    "1110",
    "1111",
    "1000",
    "1001",
    "1010",
    "1011",
    "1100",
    "1001",
    "1001",
    "1001",
    "1001",
    "1001",
    "1001",
    "0000",
    "0111",
    "1110",
    "1111",
    "1000",
    "1001",
    "1010",
    "1011",
    "1100",
    "1101",
    "1001",
    "1001",
    "1001",
    "1001",
    "1001",
    "1001",
    "1001",
    "0000",
    "1111",
    "1000",
    "1001",
    "1010",
    "1011",
    "1100",
    "1101",
    "1110");
      signal rom : rom_type := SIGN_MAG_ADDR_LUT ;
      begin
        process(clk)
        begin
          if (clk'event and clk = '1') then
             data <= rom(to_integer(unsigned(addr_r)));
          end if;
        end process;
      end arch;