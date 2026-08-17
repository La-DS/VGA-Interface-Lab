----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/02/2026 05:54:20 PM
-- Design Name: 
-- Module Name: vga_ctrl - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity vga_ctrl is
    Port ( clk      : in STD_LOGIC;
           en       : in STD_LOGIC;
           hcount   : out STD_LOGIC_VECTOR (9 downto 0); -- counts from 0 to 799 inclusive 
           vcount   : out STD_LOGIC_VECTOR (9 downto 0); -- counts from 0 to 524 inclusive
           vid      : out STD_LOGIC;
           hs       : out STD_LOGIC;
           vs       : out STD_LOGIC);
end vga_ctrl;

architecture Behavioral of vga_ctrl is
    signal sig_hc  : std_logic_vector(9 downto 0) := (others => '0');
    signal sig_vc  : std_logic_vector(9 downto 0) := (others => '0');

    
begin
    hcount <= sig_hc;
    vcount <= sig_vc;
     
    process(clk, en) begin
    
        if rising_edge(clk) and en = '1' then
            if unsigned(sig_hc) < 800 then
                sig_hc <= std_logic_vector( unsigned(sig_hc)+1);
            else
                sig_hc <= (others => '0');  
                if unsigned(sig_vc) >= 524 then
                    sig_vc <= (others => '0');
                else
                    sig_vc <= std_logic_vector( unsigned(sig_vc) + 1 );                        
                end if;       
            end if;    
        end if;
    end process;
    
    video_enable: process(sig_hc, sig_vc) begin -- vid control signal
        if unsigned(sig_hc) >= 0 and unsigned(sig_hc) <= 639 and unsigned(sig_vc) >= 0 and unsigned(sig_vc) <= 479 then 
            vid <= '1';
        else 
            vid <= '0';        
        end if;
    end process video_enable;
    
    
    hs_ctrl: process(sig_hc) begin
        if unsigned(sig_hc) >= 656 and unsigned(sig_hc) <= 751 then
            hs <= '0';
        else
            hs <= '1';     
        end if;  
    
    end process hs_ctrl;
    
    
    vs_ctrl: process(sig_vc) begin
        if unsigned(sig_vc) = 490 or unsigned(sig_vc) = 491 then
            vs <= '0';
        else
            vs <= '1';     
        end if;  
    
    end process vs_ctrl;
    
end Behavioral;
