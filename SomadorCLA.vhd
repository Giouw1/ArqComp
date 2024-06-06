LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY SomadorCLA IS
  PORT (
  ------------------------------------------------------------------------------
  
    A_i: IN  std_logic_vector(31 DOWNTO 0);
    B_i: IN  std_logic_vector(31 DOWNTO 0);
    vecSize_i: IN std_logic_vector (1 DOWNTO 0);
    mode_i : IN std_logic;
    
  ------------------------------------------------------------------------------
  
    S_o        : OUT std_logic_vector (31 DOWNTO 0)
    
    );
END SomadorCLA;

-- Process não deve ser necessário em nenhum momento, visto que o propósito é ser fundamentalmente em paralelo
-- Soma é  S = (A XOR B) XOR CIN (Utilizaremos B = (B XOR mode_i) para tratar o complemento à 1 diretamente
-- Carry é (A and B) = Generate or (A XOR B and Cin) = Propagate

ARCHITECTURE TypeArchitecture OF SomadorCLA IS

  signal P : std_logic_vector(31 DOWNTO 0);
  --Propagar carry: só se o cin for 1 (A xor B)
  signal G : std_logic_vector(31 DOWNTO 0);
  -- Gera carry A AND B
  signal C : std_logic_vector(31 DOWNTO 0);
  -- vai ser (G) or (P and Cin)
  -- Completa o complemento à 2
  signal Bsub : std_logic_vector(31 DOWNTO 0);

BEGIN
  -- Posso resolver todo complemento à 2, subtração, fazendo B_i(N), sempre ser (B_i(N) XOR mode_i), vai ser recorrente, e colocando o cin segundo mode_i
  -- Como a quantidade de bits de Bsub, G, E P são iguais, aproveitei para fazer todos de uma vez. 
  CARRIES_E_SUB: FOR N IN 31 DOWNTO 0 generate
    G(N)    <= (A_i(N) AND (B_i(N) XOR mode_i));
    P(N)    <= (A_i(N) XOR (B_i(N) XOR mode_i));
    Bsub(N) <= (B_i(N) XOR mode_i);
  END GENERATE CARRIES_E_SUB;
  
  C(0) <= mode_i;
  C(1) <= (G(0) OR (P(0) AND C(0)));
  C(2) <= (G(1) OR (P(1) AND C(1)));
  C(3) <= (G(2) OR (P(2) AND C(2)));
  
  C(4) <= (G(3) OR (P(3) AND C(3))) WHEN (NOT(vecSize_i = "00")) ELSE '0';
  C(5) <= (G(4) OR (P(4) AND C(4)));
  C(6) <= (G(5) OR (P(5) AND C(5)));
  C(7) <= (G(6) OR (P(6) AND C(6)));
  
  C(8) <= (G(7) OR (P(7) AND C(7))) WHEN ((vecSize_i(1)) = '1') ELSE '0';
  C(9) <= (G(8) OR (P(8) AND C(8)));
  C(10) <= (G(9) OR (P(9) AND C(9)));
  C(11) <= (G(10) OR (P(10) AND C(10)));
  C(12) <= (G(11) OR (P(11) AND C(11)));
  C(13) <= (G(12) OR (P(12) AND C(12)));
  C(14) <= (G(13) OR (P(13) AND C(13)));
  C(15) <= (G(14) OR (P(14) AND C(14)));
  
  C(16) <= (G(15) OR (P(15) AND C(15))) WHEN (vecSize_i = "11") ELSE '0';
  C(17) <= (G(16) OR (P(16) AND C(16)));
  C(18) <= (G(17) OR (P(17) AND C(17)));
  C(19) <= (G(18) OR (P(18) AND C(18)));
  C(20) <= (G(19) OR (P(19) AND C(19)));
  C(21) <= (G(20) OR (P(20) AND C(20)));
  C(22) <= (G(21) OR (P(21) AND C(21)));
  C(23) <= (G(22) OR (P(22) AND C(22)));
  C(24) <= (G(23) OR (P(23) AND C(23)));
  C(25) <= (G(24) OR (P(24) AND C(24)));
  C(26) <= (G(25) OR (P(25) AND C(25)));
  C(27) <= (G(26) OR (P(26) AND C(26)));
  C(28) <= (G(27) OR (P(27) AND C(27)));
  C(29) <= (G(28) OR (P(28) AND C(28)));
  C(30) <= (G(29) OR (P(29) AND C(29)));
  C(31) <= (G(30) OR (P(30) AND C(30)));

  -- Gerar os operandos no tamanho certo
  -- Verificar a possibilidade de complemento
  SOMA: FOR N IN 31 DOWNTO 0 GENERATE
    S_o(N) <= (A_i(N) XOR (B_i(N) XOR mode_i) XOR C(N));
  END GENERATE SOMA;

END TypeArchitecture;
