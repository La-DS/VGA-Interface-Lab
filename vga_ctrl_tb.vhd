----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/02/2026 07:02:46 PM
-- Design Name: 
-- Module Name: vga_ctrl_tb - Behavioral
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

entity vga_ctrl_tb is end vga_ctrl_tb;

architecture tb of vga_ctrl_tb is
    component vga_ctrl port(
        clk      : in STD_LOGIC;
        en       : in STD_LOGIC;
        hcount   : out STD_LOGIC_VECTOR (9 downto 0); -- counts from 0 to 799 inclusive 
        vcount   : out STD_LOGIC_VECTOR (9 downto 0); -- counts from 0 to 524 inclusive
        vid      : out STD_LOGIC;
        hs       : out STD_LOGIC;
        vs       : out STD_LOGIC); 
    end component;    
    
    signal clk : std_logic := '0';
    signal en : std_logic := '1';
    signal hc, vc : std_logic_vector( 9 downto 0);
    signal vid,hs,vs : std_logic;
    
    
    begin
    
    ctrl_tb: vga_ctrl port map(
        clk => clk,
        en => en,
        hcount => hc,
        vcount => vc,
        vid => vid,
        hs => hs,
        vs => vs);
    
    process begin
        wait for 4 ns;
        clk <= '1';
        wait for 4 ns;
        clk <= '0';
     end process;
    

end tb;
