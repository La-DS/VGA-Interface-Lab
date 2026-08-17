----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/09/2026 06:23:03 PM
-- Design Name: 
-- Module Name: image_top - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity image_top is
    Port ( clk    : in STD_LOGIC;
           vga_hs : out STD_LOGIC;
           vga_vs : out STD_LOGIC;
           vga_r  : out STD_LOGIC_VECTOR (4 downto 0);
           vga_g  : out STD_LOGIC_VECTOR (5 downto 0);
           vga_b  : out STD_LOGIC_VECTOR (4 downto 0));
end image_top;

architecture Behavioral of image_top is
    component clock_div port(
        clk : in STD_LOGIC;
        div : out STD_LOGIC);
    end component;
    signal div_to_en : std_logic;
    
    component picture port(
        clka  : IN STD_LOGIC;
        addra : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
        douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
    end component;
    signal pic_to_pusher : std_logic_vector(7 downto 0);
    
    signal pusher_to_pic : std_logic_vector(17 downto 0);
    --留守番電話
    
    component vga_ctrl port(
        clk      : in STD_LOGIC;
        en       : in STD_LOGIC;
        hcount   : out STD_LOGIC_VECTOR (9 downto 0); -- counts from 0 to 799 inclusive 
        vcount   : out STD_LOGIC_VECTOR (9 downto 0); -- counts from 0 to 524 inclusive
        vid      : out STD_LOGIC;
        hs       : out STD_LOGIC;
        vs       : out STD_LOGIC);
    end component;
    
    signal vs_to_pusher, hs_to_pusher : std_logic;
    signal hc_to_pix, vc_to_pix       : std_logic_vector(9 downto 0);
    signal vid_to_pix : std_logic;
    
    
    component pixel_pusher port(
            clk    : in STD_LOGIC;
            en     : in STD_LOGIC;
            vs     : in STD_LOGIC;
            pixel  : in STD_LOGIC_VECTOR (7 downto 0);
            hcount : in STD_LOGIC_VECTOR (9 downto 0);
            vid    : in STD_LOGIC;
            R      : out STD_LOGIC_VECTOR (4 downto 0);
            B      : out STD_LOGIC_VECTOR (4 downto 0);
            G      : out STD_LOGIC_VECTOR (5 downto 0);
            addr   : out STD_LOGIC_VECTOR (17 downto 0));
    end component;
begin
    vga_vs <= vs_to_pusher;
    vga_hs <= hs_to_pusher;
    divider: clock_div port map(
        clk => clk,
        div => div_to_en);
        
    pic: picture port map(
        clka => div_to_en,
        addra => pusher_to_pic,
        douta => pic_to_pusher);
        
    ctrl: vga_ctrl port map(
        clk => clk,
        en => div_to_en,
        hcount => hc_to_pix,
        vcount => vc_to_pix,
        vid => vid_to_pix,
        hs => hs_to_pusher,
        vs => vs_to_pusher);
        
    pix_pusher: pixel_pusher port map(
        clk => clk,
        en => div_to_en,
        vs => vs_to_pusher,
        pixel => pic_to_pusher,
        hcount => hc_to_pix,
        vid => vid_to_pix,
        R => vga_r,
        G => vga_g,
        B => vga_b,
        addr => pusher_to_pic);

end Behavioral;
