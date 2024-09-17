--Consulta que retorna a quantidade de jogadores por time
SELECT t.name AS time_name, COUNT(c.Jogador_cpf) AS quantidade_jogadores
FROM Time t
JOIN Contrato c ON t.id = c.Time_id
GROUP BY t.name;

-- Consulta que retorna a quantidade de gols dos jogadores do time 1
SELECT j.name AS jogador_name, COUNT(jg.ngols) AS quantidade_gols
FROM Jogador j
JOIN Contrato c ON j.cpf = c.Jogador_cpf
JOIN Jogou jg ON c.Time_id = jg.Time_id
WHERE c.Time_id = 1
GROUP BY j.name;

-- A quantidade de gols geito por cada time em um determinado periodo de tempo
SELECT t.id AS Time_id, t.name AS Time_name, SUM(j.ngols) AS Total_gols
FROM Jogou j JOIN Time t ON j.Time_id = t.id
WHERE j.Jogo_data BETWEEN '2024-09-01' AND '2024-09-30' 
GROUP BY t.id, t.name
ORDER BY Total_gols DESC;
