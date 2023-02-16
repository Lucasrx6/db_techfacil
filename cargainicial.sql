CREATE DATABASE IF NOT EXISTS db_techfacil
CHARSET utf8mb4
COLLATE utf8mb4_general_ci;

use db_techfacil;

CREATE TABLE tb_placaMae(
	id_placaMae INT AUTO_INCREMENT,
    nome_placaMae VARCHAR(30) NOT NULL,
    valor_placaMae FLOAT NOT NULL,
    especificacao_placaMae LONGTEXT,
PRIMARY KEY (id_placaMae)
);

CREATE TABLE tb_processador(
	id_processador INT AUTO_INCREMENT,
    nome_processador VARCHAR(30) NOT NULL,
    valor_processador FLOAT NOT NULL,
    especificacao_processador LONGTEXT,
PRIMARY KEY (id_processador)
);

CREATE TABLE tb_cooler(
	id_cooler INT AUTO_INCREMENT,
    nome_cooler VARCHAR(30) NOT NULL,
    valor_cooler FLOAT NOT NULL,
    especificacao_cooler LONGTEXT,
PRIMARY KEY (id_cooler)
);

CREATE TABLE tb_memoria(
	id_memoria INT AUTO_INCREMENT,
    nome_memoria VARCHAR(30) NOT NULL,
    valor_memoria FLOAT NOT NULL,
    especificacao_memoria LONGTEXT,
PRIMARY KEY (id_memoria)
);

CREATE TABLE tb_armazenamento(
	id_armazenamento INT AUTO_INCREMENT,
    nome_armazenamento VARCHAR(30) NOT NULL,
    valor_armazenamento FLOAT NOT NULL,
    especificacao_armazenamento LONGTEXT,
PRIMARY KEY (id_armazenamento)
);

CREATE TABLE tb_fonteAlimentacao(
	id_fonteAlimentacao INT AUTO_INCREMENT,
    nome_fonteAlimentacao VARCHAR(30) NOT NULL,
    valor_fonteAlimentacao FLOAT NOT NULL,
    especificacao_fonteAlimentacao LONGTEXT,
PRIMARY KEY (id_fonteAlimentacao)
);

CREATE TABLE tb_teclado(
	id_teclado INT AUTO_INCREMENT,
    nome_teclado VARCHAR(30) NOT NULL,
    valor_teclado FLOAT NOT NULL,
    especificacao_teclado LONGTEXT,
PRIMARY KEY (id_teclado)
);

CREATE TABLE tb_mouse(
	id_mouse INT AUTO_INCREMENT,
    nome_mouse VARCHAR(30) NOT NULL,
    valor_mouse FLOAT NOT NULL,
    especificacao_mouse LONGTEXT NOT NULL,
PRIMARY KEY (id_mouse)
);

CREATE TABLE tb_monitor(
	id_monitor INT AUTO_INCREMENT,
    nome_monitor VARCHAR(30) NOT NULL,
    valor_monitor FLOAT NOT NULL,
    especificacao_monitor LONGTEXT,
PRIMARY KEY (id_monitor)
);

