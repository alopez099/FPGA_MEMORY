library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fiffo_tb is
--  Port ( );
end fiffo_tb;
architecture Behavioral of fiffo_tb is

component fifo is
  generic(
     ADDR_WIDTH : integer := 4;
     DATA_WIDTH : integer := 8
  );
  port(
     clk, reset : in  std_logic;
     rd, wr     : in  std_logic;
     w_data     : in  std_logic_vector(DATA_WIDTH - 1 downto 0);
     empty      : out std_logic;
     full       : out std_logic;
     w_count    : out std_logic_vector(ADDR_WIDTH downto 0);
     r_data     : out std_logic_vector(DATA_WIDTH - 1 downto 0);
     almost_empty: out std_logic;
     almost_full: out std_logic
  );
end component;
constant DATA_WIDTH_tb : integer:= 8;
constant ADDR_WIDTH_tb : integer:= 4;
signal      clk_tb, reset_tb :   std_logic;
signal      rd_tb, wr_tb  :   std_logic;
signal      w_data_tb  :   std_logic_vector(DATA_WIDTH_tb - 1 downto 0);
signal      empty_tb   :  std_logic;
signal      full_tb    :  std_logic;
signal      r_data_tb  :  std_logic_vector(DATA_WIDTH_tb - 1 downto 0);
signal     w_count_tb    :  std_logic_vector(ADDR_WIDTH_tb downto 0);
signal     almost_empty_tb:  std_logic;
signal     almost_full_tb:  std_logic;


constant cp: time := 10ns;

begin

uut: fifo generic map (ADDR_WIDTH => ADDR_WIDTH_tb, DATA_WIDTH=>DATA_WIDTH_tb)
          port map(clk=>clk_tb,reset=>reset_tb, rd=>rd_tb,w_data=>w_data_tb,wr=>wr_tb,empty=>empty_tb,
                   full=>full_tb, r_data=>r_data_tb,
                   almost_empty=> almost_empty_tb,almost_full=>almost_full_tb );
process 
begin

clk_tb <= '1';
wait for cp/2;
clk_tb <= '0';
wait for cp/2;

end process; 

reset_tb <= '0' , '1' after 20 ns, '0' after 40 ns; --reset proc  60ns process 

process 
begin 

wr_tb <= '0';
rd_tb <= '0';
wait for 7*cp; 
wr_tb <= '1';
wait for cp; 

w_data_tb <= x"01"; 
wait for cp;
w_data_tb <= x"02"; 
wait for cp;
w_data_tb <= x"03"; 
wait for cp;
w_data_tb <= x"04"; 
wait for cp;
w_data_tb <= x"05"; 
wait for cp;
w_data_tb <= x"06"; 
wait for cp;
w_data_tb <= x"07"; 
wait for cp;
w_data_tb <= x"08"; 
wait for cp;
w_data_tb <= x"0A"; 
wait for cp;
w_data_tb <= x"0B"; 
wait for cp;
w_data_tb <= x"0C"; 
wait for cp;
w_data_tb <= x"0D"; 
wait for cp;
w_data_tb <= x"0E"; 
wait for cp;
w_data_tb <= x"0F"; 
wait for cp;
w_data_tb <= x"10"; 
wait for cp;
w_data_tb <= x"11"; 
wait for cp;
w_data_tb <= x"12"; 
wait for cp;

wr_tb <= '0';
wait for 4*cp;
rd_tb <= '1';
wait for cp;
wait for 16*cp;
rd_tb <= '0';
wait;

end process;
end Behavioral;
