--CREATE DATABASE biblioteca

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

INSERT INTO usuario
(nome, cpf, email, telefone, endereco)
VALUES
('Vitória de Paula Zanchet', '00011122233', 'vitoria.zanchet@hotmail.com', '24993075857', 'Servidão Domingos Zanchet, 2, Cascatinha, Petrópolis/RJ'),
('Tiana Coelho de Paula', '11100011133', 'tiana.coelho@gmail.com', '24988188100', 'Rua Waldemar Vieira Afonso, 42, Carangola, Petrópolis/RJ'),
('Vicente Vieira Albuquerque', '88800011199', 'vicentealbuquerque@icloud.com', '11982472657', 'Alameda Ribeirão Preto, 302, Bela Vista, São Paulo/SP'),
('Valéria Valente', '00011122789', 'valentevaleria@outlook.com', '21992180758', 'Praia de Botafogo, 324, Botafogo, Rio de Janeiro/RJ'),
('Rosa Tessaro', '78911122233', 'tessarosa@yahoo.com', '32998005857', 'Rua Mariano Procópio, 1403, Mariano Procópio, Juiz de Fora/MG'),
('Bárbara Antunes Trindade', '82015552273', 'babi_linda123@hotmail.com', '21999074231', 'Ladeira Iria de Oliveira Dias, 34, Cascatinha, Petrópolis/RJ');

UPDATE usuario
SET telefone = '24972150089'
WHERE nome = 'Tiana Coelho de Paula';

INSERT INTO emprestimo
(id_usuario, id_livro, data_emprestimo, data_devolucao, status)
VALUES
(1, 7, '2026-03-20', NULL, 'emprestado'),
(4, 3, '2024-08-14', '2024-08-28',  'devolvido'),
(5, 7, '2025-01-02', '2025-01-18',  'devolvido'),
(2, 9, '2025-01-20', '2025-02-15',  'devolvido'),
(5, 4, '2025-07-08', '2025-08-01',  'devolvido'),
(1, 5, '2025-11-18', '2026-01-20',  'devolvido'),
(3, 2, '2026-01-10', '2026-02-15',  'devolvido'),
(2, 6, '2026-02-07', '2026-03-08',  'devolvido'),
(5, 1, '2026-02-28', NULL, 'emprestado'),
(4, 9, '2026-02-28', '2026-03-15',  'devolvido'),
(4, 4, '2026-03-15', '2026-03-20',  'devolvido'),
(2, 10, '2026-03-17', NULL, 'emprestado'),
(3, 5, '2026-03-20', NULL, 'emprestado'),
(4, 7, '2026-03-20', NULL, 'emprestado');


--1. Selecione todos os livros cadastrados no banco de dados. 
SELECT * FROM livro;

--2. Liste o nome do usuário e o título do livro de todos os empréstimos realizados, utilizando um JOIN. 
SELECT u.nome, l.titulo
FROM emprestimo AS e
INNER JOIN usuario AS u ON u.idusuario = e.id_usuario
INNER JOIN livro AS l ON l.idlivro = e.id_livro;

--3. Selecione todos os empréstimos que ainda não foram devolvidos (status = 'emprestado'). 
SELECT l.titulo, e.status, u.nome
FROM emprestimo AS e
INNER JOIN livro AS l ON l.idlivro = e.id_livro
INNER JOIN usuario AS u ON u.idusuario = e.id_usuario
WHERE status = 'emprestado';

--4. Liste todos os autores e os livros que eles escreveram. 
SELECT autor, titulo FROM livro ORDER BY autor ASC, titulo ASC;

--5. Crie uma consulta que mostre todos os usuários e os livros que já pegaram emprestado, incluindo usuários que nunca pegaram livros.
SELECT u.nome, l.titulo
FROM usuario AS u
LEFT JOIN emprestimo AS e ON u.idusuario = e.id_usuario
LEFT JOIN livro AS l ON l.idlivro = e.id_livro
ORDER BY nome ASC, titulo ASC;