CREATE TABLE tb_maquina (
id_maquina INT AUTO_INCREMENT,
    nome_maquina VARCHAR (30) NOT NULL,
    id_placaMae INT NOT NULL,
    id_processador INT NOT NULL,
    id_armazenamento INT NOT NULL,
    id_memoria INT NOT NULL,
    id_cooler INT NOT NULL,
    id_fonteAlimentacao INT NOT NULL,
    id_monitor INT,
    id_teclado INT,
    id_mouse INT,
PRIMARY KEY (id_maquina),
CONSTRAINT FK_id_placaMae FOREIGN KEY (id_placaMae) REFERENCES TB_placaMae (id_placaMae),
CONSTRAINT FK_id_processador FOREIGN KEY (id_processador) REFERENCES tb_processador (id_processador),
CONSTRAINT FK_id_armazenamento FOREIGN KEY (id_armazenamento) REFERENCES tb_armazenamento (id_armazenamento),
CONSTRAINT FK_id_memoria FOREIGN KEY (id_memoria) REFERENCES tb_memoria (id_memoria),
CONSTRAINT FK_id_cooler FOREIGN KEY (id_cooler) REFERENCES tb_cooler (id_cooler),
CONSTRAINT FK_id_fonteAlimentacao FOREIGN KEY (id_fonteAlimentacao) REFERENCES tb_fonteAlimentacao (id_fonteAlimentacao),
CONSTRAINT FK_id_monitor FOREIGN KEY (id_monitor) REFERENCES tb_monitor (id_monitor),
CONSTRAINT FK_id_teclado FOREIGN KEY (id_teclado) REFERENCES tb_teclado (id_teclado),
CONSTRAINT FK_id_mouse FOREIGN KEY (id_mouse) REFERENCES tb_mouse (id_mouse)
);
/*-------------------------------FUNÇÃO DE REMOVE ACENTO---------------------------------*/
DELIMITER $$
CREATE FUNCTION fn_removeAcento(Texto VARCHAR(50))
RETURNS VARCHAR (50)
BEGIN
	SET Texto = REPLACE(Texto,'á','a'),
        Texto = REPLACE(Texto,'ã','a'),
		Texto = REPLACE(Texto,'à','a'),
        Texto = REPLACE(Texto,'é','e'),
        Texto = REPLACE(Texto,'í','i'),
        Texto = REPLACE(Texto,'ó','o'),
        Texto = REPLACE(Texto,'ú','u'),
        Texto = REPLACE(Texto,'Á','A'),
        Texto = REPLACE(Texto,'Ã','A'),
        Texto = REPLACE(Texto,'À','A'),
        Texto = REPLACE(Texto,'É','E'),
        Texto = REPLACE(Texto,'Í','I'),
        Texto = REPLACE(Texto,'Ó','O'),
        Texto = REPLACE(Texto,'Ú','U'),
        Texto = REPLACE(Texto,'Ç','C'),
        Texto = REPLACE(Texto,'ç','c'),
        Texto = UPPER(Texto);
	RETURN Texto;
END;
$$
DELIMITER ;

/*-------------------------------INSERT DE ARMAZENAMENTO---------------------------------*/
DELIMITER $$
CREATE PROCEDURE sp_insert_armazenamento (
    IN nome_armazenamento VARCHAR(30),
    IN valor_armazenamento FLOAT,
    IN especificacao_armazenamento LONGTEXT
)
BEGIN
    IF nome_armazenamento IS NULL OR nome_armazenamento = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nome do armazenamento não pode estar vazio.';
    END IF;

    IF valor_armazenamento IS NULL OR valor_armazenamento < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Valor do armazenamento deve ser maior ou igual a zero.';
    END IF;

    INSERT INTO tb_armazenamento (nome_armazenamento, valor_armazenamento, especificacao_armazenamento) 
    VALUES (nome_armazenamento, valor_armazenamento, especificacao_armazenamento);
END $$

DELIMITER ;

/*-------------------------------INSERT DE COOLER---------------------------------*/
DELIMITER $$
CREATE PROCEDURE sp_insert_cooler (
    IN nome_cooler VARCHAR(30),
    IN valor_cooler FLOAT,
    IN especificacao_cooler LONGTEXT
)
BEGIN
    IF nome_cooler IS NULL OR nome_cooler = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nome do cooler não pode estar vazio.';
    END IF;

    IF valor_cooler IS NULL OR valor_cooler < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Valor do cooler deve ser maior ou igual a zero.';
    END IF;

    INSERT INTO tb_cooler (nome_cooler, valor_cooler, especificacao_cooler) 
    VALUES (nome_cooler, valor_cooler, especificacao_cooler);
END $$

DELIMITER ;

/*-------------------------------INSERT DE FONTE DE ALIMENTAÇÃO---------------------------------*/
DELIMITER $$
CREATE PROCEDURE sp_insert_fonteAlimentacao (
    IN nome_fonteAlimentacao VARCHAR(30),
    IN valor_fonteAlimentacao FLOAT,
    IN especificacao_fonteAlimentacao LONGTEXT
)
BEGIN
    IF nome_fonteAlimentacao IS NULL OR nome_fonteAlimentacao = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nome da fonte de alimentação não pode estar vazio.';
    END IF;

    IF valor_fonteAlimentacao IS NULL OR valor_fonteAlimentacao < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Valor da fonte de alimentação deve ser maior ou igual a zero.';
    END IF;

    INSERT INTO tb_fonteAlimentacao (nome_fonteAlimentacao, valor_fonteAlimentacao, especificacao_fonteAlimentacao) 
    VALUES (nome_fonteAlimentacao, valor_fonteAlimentacao, especificacao_fonteAlimentacao);
