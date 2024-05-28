/*
Created		15/12/2008
Modified		13/01/2009
Project		Atelier D. Maria
Model			ER
Company		MEGs
Author		Márcio Las
Version		0.1.0
Database		PostgreSQL 8.1 
*/

/* Create Tables */


Create table "estoque"
(
	"codigo_estoque" Serial NOT NULL,
	"data_estoque" Date NOT NULL,
	"es" Char(1) NOT NULL Default 'E' Constraint "estoque_entrada_saida_chk" Check (es IN ('E','S')),
	"quantidade" Double precision NOT NULL,
	"precounitario" Double precision NOT NULL,
	"codigo_grupo" Integer NOT NULL,
	"codigo_produto" Integer NOT NULL,
	"codigo_unidade" Integer NOT NULL,
	"codigo_compra" Integer,
	"codigo_produtos_compra" Integer,
	"codigo_venda" Integer,
	"codigo_produtos_vendas" Integer,
 primary key ("codigo_estoque","codigo_grupo","codigo_produto")
) Without Oids;


Create table "produtos"
(
	"codigo_produto" Serial NOT NULL,
	"descricao" Varchar(100) NOT NULL UNIQUE,
	"detalhe" Text,
	"precounitario" Double precision,
	"quantidade_minima" Double precision,
	"saldo" Double precision Default 0,
	"situacao" Char(1) NOT NULL Default 'A' Constraint "produtos_situacao_chk" Check (situacao IN ('A','I')),
	"codigo_grupo" Integer NOT NULL,
	"codigo_caracteristica_1" Integer,
	"codigo_caracteristica_2" Integer,
	"codigo_caracteristica_3" Integer,
	"codigo_unidade" Integer NOT NULL,
 primary key ("codigo_produto","codigo_grupo")
) Without Oids;


Create table "grupos"
(
	"codigo_grupo" Serial NOT NULL,
	"descricao" Char(30) NOT NULL UNIQUE,
	"caracteristica_1" Integer,
	"caracteristica_2" Integer,
	"caracteristica_3" Integer,
 primary key ("codigo_grupo")
) Without Oids;


Create table "unidades"
(
	"codigo_unidade" Serial NOT NULL,
	"sigla" Varchar(6) NOT NULL UNIQUE,
	"descricao" Varchar(30) NOT NULL UNIQUE,
 primary key ("codigo_unidade")
) Without Oids;


Create table "fornecedores"
(
	"codigo_fornecedor" Serial NOT NULL,
	"nome" Varchar(60) NOT NULL UNIQUE,
	"cpfcnpj" Varchar(14),
	"contato" Varchar(30),
	"endereco" Varchar(60),
	"numero" Varchar(10),
	"complemento" Varchar(60),
	"cep" Varchar(20),
	"referencia" Varchar(254),
	"email" Varchar(254),
	"telefone" Varchar(15),
	"fax" Varchar(15),
	"celular" Varchar(15),
	"website" Varchar(254),
	"situacao" Char(1) NOT NULL Default 'A' Constraint "fornecedores_situacao_chk" Check (situacao IN ('A','I')),
	"codigo_bairro" Integer,
	"codigo_cidade" Integer,
	"codigo_estado" Integer,
 primary key ("codigo_fornecedor")
) Without Oids;


Create table "cidades"
(
	"codigo_cidade" Serial NOT NULL,
	"descricao" Varchar(60) NOT NULL,
	"codigo_estado" Integer NOT NULL,
 primary key ("codigo_cidade")
) Without Oids;

Alter Table "cidades" add UNIQUE ("codigo_cidade");

Create table "estados"
(
	"codigo_estado" Serial NOT NULL,
	"descricao" Varchar(60) NOT NULL UNIQUE,
	"sigla" Char(2) NOT NULL UNIQUE,
 primary key ("codigo_estado")
) Without Oids;

Alter Table "estados" add UNIQUE ("codigo_estado");

