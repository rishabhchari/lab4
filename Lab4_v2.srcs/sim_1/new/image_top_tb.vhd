library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity image_top_tb is
end image_top_tb;

architecture image_top_tb_arc of image_top_tb is

    component image_top 
    Port (clk : in std_logic;
           hdmi_tx_clk_p : out std_logic; 
           hdmi_tx_clk_n : out std_logic;
           hdmi_tx_p : out std_logic_vector(2 downto 0); 
           hdmi_tx_n : out std_logic_vector(2 downto 0);
           hdmi_out_en : out std_logic);
    end component;

    signal tb_clk: std_logic := '0';
    signal tb_clk_p,tb_clk_n : std_logic:='0';
    signal tb_data_p,tb_data_n : std_logic_vector(2 downto 0) := (others => '0');
    signal tb_hdmi_out : std_logic := '0'; 
begin
    
    clock_gen : process
    begin 
       wait for 4ns;
       tb_clk <= '1';
       wait for 4ns;
       tb_clk <= '0';    
    end process clock_gen;
   
   
   dut : image_top 
   port map(clk => tb_clk,
            hdmi_tx_clk_p => tb_clk_p,
            hdmi_tx_clk_n => tb_clk_n,
            hdmi_tx_p => tb_data_p,
            hdmi_tx_n => tb_data_n,
            hdmi_out_en => tb_hdmi_out); 

end image_top_tb_arc;
