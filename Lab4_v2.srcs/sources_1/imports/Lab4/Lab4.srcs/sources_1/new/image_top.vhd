library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity image_top is
 Port (clk : in std_logic;
       hdmi_tx_clk_p : out std_logic; 
       hdmi_tx_clk_n : out std_logic;
       hdmi_tx_p : out std_logic_vector(2 downto 0); 
       hdmi_tx_n : out std_logic_vector(2 downto 0);
       hdmi_out_en : out std_logic);
end image_top;

architecture image_top_arc of image_top is

    component clk_div   
        Port(clk : in std_logic;
             div : out std_logic);
    end component;
    
    component vga_ctrl 
        Port (clk,en : in std_logic;
              hcount,vcount : out std_logic_vector(9 downto 0);
              vid,hs,vs : out std_logic);
    end component;
    
    component pixel_pusher
        Port (clk,en,VS,vid : in std_logic;
           pixel : in std_logic_vector(7 downto 0);
           hcount : in std_logic_vector(9 downto 0);
           red,blue,green : out std_logic_vector(7 downto 0);  
           addr : out std_logic_vector(17 downto 0));
    end component;

    component picture 
        Port (clka : IN STD_LOGIC;
              addra : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
              douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
    end component;
    
    component rgb2dvi_0 
        Port(vid_pData : in std_logic_vector(23 downto 0); 
             vid_pHSync, vid_pVSync,vid_pVDE : in std_logic;
             aRst,PixelClk,SerialClk: in std_logic;
             TMDS_Clk_p : out std_logic; 
             TMDS_Clk_n : out std_logic;
             TMDS_Data_p : out std_logic_vector(2 downto 0); 
             TMDS_Data_n : out std_logic_vector(2 downto 0)); 
    end component; 
    
    signal div_en : std_logic;
    signal hcount_intr : std_logic_vector(9 downto 0); 
    signal vid_intr : std_logic;
    signal VS_intr : std_logic;
    signal HS_intr : std_logic;
    signal pixel_intr : std_logic_vector(7 downto 0);
    signal red8 : std_logic_vector(7 downto 0);
    signal green8 : std_logic_vector(7 downto 0);
    signal blue8 : std_logic_vector(7 downto 0);
    signal data_intr : std_logic_vector(23 downto 0);
    signal addr_intr : std_logic_vector(17 downto 0); 
    
  
begin

    clock_div : clk_div
    port map (clk => clk, 
              div => div_en);
              
    vga : vga_ctrl 
    port map(clk => clk, 
             en => div_en, 
             hcount => hcount_intr,
             vcount => open, 
             vid => vid_intr, 
             hs => HS_intr,
             vs => VS_intr); 
             
             
     pixel : pixel_pusher
     port map(clk => clk, 
              en => div_en, 
              VS => VS_intr,
              vid => vid_intr,
              pixel => pixel_intr,
              hcount => hcount_intr,
              red => red8,
              green => green8,
              blue => blue8,
              addr => addr_intr); 
              
     
     pic : picture
     port map(clka => div_en,  
              addra => addr_intr,
              douta => pixel_intr); 
              
     
   
     data_intr <= red8 & green8 & blue8;
     
     
          
     rgb_dvi : rgb2dvi_0 
     port map(vid_pData => data_intr, 
              vid_pHSync => HS_intr,
              vid_pVSync => VS_intr,
              vid_pVDE => vid_intr,
              aRst => '0', 
              SerialClk => clk, 
              PixelClk => div_en,
              TMDS_Clk_p => hdmi_tx_clk_p,
              TMDS_Clk_n => hdmi_tx_clk_n, 
              TMDS_Data_p => hdmi_tx_p,
              TMDS_Data_n => hdmi_tx_n); 
              
     hdmi_out_en <= '1'; 
    
     
     
     
            
end image_top_arc;