Create table "bairros"
(
	"codigo_bairro" Serial NOT NULL,
	"descricao" Varchar(60) NOT NULL,
	"codigo_cidade" Integer NOT NULL,
	"codigo_estado" Integer NOT NULL,
 primary key ("codigo_bairro")
) Without Oids;

Alter Table "bairros" add UNIQUE ("codigo_bairro");

Create table "fornecedores_produtos"
(
	"codigo_fornecedor" Integer NOT NULL,
	"codigo_produto" Integer NOT NULL,
	"codigo_grupo" Integer NOT NULL,
 primary key ("codigo_fornecedor","codigo_produto","codigo_grupo")
) Without Oids;


Create table "clientes"
(
	"codigo_cliente" Serial NOT NULL,
	"nome" Varchar(60) NOT NULL UNIQUE,
	"cpfcnpj" Varchar(14),
	"contato" Varchar(30),
	"endereco" Varchar(60),
	"numero" Varchar(10),
	"complemento" Varchar(60),
	"cep" Varchar(20),
	"referencia" Varchar(254),
	"email" Varchar(254),
	"telefone" Varchar(15),
	"fax" Varchar(15),
	"celular" Varchar(15),
	"website" Varchar(254),
	"situacao" Char(1) NOT NULL Default 'A' Constraint "clientes_situacao_chk" Check (situacao IN ('A','I')),
	"codigo_bairro" Integer,
	"codigo_cidade" Integer,
	"codigo_estado" Integer,
 primary key ("codigo_cliente")
) Without Oids;


Create table "caracteristicas"
(
	"codigo_caracteristica" Serial NOT NULL,
	"descricao" Varchar(30) NOT NULL UNIQUE,
 primary key ("codigo_caracteristica")
) Without Oids;


Create table "itens_caracteristicas"
(
	"codigo_item_caracteristica" Serial NOT NULL,
	"descricao" Varchar(30) NOT NULL UNIQUE,
	"resumo" Varchar(15) NOT NULL UNIQUE,
	"codigo_caracteristica" Integer NOT NULL,
 primary key ("codigo_item_caracteristica")
) Without Oids;


Create table "orcamentos"
(
	"codigo_orcamento" Serial NOT NULL,
	"data_orcamento" Date NOT NULL,
	"observacoes" Text,
	"situacao" Char(1) NOT NULL Default 'A' Constraint "orcamentos_situacao_chk" Check (situacao IN ('A','N','F')),
	"tipo_servico" Char(1) NOT NULL Default 'N' Constraint "orcamentos_tipo_chk" Check (tipo_servico IN ('N','R')),
	"codigo_cliente" Integer NOT NULL,
 primary key ("codigo_orcamento")
) Without Oids;


Create table "produtos_orcamentos"
(
	"codigo_produtos_orcamentos" Serial NOT NULL,
	"quantidade" Double precision NOT NULL,
	"precounitario" Double precision NOT NULL,
	"codigo_orcamento" Integer NOT NULL,
	"codigo_grupo" Integer NOT NULL,
	"codigo_produto" Integer NOT NULL,
	"codigo_unidade" Integer NOT NULL,
 primary key ("codigo_produtos_orcamentos","codigo_orcamento")
) Without Oids;


Create table "compras"
(
	"codigo_compra" Serial NOT NULL,
	"data_compra" Date NOT NULL,
	"situacao" Char(1) NOT NULL Default 'A' Constraint "compras_situacao_chk" Check (situacao IN ('A','N','F')),
	"observacoes" Text,
	"codigo_fornecedor" Integer NOT NULL,
 primary key ("codigo_compra")
) Without Oids;


Create table "produtos_compras"
(
	"codigo_produtos_compra" Serial NOT NULL,
	"quantidade" Double precision NOT NULL,
	"precounitario" Double precision NOT NULL,
	"codigo_compra" Integer NOT NULL,
	"codigo_grupo" Integer NOT NULL,
	"codigo_produto" Integer NOT NULL,
	"codigo_unidade" Integer NOT NULL,
 primary key ("codigo_produtos_compra","codigo_compra")
) Without Oids;