END $$

DELIMITER ;

/*-------------------------------INSERT DE MEMORIA---------------------------------*/
DELIMITER $$
CREATE PROCEDURE sp_insertMemoria(in_nome_memoria VARCHAR(30),in_valor_memoria FLOAT, in_especificacao_memoria LONGTEXT)
BEGIN
	INSERT INTO tb_memoria(nome_memoria, valor_memoria, especificacao_memoria)
    VALUES (fn_removeAcento(in_nome_memoria), in_valor_memoria, fn_removeAcento(in_especificacao_memoria));
END $$
DELIMITER ;

/*-------------------------------INSERT DE MONITOR---------------------------------*/
DELIMITER $$
CREATE PROCEDURE sp_insert_monitor (
    IN nome_monitor VARCHAR(30),
    IN valor_monitor FLOAT,
    IN especificacao_monitor LONGTEXT
)
BEGIN
    IF nome_monitor IS NULL OR nome_monitor = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nome do monitor não pode estar vazio.';
    END IF;

    IF valor_monitor IS NULL OR valor_monitor < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Valor do monitor deve ser maior ou igual a zero.';
    END IF;

    INSERT INTO tb_monitor (nome_monitor, valor_monitor, especificacao_monitor) 
    VALUES (nome_monitor, valor_monitor, especificacao_monitor);
END $$
DELIMITER ;


/*-------------------------------INSERT DE TECLADO ---------------------------------*/
DELIMITER $$
CREATE PROCEDURE sp_insert_teclado (
    IN nome_teclado VARCHAR(30),
    IN valor_teclado FLOAT,
    IN especificacao_teclado LONGTEXT
)
BEGIN
    IF nome_teclado IS NULL OR nome_teclado = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nome do teclado não pode estar vazio.';
    END IF;

    IF valor_teclado IS NULL OR valor_teclado < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Valor do teclado deve ser maior ou igual a zero.';
    END IF;

    INSERT INTO tb_teclado (nome_teclado, valor_teclado, especificacao_teclado) 
    VALUES (nome_teclado, valor_teclado, especificacao_teclado);
END $$

DELIMITER ;

/*-------------------------------INSERT DE MOUSE---------------------------------*/
DELIMITER $$
CREATE PROCEDURE sp_insert_mouse (
    IN nome_mouse VARCHAR(30),
    IN valor_mouse FLOAT,
    IN especificacao_mouse LONGTEXT
)
BEGIN
    IF nome_mouse IS NULL OR nome_mouse = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nome do mouse não pode estar vazio.';
    END IF;

    IF valor_mouse IS NULL OR valor_mouse < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Valor do mouse deve ser maior ou igual a zero.';
    END IF;

    INSERT INTO tb_mouse (nome_mouse, valor_mouse, especificacao_mouse) 
    VALUES (nome_mouse, valor_mouse, especificacao_mouse);
END $$

DELIMITER ;

/*-------------------------------INSERT DE PLACA MAE---------------------------------*/
DELIMITER $$
CREATE PROCEDURE sp_insert_placaMae (
    IN nome_placaMae VARCHAR(30),
    IN valor_placaMae FLOAT,
    IN especificacao_placaMae LONGTEXT
)
BEGIN
    IF nome_placaMae IS NULL OR nome_placaMae = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nome da placa mãe não pode estar vazio.';
    END IF;

    IF valor_placaMae IS NULL OR valor_placaMae < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Valor da placa mãe deve ser maior ou igual a zero.';
    END IF;

    INSERT INTO tb_placaMae (nome_placaMae, valor_placaMae, especificacao_placaMae) 
    VALUES (nome_placaMae, valor_placaMae, especificacao_placaMae);
END $$

DELIMITER ;


