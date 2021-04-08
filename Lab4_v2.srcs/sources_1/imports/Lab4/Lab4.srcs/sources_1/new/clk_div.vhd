library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity clk_div is
  Port ( clk : in std_logic;
         div : out std_logic);
end clk_div;

architecture clk_div_arc of clk_div is
    signal count : std_logic_vector(10 downto 0) := (others => '0');
    
begin
    up_count : process(clk)
    begin
        if(rising_edge(clk)) then
            if(unsigned(count) < 4 ) then  -- 125MHz / 25MHz = 5 so 5 -1 = 4 
                count <= std_logic_vector(unsigned(count) + 1);  
            else
                count <= (others => '0'); 
            end if;
            
            if(unsigned(count) = 0) then --Everytime the counter is 0 it will give an impulsle 
                div <= '1';
            else 
                div <= '0';
            end if;
        end if;
    end process  up_count;
    
    
end clk_div_arc;
