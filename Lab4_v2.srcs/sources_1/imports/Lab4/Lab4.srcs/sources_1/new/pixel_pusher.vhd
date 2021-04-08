library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pixel_pusher is
 Port (clk,en,VS,vid : in std_logic;
       pixel : in std_logic_vector(7 downto 0);
       hcount : in std_logic_vector(9 downto 0);
       red,blue,green : out std_logic_vector(7 downto 0); 
       addr : out std_logic_vector(17 downto 0));
end pixel_pusher;

architecture pixel_pusher_arc of pixel_pusher is

    signal addr_count : std_logic_vector(17 downto 0) := (others => '0');
    signal red5 : std_logic_vector(4 downto 0);
    signal green6 : std_logic_vector(5 downto 0); 
    signal blue5 : std_logic_vector(4 downto 0); 
begin
     addr <= addr_count; 
     
     count: process(clk)
     begin 
       if(rising_edge(clk)) then
           if( en = '1') then  
              if(VS = '1') then 
                if((vid = '1') and (unsigned(hcount) < 480)) then
                    addr_count <= std_logic_vector(unsigned(addr_count) + 1); 
                end if; 
              else 
                addr_count <= (others => '0'); 
              end if;        
               
              if( (vid = '1') and (unsigned(hcount) < 480) ) then      
                red5 <= pixel(7 downto 5) & "00";
                green6 <= pixel(4 downto 2) & "000";
                blue5 <= pixel(1 downto 0) & "000"; 

              else 
               red5 <= (others => '0');
               green6 <= (others => '0');
               blue5 <= (others => '0');       
              end if;
              
              red <= std_logic_vector(To_unsigned(((To_integer(unsigned(red5))*255)/7),8));
              green <= std_logic_vector(To_unsigned(((To_integer(unsigned(green6))*255)/7),8));
              blue <= std_logic_vector(To_unsigned(((To_integer(unsigned(blue5))*255)/3),8));
                
                
           end if; 
       end if;
   end process;  
          
end pixel_pusher_arc;