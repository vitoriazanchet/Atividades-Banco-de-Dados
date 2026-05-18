/*Aula 2: Criando o Banco de Dados (DDL) 

1. Crie um banco de dados chamado biblioteca.

2. Crie uma tabela livro com os seguintes campos: 
 id (chave primária, autoincremento) 
 titulo (não nulo) 
 autor (não nulo) 
 ano_publicacao (não nulo) 
 genero (não nulo) 
 quantidade_estoque (não nulo) 

 3. Crie uma tabela usuario com os campos: 
 id (chave primária, autoincremento) 
 nome (não nulo) 
 cpf (único) 
 email (único) 
 telefone (não nulo) 
 endereco (não nulo) 

 4. Crie uma tabela emprestimo com os seguintes campos: 
 
 id (chave primária, autoincremento)
 id_usuario (chave estrangeira referenciando usuario)
 id_livro (chave estrangeira referenciando livro)
 data_emprestimo (não nulo)
 data_devolucao (pode ser nulo)
 status (ENUM: "emprestado", "devolvido") 

 5. Escreva um comando SQL para alterar a tabela livro, adicionando um campo editora
VARCHAR(100).*/

--CREATE DATABASE biblioteca;

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
	status b01.status_emprestimo NOT NULL,
	FOREIGN KEY(id_usuario) REFERENCES usuario(idusuario),
	FOREIGN KEY(id_livro) REFERENCES livro(idlivro)
);

ALTER TABLE livro
	ADD editora VARCHAR(100);