/*-------------------------------INSERT DE PROCESSADOR---------------------------------*/
DELIMITER $$
CREATE PROCEDURE sp_insert_processador (
    IN nome_processador VARCHAR(30),
    IN valor_processador FLOAT,
    IN especificacao_processador LONGTEXT
)
BEGIN
    IF nome_processador IS NULL OR nome_processador = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nome do processador não pode estar vazio.';
    END IF;

    IF valor_processador IS NULL OR valor_processador < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Valor do processador deve ser maior ou igual a zero.';
    END IF;

    INSERT INTO tb_processador (nome_processador, valor_processador, especificacao_processador) 
    VALUES (nome_processador, valor_processador, especificacao_processador);
END $$

DELIMITER ;

/*-------------------------------INSERT DE TECLADO---------------------------------*/
DELIMITER $$
CREATE PROCEDURE sp_insertTeclado(in_nome_teclado VARCHAR(30),in_valor_teclado FLOAT, in_especificacao_teclado LONGTEXT)
BEGIN
	INSERT INTO tb_teclado(nome_teclado, valor_teclado, especificacao_teclado)
    VALUES (fn_removeAcento(in_nome_teclado), in_valor_teclado, fn_removeAcento(in_especificacao_teclado));
END $$
DELIMITER ;


/*-------------------------------INSERT DE MAQUINA---------------------------------*/
DELIMITER $$
CREATE PROCEDURE sp_insert_maquina (
    IN nome_maquina VARCHAR(30),
    IN id_placaMae INT,
    IN id_processador INT,
    IN id_armazenamento INT,
    IN id_memoria INT,
    IN id_cooler INT,
    IN id_fonteAlimentacao INT,
    IN id_monitor INT,
    IN id_teclado INT,
    IN id_mouse INT
)
BEGIN
    IF nome_maquina IS NULL OR nome_maquina = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nome da máquina não pode estar vazio.';
    END IF;

    IF id_placaMae IS NULL OR id_placaMae <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ID da placa mãe deve ser maior que zero.';
    END IF;

    IF id_processador IS NULL OR id_processador <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ID do processador deve ser maior que zero.';
    END IF;

    IF id_armazenamento IS NULL OR id_armazenamento <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ID do armazenamento deve ser maior que zero.';
    END IF;

    IF id_memoria IS NULL OR id_memoria <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ID da memória deve ser maior que zero.';
    END IF;

    IF id_cooler IS NULL OR id_cooler <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ID do cooler deve ser maior que zero.';
    END IF;

    IF id_fonteAlimentacao IS NULL OR id_fonteAlimentacao <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ID da fonte de alimentação deve ser maior que zero.';
   END IF;
   INSERT INTO tb_maquina (nome_maquina, id_placaMae, id_processador, id_armazenamento, id_memoria, id_cooler, id_fonteAlimentacao, id_monitor, id_teclado, id_mouse)
VALUES (nome_maquina, id_placaMae, id_processador, id_armazenamento, id_memoria, id_cooler, id_fonteAlimentacao, id_monitor, id_teclado, id_mouse);

END $$
DELIMITER ;

ALTER TABLE tb_maquina
ADD valor_maquina FLOAT;

CREATE VIEW vw_maquina AS
SELECT m.id_maquina ID,
	   m.nome_maquina NOME,
	   p.nome_placaMae PLACAMAE,
       i.nome_processador PROCESSADOR,
       a.nome_armazenamento ARMAZENAMENTO,
       a.especificacao_armazenamento ESPACO,
       u.nome_memoria MEMORIA,
       u.especificacao_memoria GB,
       f.nome_fonteAlimentacao FONTE,
       c.nome_cooler COOLER,
       m.valor_maquina VALOR
FROM tb_maquina m
JOIN tb_armazenamento a
	ON m.id_armazenamento = a.id_armazenamento
JOIN tb_cooler c
	ON m.id_cooler = c.id_cooler
JOIN tb_fontealimentacao f
	ON m.id_fonteAlimentacao = f.id_fonteAlimentacao
JOIN tb_memoria u
	ON m.id_memoria = u.id_memoria
JOIN tb_placamae p
	ON m.id_placaMae = p.id_placaMae