Create table "vendas"
(
	"codigo_venda" Serial NOT NULL,
	"data_entrada" Date NOT NULL,
	"data_previsao_entrega" Date NOT NULL,
	"data_entrega" Date,
	"situacao" Char(1) NOT NULL Default 'A' Constraint "vendas_situacao_chk" Check (situacao IN ('A','N','P','F')),
	"tipo_servico" Char(1) NOT NULL Default 'N' Constraint "vendas_tipo_servico_chk" Check (tipo_servico IN ('N','R')),
	"observacoes" Text,
	"codigo_cliente" Integer NOT NULL,
	"codigo_orcamento" Integer,
 primary key ("codigo_venda")
) Without Oids;


Create table "produtos_vendas"
(
	"codigo_produtos_vendas" Serial NOT NULL,
	"quantidade" Double precision NOT NULL,
	"quantidade_entregue" Double precision,
	"precounitario" Double precision NOT NULL,
	"situacao" Char(1) NOT NULL Default 'A' Constraint "produtos_vendas_situacao_chk" Check (situacao IN ('A','N','P','F')),
	"codigo_venda" Integer NOT NULL,
	"codigo_grupo" Integer NOT NULL,
	"codigo_produto" Integer NOT NULL,
	"codigo_unidade" Integer NOT NULL,
 primary key ("codigo_produtos_vendas","codigo_venda")
) Without Oids;


Create table "empresa"
(
	"codigo" Serial NOT NULL,
	"codigo_estado" Integer,
	"codigo_bairro" Integer,
	"codigo_cidade" Integer,
	"nome" Varchar(60),
	"cpfcnpj" Varchar(14),
	"inscricao_municipal" Varchar(15),
	"inscricao_estadual" Varchar(15),
	"responsavel" Varchar(60),
	"contato" Varchar(60),
	"endereco" Varchar(60),
	"numero" Varchar(10),
	"telefone" Varchar(15),
	"fax" Varchar(15),
	"email" Varchar(254),
	"website" Varchar(254),
	"servidor_smtp" Varchar(60),
	"logotipo" Bit varying,
	"observacoes" Text,
 primary key ("codigo")
) Without Oids;


/* Create Tab 'Others' for Selected Tables */


/* Create Alternate Keys */


/* Create Indexes */
Create index "estoque_data_idx" on "estoque" using btree ("data_estoque");
Create index "cidades_descricao_idx" on "cidades" using btree ("descricao");
Create index "estados_descricao_idx" on "estados" using btree ("descricao");
Create index "bairros_descricao_idx" on "bairros" using btree ("descricao");
Create index "caracteristica_descricao_idx" on "caracteristicas" using btree ("descricao");


/* Create Foreign Keys */

Alter table "estoque" add  foreign key ("codigo_produto","codigo_grupo") references "produtos" ("codigo_produto","codigo_grupo") on update restrict on delete restrict;

Alter table "fornecedores_produtos" add  foreign key ("codigo_produto","codigo_grupo") references "produtos" ("codigo_produto","codigo_grupo") on update restrict on delete cascade;

Alter table "produtos_orcamentos" add  foreign key ("codigo_produto","codigo_grupo") references "produtos" ("codigo_produto","codigo_grupo") on update restrict on delete restrict;

Alter table "produtos_compras" add  foreign key ("codigo_produto","codigo_grupo") references "produtos" ("codigo_produto","codigo_grupo") on update restrict on delete restrict;

Alter table "produtos_vendas" add  foreign key ("codigo_produto","codigo_grupo") references "produtos" ("codigo_produto","codigo_grupo") on update restrict on delete restrict;

Alter table "produtos" add  foreign key ("codigo_grupo") references "grupos" ("codigo_grupo") on update restrict on delete restrict;

Alter table "produtos" add  foreign key ("codigo_unidade") references "unidades" ("codigo_unidade") on update restrict on delete restrict;

Alter table "estoque" add  foreign key ("codigo_unidade") references "unidades" ("codigo_unidade") on update restrict on delete restrict;

Alter table "produtos_orcamentos" add  foreign key ("codigo_unidade") references "unidades" ("codigo_unidade") on update restrict on delete restrict;

