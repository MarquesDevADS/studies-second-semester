-- 1. Criação da tabela tb_cliente
CREATE TABLE tb_cliente (
						id_cliente integer,
						nm_cliente varchar(50) not null,
						nu_idade integer not null,
						cd_estado char(2) not null
						);

-- 2. Criação da tabela tb_estado
CREATE TABLE tb_estado (
						cd_estado char(2),
						nm_estado varchar(30) not null
						)


-- 3. Regras (constraint)
ALTER TABLE tb_estado ADD CONSTRAINT pk_cd_estado PRIMARY KEY (cd_estado);
ALTER TABLE tb_estado ADD CONSTRAINT ak_nm_estado UNIQUE (nm_estado);

ALTER TABLE tb_cliente ADD CONSTRAINT pk_id_cliente PRIMARY KEY (id_cliente);
ALTER TABLE tb_cliente ADD CONSTRAINT fk_cd_estado FOREIGN KEY (cd_estado) REFERENCES tb_estado;


-- 4. Inserção de dados
INSERT INTO tb_cliente VALUES (1, 'LUIS', 55,'RS'),
							  (2, 'PEDRO', 16, 'SC'),
							  (3, 'DAVID', 19, 'RJ'),
							  (4, 'MARTA', 32, 'RS'),
							  (5, 'CARLA', 40, 'RS'),
							  (6, 'JOSE', 28, 'SC'),
							  (8, 'Maria', 30, 'RS');
							  
INSERT INTO tb_estado VALUES ('RS', 'RIO GRANDE DO SUL'),
							 ('SC', 'SANTA CATARINA'),
							 ('RJ', 'RIO DE JANEIRO'),
							 ('SP', 'SAO PAULO');
							  
-- 5. Visualização simples das tabelas
SELECT * FROM tb_cliente;

SELECT * FROM tb_estado;

-- 6. Visualização subquery das tabelas
SELECT DISTINCT cd_estado FROM tb_cliente
SELECT cd_estado , COUNT(*) FROM tb_cliente GROUP BY cd_estado

SELECT nm_estado, COUNT(*) FROM tb_cliente, tb_estado 
         WHERE tb_cliente.cd_estado = tb_estado.cd_estado
		 GROUP BY nm_estado
		 
SELECT nm_estado, COUNT(*) FROM tb_cliente A, tb_estado  B
         WHERE A.cd_estado = B.cd_estado
		 GROUP BY nm_estado		 
	
SELECT nm_estado, COUNT(*) AS TOTAL FROM tb_cliente A, tb_estado  B
         WHERE A.cd_estado = B.cd_estado
		 GROUP BY nm_estado	ORDER BY nm_estado

-- 7. Visualização relacionada a matemática 
SELECT MAX (nu_idade) FROM tb_cliente;

SELECT SUM (nu_idade) FROM tb_cliente;

SELECT AVG (nu_idade) FROM tb_cliente;

-- 8. Listagem dos estados e a quantidade de clientes
SELECT cd_estado, COUNT(*) FROM tb_cliente
	GROUP BY cd_estado
	
-- 9. Listagem dos estados com + de 1 cliente
SELECT cd_estado, COUNT(*) FROM tb_cliente
	GROUP BY cd_estado
	HAVING COUNT(*) > 1
	
-- 10. Busca pelo nome do cliente com a maior idade
SELECT MAX (nu_idade) FROM tb_cliente

SELECT nm_cliente FROM tb_cliente 
	WHERE nu_idade = (SELECT MAX (nu_idade) FROM tb_cliente)

-- 11. Busca pelo nome do cliente com a menor idade
SELECT MIN (nu_idade) FROM tb_cliente

SELECT nm_cliente FROM tb_cliente 
	WHERE nu_idade = (SELECT MIN (nu_idade) FROM tb_cliente)

-- INFORMAÇÃO SE TIRA DOS DADOS

-- 12. Busca pelos nomes que comecam com L
SELECT nm_cliente FROM tb_cliente
	WHERE nm_cliente LIKE 'L%'

-- 13. Busca pelos nomes que terminam com D
SELECT nm_cliente FROM tb_cliente
	WHERE nm_cliente LIKE '%D'
	
-- 14. Busca pelos nomes com A em qualquer local
SELECT nm_cliente FROM tb_cliente
	WHERE nm_cliente LIKE '%A%'
	
-- 15. Busca pelos nomes com A em qualquer local (sem case sensitive)
SELECT nm_cliente FROM tb_cliente
	WHERE nm_cliente ILIKE '%A%'
	
-- 16. Teste do _ (underline)
SELECT nm_cliente FROM tb_cliente 
	WHERE nm_cliente ILIKE '_AR%'

-- 17. Me liste os nomes que possuem letra minuscula
SELECT nm_cliente FROM tb_cliente 
	WHERE nm_cliente != UPPER(nm_cliente)

-- 18. Liste o estado que mais tem cliente
SELECT MAX (TOTAL) FROM
	(SELECT cd_estado, COUNT (*) AS TOTAL FROM tb_cliente GROUP BY cd_estado) X -- Dando apelido pra subquery

-- 19. Aprendendo a utilizar view
CREATE VIEW vw_total_estado AS
	SELECT cd_estado, COUNT(*) AS TOTAL FROM tb_cliente GROUP BY cd_estado

SELECT * FROM vw_total_estado

SELECT cd_estado FROM
	vw_total_estado
	WHERE TOTAL = 
	(SELECT MAX(TOTAL) FROM
	vw_total_estado)
	
-- 19. Criando uma view diferente
CREATE VIEW vw_cliente AS 
	SELECT nm_cliente, nu_idade FROM tb_cliente

SELECT * FROM vw_cliente