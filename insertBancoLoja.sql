insert into Usuario (login, senha) values ('op1', 'op1');
insert into Usuario (login, senha) values ('op2', 'op2');

select * from Usuario;


insert into Produto (nome, quantidade, precoVenda) values 
('banana', '100', '5.00'),
('laranja', '500', '2.00'),
('manga', '800', '4.00'),
('maça', '100', '5.70');

select * from Produto;


DECLARE @NextValue INT
SELECT @NextValue = NEXT VALUE FOR idPessoaSequence

insert into Pessoa (idPessoa, nome, logradouro, cidade, estado, telefone, email) values 
(@NextValue, 'João', 'Rua 12, casa 3, Quitanda', 'Riacho do Sul', 'PA', '1111-1111', 'joao@riacho.com');

insert into PessoaFisica(Pessoa_idPessoa, cpf) values 
(@NextValue, '12345678900');

--DECLARE @NextValue INT
SELECT @NextValue = NEXT VALUE FOR idPessoaSequence

insert into Pessoa (idPessoa, nome, logradouro, cidade, estado, telefone, email) values 
(@NextValue, 'JJC', 'Rua 11, Centro', 'Riacho do Norte', 'PA', '1212-1212', 'jjco@riacho.com');

insert into PessoaJuridica(Pessoa_idPessoa, cnpj) values 
(@NextValue, '222222222222');


insert into Movimento (Usuario_idUsuario, Pessoa_idPessoa, Produto_idProduto, quantidadeProduto, tipo, precoUnitario) values 
(1, 2, 1, 20, 'S', 4.00),
(2, 2, 2, 15, 'S', 2.00),
(2, 2, 1, 10, 'S', 3.00),
(1, 3, 2, 15, 'E', 5.00),
(1, 3, 4, 20, 'E', 4.00);

select * from Movimento


--Exercicio 4
--letra a: 
select * from Pessoa 
inner join PessoaFisica on (Pessoa.idPessoa = PessoaFisica.Pessoa_idPessoa);

--letra b: 
select * from Pessoa 
inner join PessoaJuridica on (Pessoa.idPessoa = PessoaJuridica.Pessoa_idPessoa);

--letra c:
select 
	p.nome, 
	pe.nome, 
	m.quantidadeProduto, 
	m.precoUnitario, 
	m.quantidadeProduto * m.precoUnitario as ValorTotal 
from Movimento as m
inner join Produto as p on (m.Produto_idProduto = p.idProduto)
inner join Pessoa as pe on (m.Pessoa_idPessoa = pe.idPessoa)
where tipo = 'E'


--letra d:
select 
	p.nome, 
	pe.nome, 
	m.quantidadeProduto, 
	m.precoUnitario, 
	m.quantidadeProduto * m.precoUnitario as ValorTotal 
from Movimento as m
inner join Produto as p on (m.Produto_idProduto = p.idProduto)
inner join Pessoa as pe on (m.Pessoa_idPessoa = pe.idPessoa)
where tipo = 'S'


--letra e: 
select p.nome, sum(quantidadeProduto * precoUnitario) as ValorTotal 
from Movimento as m
inner join Produto as p on (m.Produto_idProduto = p.idProduto)
where m.tipo = 'E'
group by p.nome


--letra f: 
select p.nome, sum(quantidadeProduto * precoUnitario) as ValorTotal 
from Movimento as m
inner join Produto as p on (m.Produto_idProduto = p.idProduto)
where m.tipo = 'S'
group by p.nome


--letra g:
select u.idUsuario, u.login from 
	(select idUsuario from Usuario
	EXCEPT   
	select Usuario_idUsuario from Movimento as m
	where m.tipo = 'E') as UserSemMovimento
inner join Usuario as u on (u.idUsuario = UserSemMovimento.idUsuario)


--letra h:
select u.login, sum(quantidadeProduto * precoUnitario) as ValorTotal 
from Movimento as m
inner join Usuario as u on (m.Usuario_idUsuario = u.idUsuario)
where m.tipo = 'E'
group by u.login


--letra i:
select u.login, sum(quantidadeProduto * precoUnitario) as ValorTotal 
from Movimento as m
inner join Usuario as u on (m.Usuario_idUsuario = u.idUsuario)
where m.tipo = 'S'
group by u.login


--letra j:
select p.nome,  sum(quantidadeProduto * precoUnitario)/sum(quantidadeProduto) as ValorTotal 
from Movimento as m
inner join Produto as p on (m.Produto_idProduto = p.idProduto)
where m.tipo = 'S'
group by p.nome

select * from Movimento