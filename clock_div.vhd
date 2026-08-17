library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

entity clock_div is
    Port ( clk : in STD_LOGIC;
           div : out STD_LOGIC);
end clock_div;
-- turns 125 MHz to 25 MHz
-- 125/25 is 5
-- 3 bit wide counter signal because 2^3 = 8, smallest value that can fit 5. 2^2 = 4, which is too small.
architecture Behavioral of clock_div is
signal counter : std_logic_vector(2 downto 0) := (others => '0'); -- 3 bit wide signal

begin

divider: process(clk)
    begin
    if (rising_edge(clk)) then
        if (unsigned(counter) < 5) then
            counter <= std_logic_vector(unsigned(counter) + 1);
            div <= '0';    

        else
            counter <= (others => '0');
            div <= '1';

        end if;   
        
 
    end if; 
    
end process divider;
end Behavioral;
