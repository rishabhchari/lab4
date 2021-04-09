library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;entity 

pixel_pusher_tb is
end pixel_pusher_tb;

architecture Behavioral of pixel_pusher_tb is 
	component pixel_pusher 
  		Port (clk,en,VS,vid : in std_logic;
           pixel : in std_logic_vector(7 downto 0);
           hcount : in std_logic_vector(9 downto 0);
           red,blue : out std_logic_vector(7 downto 0);
           green : out std_logic_vector(7 downto 0); 
           addr : out std_logic_vector(17 downto 0));
	end component; 

	signal clk : std_logic := '0'; 
	signal vs, en, vid : std_logic := '1'; 
	signal pixel : std_logic_vector(7 downto 0) := "11111111"; 
	signal hcount : std_logic_vector(9 downto 0) := (others => '0'); 
	signal tb_red,tb_blue : std_logic_vector(7 downto 0);
	signal tb_green : std_logic_vector(7 downto 0);
	signal addr : std_logic_vector(17 downto 0);
	
begin 
	   process
	   begin
		  en <= '1'; 
		  wait for 4 ns; 
		  clk <= '1'; 
		  wait for 4 ns; 
		  clk <= '0';
		  end process;
		  
	process 
	begin
		wait for 4 ns;
		vid <= '1';
		hcount <= std_logic_vector(unsigned(hcount)+1);
		wait for 40 ns;
		vs <= '0';
		wait for 40 ns;
		vs <= '1'; 
		vid <= '0';
		wait for 40 ns;
		pixel <= "10101010";
		vid <= '1';
		wait for 40 ns;
		hcount <= std_logic_vector(unsigned(hcount)+480);
		end process;
	
	tb : pixel_pusher
	port map(clk => clk, 
		en => en, 
		VS => vs, 
		vid => vid, 
		pixel => pixel, 
		hcount => hcount, 
		red => tb_red,
		blue => tb_blue, 
		green => tb_green, 
		addr => addr);
end Behavioral;
