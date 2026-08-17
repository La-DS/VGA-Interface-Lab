----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/10/2026 10:42:03 PM
-- Design Name: 
-- Module Name: image_tb - Behavioral
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

entity image_tb is end image_tb;

architecture tb of image_tb is
    component image_top port(
        clk    : in STD_LOGIC;
        vga_hs : out STD_LOGIC;
        vga_vs : out STD_LOGIC;
        vga_r  : out STD_LOGIC_VECTOR (4 downto 0);
        vga_g  : out STD_LOGIC_VECTOR (5 downto 0);
        vga_b  : out STD_LOGIC_VECTOR (4 downto 0));
    end component;
    
    signal clk       : std_logic := '0';
    signal vga_hs_tb : STD_LOGIC;
    signal vga_vs_tb : STD_LOGIC;
    signal vga_r_tb  : STD_LOGIC_VECTOR (4 downto 0);
    signal vga_g_tb  : STD_LOGIC_VECTOR (5 downto 0);
    signal vga_b_tb  : STD_LOGIC_VECTOR (4 downto 0);
    
begin
    top: image_top port map(
    clk => clk,
    vga_hs =>vga_hs_tb,
    vga_vs =>vga_vs_tb,
    vga_r => vga_r_tb,
    vga_g => vga_g_tb,
    vga_b => vga_b_tb);
    process begin
        wait for 4 ns;
        clk <= '1';
        wait for 4 ns;
        clk <= '0';
     end process;

end tb;