JOIN tb_processador i
	ON m.id_processador = i.id_processador;

/*----------------------------------------VIEWS DE CONTROLE DE ESTOQUE-----------------------------------*/

CREATE VIEW vw_estoquePlacamae AS
SELECT COUNT(id_placaMae) QTD_PLACAMAE
FROM tb_placamae;

CREATE VIEW vw_estoqueProcessador AS
SELECT COUNT(id_processador) QTD_PROCESSADOR
FROM tb_processador;

CREATE VIEW vw_estoqueArmazenamento AS
SELECT COUNT(id_armazenamento) QTD_ARMAZENAMENTO
FROM tb_armazenamento;

CREATE VIEW vw_estoqueMemoria AS
SELECT COUNT(id_memoria) QTD_MEMORIA
FROM tb_memoria;

CREATE VIEW vw_estoqueCooler AS
SELECT COUNT(id_cooler) QTD_COOLER
FROM tb_cooler;

CREATE VIEW vw_estoqueFAlimentacao AS
SELECT COUNT(id_fonteAlimentacao) QTD_FALIMENTACAO
FROM tb_fontealimentacao;

CREATE VIEW vw_estoqueMonitor AS
SELECT COUNT(id_monitor) QTD_MONITOR
FROM tb_monitor;

CREATE VIEW vw_estoqueMouse AS
SELECT COUNT(id_mouse) QTD_MOUSE
FROM tb_mouse;

CREATE VIEW vw_estoqueTeclado AS
SELECT COUNT(id_teclado) QTD_TECLADO
FROM tb_teclado;
--------------------------------------------------------------------------------------------------------------------------------


--------------------------------------------------------------------------------------------------------------------------------

CREATE VIEW vw_valores AS
SELECT  a.valor_armazenamento,
		p.valor_placaMae, 
        i.valor_processador,
		u.valor_memoria,
        f.valor_fonteAlimentacao,
        c.valor_cooler
FROM tb_maquina m
JOIN tb_armazenamento a
	ON m.id_armazenamento = a.id_armazenamento
JOIN tb_cooler c
	ON m.id_cooler = c.id_cooler
JOIN tb_fontealimentacao f
	ON m.id_fonteAlimentacao = f.id_fonteAlimentacao
JOIN tb_memoria u
	ON m.id_memoria = u.id_memoria
JOIN tb_placamae p
	ON m.id_placaMae = p.id_placaMae
JOIN tb_processador i
	ON m.id_processador = i.id_processador;

SELECT valor_armazenamento + 
	   valor_placaMae + 
	   valor_processador + 
	   valor_memoria + 
	   valor_fonteAlimentacao + 
	   valor_cooler from vw_valores;


/*------------------------------ TABELAS CAIXA DE CLIENTE -----------------------------------*/


CREATE TABLE tb_cliente(
	id_cliente INT AUTO_INCREMENT,
    nome_cliente VARCHAR (30) NOT NULL,
PRIMARY KEY (id_cliente)
);
    
    
    
/*------------------------------ TABELAS DE PEDIDOS -----------------------------------*/

CREATE TABLE tb_pedido(
	id_pedido INT AUTO_INCREMENT,
    valor_pedido FLOAT NOT NULL,
    id_maquina INT,
    id_cliente INT,
PRIMARY KEY (id_pedido),
CONSTRAINT FK_id_maquina FOREIGN KEY (id_maquina) REFERENCES tb_maquina (id_maquina),
CONSTRAINT FK_id_cliente FOREIGN KEY (id_cliente) REFERENCES tb_cliente (id_cliente)
);


CREATE VIEW vw_venda AS
SELECT c.nome_cliente CLIENTE,
	   p.valor_pedido VALOR,
       m.nome_maquina MAQUINA
FROM tb_pedido p
JOIN tb_cliente c
	ON p.id_cliente = c.id_cliente
JOIN tb_maquina m
	ON p.id_maquina = m.id_maquina;
	   
CREATE TABLE tb_caixa(
    id_caixa INT AUTO_INCREMENT,
    valor FLOAT NOT NULL,
PRIMARY KEY (id_caixa),
);

INSERT INTO tb_caixa VALUES (1,0);