Alter table "produtos_compras" add  foreign key ("codigo_unidade") references "unidades" ("codigo_unidade") on update restrict on delete restrict;

Alter table "produtos_vendas" add  foreign key ("codigo_unidade") references "unidades" ("codigo_unidade") on update restrict on delete restrict;

Alter table "fornecedores_produtos" add  foreign key ("codigo_fornecedor") references "fornecedores" ("codigo_fornecedor") on update restrict on delete cascade;

Alter table "compras" add  foreign key ("codigo_fornecedor") references "fornecedores" ("codigo_fornecedor") on update restrict on delete restrict;

Alter table "bairros" add  foreign key ("codigo_cidade") references "cidades" ("codigo_cidade") on update restrict on delete restrict;

Alter table "fornecedores" add  foreign key ("codigo_cidade") references "cidades" ("codigo_cidade") on update restrict on delete set null;

Alter table "clientes" add  foreign key ("codigo_cidade") references "cidades" ("codigo_cidade") on update restrict on delete set null;

Alter table "empresa" add  foreign key ("codigo_cidade") references "cidades" ("codigo_cidade") on update restrict on delete set null;

Alter table "cidades" add  foreign key ("codigo_estado") references "estados" ("codigo_estado") on update restrict on delete cascade;

Alter table "bairros" add  foreign key ("codigo_estado") references "estados" ("codigo_estado") on update restrict on delete cascade;

Alter table "fornecedores" add  foreign key ("codigo_estado") references "estados" ("codigo_estado") on update restrict on delete set null;

Alter table "clientes" add  foreign key ("codigo_estado") references "estados" ("codigo_estado") on update restrict on delete set null;

Alter table "empresa" add  foreign key ("codigo_estado") references "estados" ("codigo_estado") on update restrict on delete set null;

Alter table "fornecedores" add  foreign key ("codigo_bairro") references "bairros" ("codigo_bairro") on update restrict on delete set null;

Alter table "clientes" add  foreign key ("codigo_bairro") references "bairros" ("codigo_bairro") on update restrict on delete set null;

Alter table "empresa" add  foreign key ("codigo_bairro") references "bairros" ("codigo_bairro") on update restrict on delete set null;

Alter table "orcamentos" add  foreign key ("codigo_cliente") references "clientes" ("codigo_cliente") on update restrict on delete restrict;

Alter table "vendas" add  foreign key ("codigo_cliente") references "clientes" ("codigo_cliente") on update restrict on delete restrict;

Alter table "itens_caracteristicas" add  foreign key ("codigo_caracteristica") references "caracteristicas" ("codigo_caracteristica") on update restrict on delete cascade;

Alter table "grupos" add  foreign key ("caracteristica_1") references "caracteristicas" ("codigo_caracteristica") on update restrict on delete restrict;

Alter table "grupos" add  foreign key ("caracteristica_2") references "caracteristicas" ("codigo_caracteristica") on update restrict on delete restrict;

Alter table "grupos" add  foreign key ("caracteristica_3") references "caracteristicas" ("codigo_caracteristica") on update restrict on delete restrict;

Alter table "produtos" add  foreign key ("codigo_caracteristica_1") references "itens_caracteristicas" ("codigo_item_caracteristica") on update restrict on delete set null;

Alter table "produtos" add  foreign key ("codigo_caracteristica_2") references "itens_caracteristicas" ("codigo_item_caracteristica") on update restrict on delete set null;

Alter table "produtos" add  foreign key ("codigo_caracteristica_3") references "itens_caracteristicas" ("codigo_item_caracteristica") on update restrict on delete set null;

Alter table "produtos_orcamentos" add  foreign key ("codigo_orcamento") references "orcamentos" ("codigo_orcamento") on update restrict on delete cascade;

Alter table "vendas" add  foreign key ("codigo_orcamento") references "orcamentos" ("codigo_orcamento") on update restrict on delete set null;

Alter table "produtos_compras" add  foreign key ("codigo_compra") references "compras" ("codigo_compra") on update restrict on delete cascade;

