library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity vga_ctrl is
  Port (clk,en : in std_logic;
        hcount,vcount : out std_logic_vector(9 downto 0);
        vid,hs,vs : out std_logic);
end vga_ctrl;

architecture vga_ctrl_arc of vga_ctrl is
        signal horiz_count : std_logic_vector(9 downto 0) := (others => '0');
        signal vert_count : std_logic_vector(9 downto 0) := (others => '0');
begin
    
    
    process(clk)
    begin 
        if(rising_edge(clk)) then 
            if(en = '1') then
                    if( (unsigned(horiz_count) < 799) ) then 
                        horiz_count <= std_logic_vector(unsigned(horiz_count) + 1);
                        
                    elsif( (unsigned(horiz_count) = 799) ) then  
                        horiz_count <= (others => '0');
                        vert_count <= std_logic_vector(unsigned(vert_count) + 1); 
                        
                        if( (unsigned(vert_count) = 524) ) then 
                            vert_count <= (others => '0');
                        end if;   
                    
                    end if; 
                          
                    if( (unsigned(horiz_count) < 640) and (unsigned(vert_count) < 479) ) then 
                        vid <= '1'; 
                    else 
                        vid <= '0';
                    end if;
                        
                    if( (unsigned(horiz_count) > 655) and (unsigned(horiz_count) < 752) ) then 
                        hs <= '0';
                    else
                        hs <= '1';
                    end if; 
                        
                    if( (unsigned(vert_count) >= 490) and (unsigned(vert_count) <= 491) ) then 
                        vs <= '0';
                    else 
                        vs <= '1';
                    end if;
                   hcount <= horiz_count; 
                   vcount <= vert_count; 
            end if; 
        end if; 
    end process;
    
    

    
end vga_ctrl_arc;