CREATE VIEW vw_processador AS
SELECT * FROM tb_processador;

CREATE VIEW vw_caixa AS
select * from tb_caixa;

DELIMITER $$

CREATE TRIGGER trg_caixa AFTER INSERT
ON tb_pedido
FOR EACH ROW
	BEGIN
	DECLARE soma FLOAT;
        SET soma = (SELECT SUM(valor_pedido) FROM tb_venda);
        
        UPDATE tb_caixa SET valor = soma WHERE id_caixa = 1;
    END $$

DELIMITER ;

INSERT INTO `tb_armazenamento` VALUES (1,'SSD KINGSTON',90,'240 GB'),
(2,'SSD SAMSUNG QVO 870',120,'240 GB'),(3,'SSD SAMSUNG QVO 970',250,'512 GB'),
(4,'SSD KINGSTON KC600',250,'512 GB'),(5,'SSD KINGSTON KC600',350,'1 TB'),(6,'HDD SEAGATE',150,'2 TB');

INSERT INTO `tb_cooler` VALUES (1,'COOLER PROCESSADOR X99',90,'120 MM'),(2,'FREEZE MODE',360,'150W'),
(3,'RYSE MODE',220,'150W'),(4,'SUPER COOLER',420,'350W');

INSERT INTO `tb_fontealimentacao` VALUES (1,'FONTE ATX MACH',125,'500 W BIVOLT'),
(2,'ATX RH200',250,'500W'),(3,'ATX RH210',260,'500W'),(4,'ATX RH110',160,'200W'),(5,'ATX RH310',460,'1000W');

INSERT INTO `tb_memoria` VALUES (1,'MEMORIA ALTMER',100,'8 GB 2100 MHZ'),
(2,'MEMORIA ALTMER',100,'8 GB 2100 MHZ'),(3,'X2 MEMORIA ALTMER',200,'16 GB 2100 MHZ'),
(4,'X2 MEMORIA ALTMER',200,'16 GB DDR4 2100 MHZ'),(5,'KINGSTON HYPERX',130.99,'8GB'),
(6,'X2 KINGSTON HYPERX',260.99,'16 GB'),(7,'ASGARD LOKI',100,'6 GB'),(8,'X2 ASGARD LOKI',200,'16 GB'),
(9,'JUHOR',109,'8 GB'),(10,'X2 JUHOR',220,'16 GB');

INSERT INTO `tb_monitor` VALUES (1,'SANSUBG TBE',500,'FULL HD'),(2,'SANSUNG XRE',600,'FULL HD'),(3,'DELL VR',400,'FULL HD');

INSERT INTO `tb_mouse` VALUES (1,'RAZER XOPTICS',130,'OPTICO'),(2,'DELL G1',100,'OPTICO'),(3,'DELL G2',110,'OPTICO');

INSERT INTO `tb_placamae` VALUES (1,'PLACA MAE ALTMIER',180,'PLACA MAE DDR4'),(2,'ACER BC 500',300,'DDR4 4 ENTRADAS'),(3,'ASUS XR3',270,'DDR4 12 ENTRADAS');

INSERT INTO `tb_processador` VALUES (1,'XEON E5 2640 V3',200,'PROCESSADOR 12 NUCLEOS 16 THREADS'),
(2,'AMD RYZEN 5 5500',600,'6 NUCLEOS 12 THREADS'),(3,'AMD RYZEN 7 5600',600,'8 NUCLEOS 16 THREADS'),(4,'INTEL CORE I5 12500H',1600,'12 NUCLEOS 24 THREADS');

INSERT INTO `tb_teclado` VALUES (1,'MULTILASER',50,'TECLADO'),(2,'XDRAGON RAZER',150,'MECANICO'),(3,'BLUE STAR',170,'MECANICO');

INSERT INTO `tb_maquina` VALUES (7,'RTX 2023',1,1,1,1,1,1,1,1,1,2500);

INSERT INTO `tb_cliente` VALUES (1,'Ricardo Pereira'),(2,'FERNANDO OLIVEIRA'),(3,'REINALDO JOSE');

INSERT INTO `tb_pedido` VALUES (4,3200,7,1),(5,3000,12,2),(6,2900,13,2);