Alter table "estoque" add  foreign key ("codigo_produtos_compra","codigo_compra") references "produtos_compras" ("codigo_produtos_compra","codigo_compra") on update restrict on delete restrict;

Alter table "produtos_vendas" add  foreign key ("codigo_venda") references "vendas" ("codigo_venda") on update restrict on delete cascade;

Alter table "estoque" add  foreign key ("codigo_produtos_vendas","codigo_venda") references "produtos_vendas" ("codigo_produtos_vendas","codigo_venda") on update restrict on delete set null;

-- View: "v_produtos"

-- DROP VIEW v_produtos;

CREATE OR REPLACE VIEW v_produtos AS 
	SELECT 
		pro.codigo_produto, pro.descricao, pro.detalhe, pro.precounitario, pro.quantidade_minima, 
		pro.situacao, pro.codigo_grupo, pro.codigo_caracteristica_1, pro.codigo_caracteristica_2, pro.codigo_caracteristica_3, 
		pro.codigo_unidade, pro.saldo, uni.sigla AS unidade, gru.descricao AS descricao_grupo, 
		(ca1.descricao::text || ': '::text) || ic1.descricao::text AS car1, 
		(ca2.descricao::text || ': '::text) || ic2.descricao::text AS car2, 
		(ca3.descricao::text || ': '::text) || ic3.descricao::text AS car3
	FROM 
		produtos pro
	JOIN 
		unidades uni ON uni.codigo_unidade = pro.codigo_unidade
	JOIN 
		grupos gru ON gru.codigo_grupo = pro.codigo_grupo
	LEFT JOIN 
		caracteristicas ca1 ON ca1.codigo_caracteristica = gru.caracteristica_1
	LEFT JOIN 
		caracteristicas ca2 ON ca2.codigo_caracteristica = gru.caracteristica_2
	LEFT JOIN 
		caracteristicas ca3 ON ca3.codigo_caracteristica = gru.caracteristica_3
	LEFT JOIN 
		itens_caracteristicas ic1 ON ic1.codigo_item_caracteristica = pro.codigo_caracteristica_1
	LEFT JOIN 
		itens_caracteristicas ic2 ON ic2.codigo_item_caracteristica = pro.codigo_caracteristica_2
	LEFT JOIN 
		itens_caracteristicas ic3 ON ic3.codigo_item_caracteristica = pro.codigo_caracteristica_3
	ORDER BY 
		pro.descricao;

ALTER TABLE v_produtos OWNER TO postgres;
COMMENT ON VIEW v_produtos IS 'Visão detalhada de produtos';

-- View: "v_vendas"

-- DROP VIEW v_vendas;

CREATE OR REPLACE VIEW v_vendas AS 
SELECT  v.codigo_venda, c.nome AS nome_cliente, v.data_entrada, v.data_previsao_entrega, 
		v.data_entrega, v.situacao, v.tipo_servico, v.observacoes, v.codigo_cliente, 
		v.codigo_orcamento, SUM(p.quantidade * p.precounitario) AS total
FROM vendas v
LEFT JOIN produtos_vendas p ON p.codigo_venda = v.codigo_venda 
LEFT JOIN clientes c ON c.codigo_cliente = v.codigo_cliente 
GROUP BY v.codigo_venda, c.nome, v.data_entrada, v.data_previsao_entrega, v.data_entrega,
		 v.situacao, v.tipo_servico, v.observacoes, v.codigo_cliente, v.codigo_orcamento;

ALTER TABLE v_vendas OWNER TO postgres;
COMMENT ON VIEW v_vendas IS 'Vendas';

-- Check saldo do produto
ALTER TABLE produtos 
	ADD CONSTRAINT produtos_saldo_chk 
	CHECK (saldo >= 0);

	
-- View: "v_estoque"

-- DROP VIEW v_estoque;

