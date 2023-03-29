
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;


entity temp_coverter is
    Port ( clk : in STD_LOGIC;
            is_c_or_f : in STD_LOGIC;
           t_in : in STD_LOGIC_VECTOR (7 downto 0);
           t_out : out STD_LOGIC_VECTOR (7 downto 0)
           );
end temp_coverter;

architecture Behavioral of temp_coverter is 
    constant ADDR_WIDTH:integer := 8; --index 
    constant DATA_WIDTH:integer := 8; --bit width
    constant DEPTH:integer      := 200; --bit width


    type rom_type is array (0 to DEPTH-1) of std_logic_vector(DATA_WIDTH downto 0);

    --ROM DEFINITION--

    impure function init_rom(d_type: std_logic) return rom_type is --to read files--
    --declarative region 
        file text_file_C2F: text open READ_MODE is "./c_to_f.txt "; 
        file text_file_F2C: text open READ_MODE is "./f_to_c.txt ";
    
        variable text_line: line; --store the lines
        variable value: std_logic_vector(DATA_WIDTH-1 downto 0); --store the single values that are read per each line 
    
        variable rom_content : rom_type; --store the text line results in an array of rom type 
    
    begin
    --sequential code 
        for i in 0 to DEPTH-1 loop
            if d_type ='0' then
            --reading file
                readline(text_file_C2F,text_line);
            else
                readline(text_file_F2C,text_line);
            end if;
            read(text_line,value);
            --store in array
            rom_content(i) := value;
            end loop;
            
            return rom_content; --return the contents of the array 
    end function;
        
    signal addr_r: std_logic_vector(ADDR_WIDTH-1 downto 0);
    signal ROMC2F: rom_type := init_rom('0');
    signal ROMF2C: rom_type := init_rom('1');

          begin
            process(clk)
            begin
              if (clk'event and clk ='1') then
                 if (is_c_or_f = '0') then
                    t_out <= romC2F(to_integer(unsigned(t_in)));
                else  
                    t_out <= romF2C(to_integer(unsigned(t_in)));
                end if;
              end if; 
            end process;
end Behavioral;
