LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY SomadorVetorial IS
  PORT (
  ------------------------------------------------------------------------------
  
    A_i: IN  std_logic_vector(31 DOWNTO 0);
    B_i: IN  std_logic_vector(31 DOWNTO 0);
    vecSize_i: IN std_logic_vector (1 DOWNTO 0);
    mode_i : IN std_logic;
    
  ------------------------------------------------------------------------------
  
    S_o        : OUT std_logic_vector (31 DOWNTO 0)
    
    );
END SomadorVetorial;

-- Soma é  S = (A XOR B) XOR CIN (Utilizaremos B = (B XOR mode_i) para tratar o complemento à 1 diretamente
-- Carry é (A and B) = Generate or (A XOR B and Cin) = Propagate

ARCHITECTURE TypeArchitecture OF SomadorVetorial IS

  signal P : std_logic_vector(31 DOWNTO 0);
  signal G : std_logic_vector(31 DOWNTO 0);
  signal C : std_logic_vector(31 DOWNTO 0);

BEGIN
 
  CARRIES_E_SUB: FOR N IN 31 DOWNTO 0 generate
    G(N)    <= (A_i(N) AND (B_i(N) XOR mode_i));
    P(N)    <= (A_i(N) XOR (B_i(N) XOR mode_i));
    Bsub(N) <= (B_i(N) XOR mode_i);
  END GENERATE CARRIES_E_SUB;
  
  C(0) <= mode_i;
  C(1) <= (G(0) OR (P(0) AND C(0)));
  C(2) <= (G(1) OR (P(1) AND C(1)));
  C(3) <= (G(2) OR (P(2) AND C(2)));
  (G(3) OR (P(3) AND C(3)))
  C(4) <= '0' WHEN (vecSize_i = '00' and NOT(mode_i)) ELSE
			 '1' WHEN (vecSize_i = '00' and (mode_i)) ELSE
			 (G(3) OR (P(3) AND C(3)));
  C(5) <= (G(4) OR (P(4) AND C(4)));
  C(6) <= (G(5) OR (P(5) AND C(5)));
  C(7) <= (G(6) OR (P(6) AND C(6)));
  --É recorrente o carry receber 1 quando mode_1 for 1, pois, mesmo que sejam blocos diferentes, o CIN deve ser 1 por se tratar de complemento à 2
  C(8) <='0' WHEN (vecSize_i = '00' and NOT(mode_i)) ELSE
		   '1' WHEN (vecSize_i = '00' and (mode_i)) ELSE
			'0' WHEN (vecSize_i = '01' and NOT(mode_i)) ELSE
			'1' WHEN (vecSize_i = '01' and (mode_i)) ELSE
			
         (G(7) OR (P(7) AND C(7))) ;
  C(9) <= (G(8) OR (P(8) AND C(8)));
  C(10) <= (G(9) OR (P(9) AND C(9)));
  C(11) <= (G(10) OR (P(10) AND C(10)));
  C(12) <='0' WHEN (vecSize_i = '00' and NOT(mode_i)) ELSE
			 '1' WHEN (vecSize_i = '00' and (mode_i)) ELSE
			 (G(11) OR (P(11) AND C(11)));
  C(13) <= (G(12) OR (P(12) AND C(12)));
  C(14) <= (G(13) OR (P(13) AND C(13)));
  C(15) <= (G(14) OR (P(14) AND C(14)));
  
  C(16) <='0' WHEN (vecSize_i = '00' and NOT(mode_i)) ELSE
			 '1' WHEN (vecSize_i = '00' and (mode_i)) ELSE
			 '0' WHEN (vecSize_i = '01' and NOT(mode_i)) ELSE
			 '1' WHEN (vecSize_i = '01' and (mode_i)) ELSE
			 '0' WHEN (vecSize_i = '10' and NOT(mode_i)) ELSE
			 '1' WHEN (vecSize_i = '10' and (mode_i)) ELSE
			 (G(15) OR (P(15) AND C(15))) ;
  
  C(17) <= (G(16) OR (P(16) AND C(16)));
  C(18) <= (G(17) OR (P(17) AND C(17)));
  C(19) <= (G(18) OR (P(18) AND C(18)));
  
  C(20) <='0' WHEN (vecSize_i = '00' and NOT(mode_i)) ELSE
			 '1' WHEN (vecSize_i = '00' and (mode_i)) ELSE
			 (G(19) OR (P(19) AND C(19)));
			 
  C(21) <= (G(20) OR (P(20) AND C(20)));
  C(22) <= (G(21) OR (P(21) AND C(21)));
  C(23) <= (G(22) OR (P(22) AND C(22)));
  
  C(24) <='0' WHEN (vecSize_i = '00' and NOT(mode_i)) ELSE
			 '1' WHEN (vecSize_i = '00' and (mode_i)) ELSE
			 '0' WHEN (vecSize_i = '01' and NOT(mode_i)) ELSE
			 '1' WHEN (vecSize_i = '01' and (mode_i)) ELSE
			 (G(23) OR (P(23) AND C(23)));
			 
  C(25) <= (G(24) OR (P(24) AND C(24)));
  C(26) <= (G(25) OR (P(25) AND C(25)));
  C(27) <= (G(26) OR (P(26) AND C(26)));
  
  C(28) <='0' WHEN (vecSize_i = '00' and NOT(mode_i)) ELSE
			 '1' WHEN (vecSize_i = '00' and (mode_i)) ELSE
			 (G(27) OR (P(27) AND C(27)));
			 
  C(29) <= (G(28) OR (P(28) AND C(28)));
  C(30) <= (G(29) OR (P(29) AND C(29)));
  C(31) <= (G(30) OR (P(30) AND C(30)));

  -- Gerar os operandos no tamanho certo
  -- Verificar a possibilidade de complemento
  SOMA: FOR N IN 31 DOWNTO 0 GENERATE
    S_o(N) <= (A_i(N) XOR (B_i(N) XOR mode_i) XOR C(N));
  END GENERATE SOMA;

END TypeArchitecture;