CREATE OR REPLACE VIEW v_estoque AS 
 SELECT est.codigo_estoque, est.data_estoque, est.es, est.quantidade, est.precounitario, est.codigo_grupo, 
		est.codigo_produto, est.codigo_unidade, est.codigo_compra, est.codigo_produtos_compra, est.codigo_venda, 
		est.codigo_produtos_vendas, uni.descricao AS descricao_unidade, pro.descricao AS descricao_produto, 
		pro.codigo_caracteristica_1, pro.codigo_caracteristica_2, pro.codigo_caracteristica_3, 
		gru.descricao AS descricao_grupo, (ca1.descricao::text || ': '::text) || ic1.descricao::text AS car1, 
		(ca2.descricao::text || ': '::text) || ic2.descricao::text AS car2, 
		(ca3.descricao::text || ': '::text) || ic3.descricao::text AS car3
   FROM estoque est
   JOIN produtos pro ON pro.codigo_produto = est.codigo_produto
   JOIN unidades uni ON uni.codigo_unidade = pro.codigo_unidade
   JOIN grupos gru ON gru.codigo_grupo = pro.codigo_grupo
   LEFT JOIN caracteristicas ca1 ON ca1.codigo_caracteristica = gru.caracteristica_1
   LEFT JOIN caracteristicas ca2 ON ca2.codigo_caracteristica = gru.caracteristica_2
   LEFT JOIN caracteristicas ca3 ON ca3.codigo_caracteristica = gru.caracteristica_3
   LEFT JOIN itens_caracteristicas ic1 ON ic1.codigo_item_caracteristica = pro.codigo_caracteristica_1
   LEFT JOIN itens_caracteristicas ic2 ON ic2.codigo_item_caracteristica = pro.codigo_caracteristica_2
   LEFT JOIN itens_caracteristicas ic3 ON ic3.codigo_item_caracteristica = pro.codigo_caracteristica_3;

ALTER TABLE v_estoque OWNER TO postgres;
COMMENT ON VIEW v_estoque IS 'Visão do estoque';

-- View: "v_produtos_vendas"

-- DROP VIEW v_produtos_vendas;

CREATE OR REPLACE VIEW v_produtos_vendas AS 
 SELECT pve.codigo_produtos_vendas, pve.quantidade, pve.quantidade_entregue, pve.precounitario, pve.situacao, 
		pve.codigo_venda, pve.codigo_grupo, pve.codigo_produto, pve.codigo_unidade, pro.descricao, 
		uni.sigla AS unidade, pve.quantidade * pve.precounitario AS total, pro.codigo_caracteristica_1, 
		pro.codigo_caracteristica_2, pro.codigo_caracteristica_3, gru.descricao AS descricao_grupo, 
		(ca1.descricao::text || ': '::text) || ic1.descricao::text AS car1, 
		(ca2.descricao::text || ': '::text) || ic2.descricao::text AS car2, 
		(ca3.descricao::text || ': '::text) || ic3.descricao::text AS car3
   FROM produtos_vendas pve
   JOIN produtos pro ON pro.codigo_produto = pve.codigo_produto
   JOIN unidades uni ON uni.codigo_unidade = pve.codigo_unidade
   JOIN grupos gru ON gru.codigo_grupo = pve.codigo_grupo
   LEFT JOIN caracteristicas ca1 ON ca1.codigo_caracteristica = gru.caracteristica_1
   LEFT JOIN caracteristicas ca2 ON ca2.codigo_caracteristica = gru.caracteristica_2
   LEFT JOIN caracteristicas ca3 ON ca3.codigo_caracteristica = gru.caracteristica_3
   LEFT JOIN itens_caracteristicas ic1 ON ic1.codigo_item_caracteristica = pro.codigo_caracteristica_1
   LEFT JOIN itens_caracteristicas ic2 ON ic2.codigo_item_caracteristica = pro.codigo_caracteristica_2
   LEFT JOIN itens_caracteristicas ic3 ON ic3.codigo_item_caracteristica = pro.codigo_caracteristica_3
  ORDER BY pve.codigo_venda, pve.codigo_produtos_vendas;

ALTER TABLE v_produtos_vendas OWNER TO postgres;
COMMENT ON VIEW v_produtos_vendas IS 'Visão produtos da venda';
