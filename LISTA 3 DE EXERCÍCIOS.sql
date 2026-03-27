--CREATE DATABASE biblioteca

/*
CREATE TABLE livro(
	idlivro SERIAL PRIMARY KEY,
	titulo VARCHAR(100) NOT NULL,
	autor VARCHAR(80) NOT NULL,
	ano_publicacao INT NOT NULL,
	genero VARCHAR(30) NOT NULL,
	quantidade_estoque INT NOT NULL
);

CREATE TABLE usuario(
	idusuario SERIAL PRIMARY KEY,
	nome VARCHAR(80) NOT NULL,
	cpf VARCHAR(11) UNIQUE,
	email VARCHAR(100) UNIQUE,
	telefone VARCHAR(11) NOT NULL,
	endereco VARCHAR(150) NOT NULL
);

CREATE TYPE status_emprestimo AS ENUM('emprestado', 'devolvido');

CREATE TABLE emprestimo(
	idemprestimo SERIAL PRIMARY KEY,
	id_usuario INT NOT NULL,
	id_livro INT NOT NULL,
	data_emprestimo DATE NOT NULL,
	data_devolucao DATE,
	status status_emprestimo NOT NULL,
	FOREIGN KEY(id_usuario) REFERENCES usuario(idusuario),
	FOREIGN KEY(id_livro) REFERENCES livro(idlivro)
);

ALTER TABLE livro
	ADD editora VARCHAR(100);
*/


--1. Insira 10 registros na tabela livro com informações fictícias.

INSERT INTO livro
(titulo, autor, ano_publicacao, genero, quantidade_estoque, editora)
VAlUES
('Curso De Direito Penal - Vol. 1', 'GRECO, Rogério', 2020, 'Direito', 3, 'Impetus'),
('Direito Internacional Público', 'REZEK, Francisco', 2026, 'Direito', 1, 'Saraiva Jur'),
('Direito Civil Brasileiro: Direito de Família - Vol. 6', 'GONÇALVES, Carlos Roberto', 2010, 'Direito', 2, 'Saraiva'),
('A menina que roubava livros', 'ZUSAK, Markus', 2005, 'Romance', 8, 'Intrínseca'),
('O corcunda de Notre-Dame', 'HUGO, Victor', 1973, 'Romance', 1, 'Editora Três'),
('Orgulho e Preconceito', 'AUSTEN, Jane', 2023, 'Romance', 7, 'Pé da Letra'),
('Orgulho e Preconceito', 'AUSTEN, Jane', 2006, 'Romance', 3, 'Martin Claret'),
('Razão e Sensibilidade', 'AUSTEN, Jane', 2023, 'Romance', 4, 'Pé da Letra'),
('Razão e Sensibilidade', 'AUSTEN, Jane', 2012, 'Romance', 2, 'Martin Claret'),
('Persuasão ', 'AUSTEN, Jane', 2023, 'Romance', 5, 'Pé da Letra');


--2. Insira 5 registros na tabela usuario com diferentes usuários. 

INSERT INTO usuario
(nome, cpf, email, telefone, endereco)
VALUES
('Vitória de Paula Zanchet', '00011122233', 'vitoria.zanchet@hotmail.com', '24993075857', 'Servidão Domingos Zanchet, 2, Cascatinha, Petrópolis/RJ'),
('Tiana Coelho de Paula', '11100011133', 'tiana.coelho@gmail.com', '24988188100', 'Rua Waldemar Vieira Afonso, 42, Carangola, Petrópolis/RJ'),
('Vicente Vieira Albuquerque', '88800011199', 'vicentealbuquerque@icloud.com', '11982472657', 'Alameda Ribeirão Preto, 302, Bela Vista, São Paulo/SP'),
('Valéria Valente', '00011122789', 'valentevaleria@outlook.com', '21992180758', 'Praia de Botafogo, 324, Botafogo, Rio de Janeiro/RJ'),
('Rosa Tessaro', '78911122233', 'tessarosa@yahoo.com', '32998005857', 'Rua Mariano Procópio, 1403, Mariano Procópio, Juiz de Fora/MG');


--3. Atualize o telefone de um usuário específico usando o comando UPDATE.

UPDATE usuario
SET telefone = '24972150089'
WHERE nome = 'Tiana Coelho de Paula';

--4. Tente remover um usuário específico da tabela usuario que possui um empréstimo. O que aconteceu? Explique o que ocorreu? 

INSERT INTO emprestimo
(id_usuario, id_livro, data_emprestimo, status)
VALUES
(1,7, '2026-03-20', 'emprestado');

DELETE FROM usuario
WHERE idusuario = 1


/*      EXPLICAÇÃO DO ERRO:
	Como a chave idusuario = 1 é referenciada da tabela "emprestimo" a exclusão desta viola a
	restrição de chave estrangeira. Ou seja, quando uma tabela B possui chave estrangeira que
	referencia outra tabela A, o banco de dados proíbe a exclusão da linha na tabela A se ela
	estiver sendo usada na B para evitar que a mesma fique apontando para uma tabela que não 
	existe mais.
*/

/* 5. (DESAFIO) Explique a diferença entre DELETE FROM e TRUNCATE TABLE. Em qual situação
cada um deve ser utilizado?

O DELETE FROM é um comando DML, ele manipula os dados excluindo registros dentro da tabela, pode
ser usado para remover linhas específicas (com o comando WHERE) ou todas as linhas porém de forma
lenta pois ele trabalha linha a linha. Enquanto o TRUNCATE TABLE é um comando DDL que altera a
estrutura da tabela excluindo todas as linhas de uma vez em uma única operação mantendo a tabela
no banco de dados.
Logo, o DELETE FROM é mais indicado para quando desejamos excluir valores especificados e o TRUNCATE
TABLE quando deseja excluir todos os dados da tabela.
*/