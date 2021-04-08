library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity vga_ctr_tb is
end vga_ctr_tb;

architecture vga_ctr_tb_arc of vga_ctr_tb is

    component vga_ctrl
    port (clk,en : in std_logic;
          hcount,vcount : out std_logic_vector(9 downto 0);
          vid,hs,vs : out std_logic);
    end component;
    
    signal tb_clk : std_logic := '0';
    signal tb_en : std_logic := '1'; 
    signal tb_hcount : std_logic_vector(9 downto 0) := (others => '0');
    signal tb_vcount : std_logic_vector(9 downto 0) := (others => '0'); 
    signal tb_vid : std_logic;
    signal tb_hs : std_logic;
    signal tb_vs : std_logic;
begin

    clock_gen : process
    begin 
        wait for 4ns;
        tb_clk <= '1';
        wait for 4ns;
        tb_clk <= '0'; 
        
        
    end process clock_gen;

    
    dut: vga_ctrl
    port map(clk => tb_clk,
             en => tb_en,
             hcount => tb_hcount,
             vcount => tb_vcount,
             vid => tb_vid,
             hs => tb_hs,
             vs => tb_vs);
             
end vga_ctr_tb_arc;
