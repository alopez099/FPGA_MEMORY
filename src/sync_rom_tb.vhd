 library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;
entity sync_rom_tb is
 -- port();
end sync_rom_tb;

architecture arch of sync_rom_tb is 

component sync_rom is
    generic (
        ADDR_WIDTH: integer := 8;
        DATA_WIDTH: integer := 4 );
  port(
     clk    : in std_logic;
     addr_r : in std_logic_vector(ADDR_WIDTH  -1 downto 0);
     data   : out std_logic_vector(DATA_WIDTH -1 downto 0)
  );
end component;

constant ADDR_WIDTH_tb: integer := 8;
constant DATA_WIDTH_tb: integer := 4;

signal clk_tb    : std_logic;
signal addr_r_tb : std_logic_vector(ADDR_WIDTH_tb  -1 downto 0);
signal data_tb   : std_logic_vector(DATA_WIDTH_tb -1 downto 0);

signal counter: integer := 0;
constant CP: time := 10ns;
begin

uut: sync_rom generic map (
  ADDR_WIDTH => ADDR_WIDTH_tb,
  DATA_WIDTH => DATA_WIDTH_tb
  )
  port map(
   clk =>   clk_tb,
   addr_r=> addr_r_tb,
   data=>   data_tb
  );

process
begin
  clk_tb <= '0';
  wait for CP/2;  
  clk_tb <= '1';
  wait for CP/2;
end process;

process(clk_tb)
begin
  if (rising_edge (clk_tb)) then
    addr_r_tb <=std_logic_vector (TO_UNSIGNED(counter, ADDR_WIDTH_tb));
    counter <= counter + 1;
  if counter >= 2**ADDR_WIDTH_tb-1 then
     counter <=0;
  end if;
  end if;
end process; 
end arch;