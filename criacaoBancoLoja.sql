DROP TABLE Movimento;

DROP TABLE PessoaFisica;

DROP TABLE PessoaJuridica;

DROP TABLE Usuario;

DROP TABLE Pessoa;

DROP TABLE Produto;

DROP SEQUENCE idPessoaSequence;

CREATE TABLE Produto (
  idProduto INTEGER  NOT NULL   IDENTITY ,
  nome VARCHAR(255)  NOT NULL  ,
  quantidade INTEGER  NOT NULL  ,
  precoVenda NUMERIC(10,2)  NOT NULL    ,
PRIMARY KEY(idProduto));
GO




CREATE TABLE Pessoa (
  idPessoa INTEGER  NOT NULL  ,
  nome VARCHAR(255)  NOT NULL  ,
  logradouro VARCHAR(255)    ,
  cidade VARCHAR(255)    ,
  estado VARCHAR(2)    ,
  telefone VARCHAR(11)    ,
  email VARCHAR(255)  NOT NULL    ,
PRIMARY KEY(idPessoa));
GO




CREATE TABLE Usuario (
  idUsuario INTEGER  NOT NULL   IDENTITY ,
  login VARCHAR(255)  NOT NULL  ,
  senha VARCHAR(255)  NOT NULL    ,
PRIMARY KEY(idUsuario));
GO




CREATE TABLE PessoaJuridica (
  cnpj VARCHAR(14)  NOT NULL  ,
  Pessoa_idPessoa INTEGER  NOT NULL    ,
PRIMARY KEY(cnpj)  ,
  FOREIGN KEY(Pessoa_idPessoa)
    REFERENCES Pessoa(idPessoa));
GO


CREATE INDEX PessoaJuridica_FKIndex1 ON PessoaJuridica (Pessoa_idPessoa);
GO


CREATE INDEX IFK_PessoaJuridica ON PessoaJuridica (Pessoa_idPessoa);
GO


CREATE TABLE PessoaFisica (
  cpf VARCHAR(11)  NOT NULL  ,
  Pessoa_idPessoa INTEGER  NOT NULL    ,
PRIMARY KEY(cpf)  ,
  FOREIGN KEY(Pessoa_idPessoa)
    REFERENCES Pessoa(idPessoa));
GO


CREATE INDEX PessoaFisica_FKIndex1 ON PessoaFisica (Pessoa_idPessoa);
GO


CREATE INDEX IFK_PessoaFisica ON PessoaFisica (Pessoa_idPessoa);
GO


CREATE TABLE Movimento (
  idMovimento INTEGER  NOT NULL   IDENTITY ,
  Usuario_idUsuario INTEGER  NOT NULL  ,
  Pessoa_idPessoa INTEGER  NOT NULL  ,
  Produto_idProduto INTEGER  NOT NULL  ,
  quantidadeProduto INTEGER  NOT NULL  ,
  precoUnitario NUMERIC(10,2)  NOT NULL  ,
  tipo CHAR(1)  NOT NULL    ,
PRIMARY KEY(idMovimento)      ,
  FOREIGN KEY(Produto_idProduto)
    REFERENCES Produto(idProduto),
  FOREIGN KEY(Pessoa_idPessoa)
    REFERENCES Pessoa(idPessoa),
  FOREIGN KEY(Usuario_idUsuario)
    REFERENCES Usuario(idUsuario));
GO


CREATE INDEX Movimento_FKIndex1 ON Movimento (Produto_idProduto);
GO
CREATE INDEX Movimento_FKIndex2 ON Movimento (Pessoa_idPessoa);
GO
CREATE INDEX Movimento_FKIndex3 ON Movimento (Usuario_idUsuario);
GO


CREATE INDEX IFK_ItemMovimentado ON Movimento (Produto_idProduto);
GO
CREATE INDEX IFK_Cliente ON Movimento (Pessoa_idPessoa);
GO
CREATE INDEX IFK_Responsavel ON Movimento (Usuario_idUsuario);
GO


CREATE SEQUENCE idPessoaSequence
START WITH 1 
INCREMENT BY 1;
GO