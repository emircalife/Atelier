/*
Created		15/12/2008
Modified		20/02/2009
Project		Atelier D. Maria
Model		ER
Company		MEGs
Author		Márcio Las
Version		0.1.0
Database		mySQL 5 
*/

Create table `estoque` (
	`codigo_estoque` MEDIUMINT NOT NULL AUTO_INCREMENT COMMENT 'Código identificador da movimentação de estoque',
	`data_estoque` Date NOT NULL COMMENT 'Data em que ocorreu a movimentação do estoque',
	`es` Char(1) NOT NULL DEFAULT 'E' COMMENT 'Identifica se foi uma entrada (E) ou saída (S) do produto no estoque',
	`quantidade` Double NOT NULL COMMENT 'Quantidade do produto em estoque',
	`precounitario` Double NOT NULL COMMENT 'Preço unitário do produto na movimentação',
	`codigo_grupo` Int NOT NULL COMMENT 'Código do grupo de produtos',
	`codigo_produto` Int NOT NULL COMMENT 'Código do produto',
	`codigo_unidade` Int NOT NULL COMMENT 'Código da unidade do produto',
	`codigo_compra` Int COMMENT 'Código da compra (ES=E)',
	`codigo_produtos_compra` Int COMMENT 'Sequencial do produto na compra (ES=E)',
	`codigo_venda` Int COMMENT 'Código da venda (ES=S)',
	`codigo_produtos_vendas` Int COMMENT 'Sequencial do produto na venda (ES=S)',
 Primary Key (`codigo_estoque`,`codigo_grupo`,`codigo_produto`)) ENGINE = InnoDB
COMMENT = 'Controle de entrada/saída de produtos';

Create table `produtos` (
	`codigo_produto` MEDIUMINT NOT NULL AUTO_INCREMENT COMMENT 'Código identificador do produto',
	`descricao` Varchar(100) NOT NULL COMMENT 'Descrição do produto',
	`detalhe` Varbinary(20) COMMENT 'Detalhes do produto',
	`precounitario` Double COMMENT 'Preço unitário do produto',
	`quantidade_minima` Double COMMENT 'Quantidade mínima no estoque',
	`saldo` Double DEFAULT 0 COMMENT 'Saldo',
	`situacao` Char(1) NOT NULL DEFAULT 'A' COMMENT 'Situação do produto: A = ativo ou I = inativo',
	`codigo_grupo` Int NOT NULL COMMENT 'Código do grupo',
	`codigo_caracteristica_1` Int COMMENT 'Código da segunda característica',
	`codigo_caracteristica_2` Int COMMENT 'Código da ssegunda característica',
	`codigo_caracteristica_3` Int COMMENT 'Código da terceira caracteristica',
	`codigo_unidade` Int NOT NULL COMMENT 'Código da unidade',
	UNIQUE (`descricao`),
 Primary Key (`codigo_produto`,`codigo_grupo`)) ENGINE = InnoDB
COMMENT = 'Cadastro de produtos';

Create table `grupos` (
	`codigo_grupo` MEDIUMINT NOT NULL AUTO_INCREMENT COMMENT 'Código do grupo',
	`descricao` Char(30) NOT NULL COMMENT 'Descrição do grupo',
	`caracteristica_1` Int COMMENT 'Característica 1',
	`caracteristica_2` Int COMMENT 'Característica 2',
	`caracteristica_3` Int COMMENT 'Característica 3',
	UNIQUE (`descricao`),
 Primary Key (`codigo_grupo`)) ENGINE = InnoDB
COMMENT = 'Cadastro de grupos de materiais';

Create table `unidades` (
	`codigo_unidade` MEDIUMINT NOT NULL AUTO_INCREMENT COMMENT 'Código da unidade',
	`sigla` Varchar(6) NOT NULL COMMENT 'Sigla da unidade',
	`descricao` Varchar(30) NOT NULL COMMENT 'Descrição da unidade',
	UNIQUE (`sigla`),
	UNIQUE (`descricao`),
 Primary Key (`codigo_unidade`)) ENGINE = InnoDB
COMMENT = 'Cadastro de unidades do sistema';

Create table `fornecedores` (
	`codigo_fornecedor` MEDIUMINT NOT NULL AUTO_INCREMENT COMMENT 'Código do fornecedor',
	`nome` Varchar(60) NOT NULL COMMENT 'Nome do fornecedor',
	`cpfcnpj` Varchar(14) COMMENT 'Número do CNPJ',
	`contato` Varchar(30) COMMENT 'Nome do contato',
	`endereco` Varchar(60) COMMENT 'Endereço',
	`numero` Varchar(10) COMMENT 'Número',
	`complemento` Varchar(60) COMMENT 'Complemento do endereço',
	`cep` Varchar(20) COMMENT 'CEP',
	`referencia` Varchar(254) COMMENT 'Ponto de referência',
	`email` Varchar(254) COMMENT 'Endereço eletrônico (e-mail)',
	`telefone` Varchar(15) COMMENT 'Número do telefone',
	`fax` Varchar(15) COMMENT 'Número do fax',
	`celular` Varchar(15) COMMENT 'Número do celular',
	`website` Varchar(254) COMMENT 'Site na internet (www)',
	`situacao` Char(1) NOT NULL DEFAULT 'A' COMMENT 'Situação do fornecedor: A = ativo ou I = inativo',
	`codigo_bairro` Int COMMENT 'Código do bairro',
	`codigo_cidade` Int COMMENT 'Código da cidade',
	`codigo_estado` Int COMMENT 'Código do estado',
	UNIQUE (`nome`),
 Primary Key (`codigo_fornecedor`)) ENGINE = InnoDB
COMMENT = 'Cadastro de fornecedores';

Create table `cidades` (
	`codigo_cidade` MEDIUMINT NOT NULL AUTO_INCREMENT COMMENT 'Código da cidade',
	`descricao` Varchar(60) NOT NULL COMMENT 'Nome descritivo da cidade',
	`codigo_estado` Int NOT NULL COMMENT 'Código do estado',
	UNIQUE (`codigo_cidade`),
 Primary Key (`codigo_cidade`)) ENGINE = InnoDB
COMMENT = 'Cadastro de cidades';

Create table `estados` (
	`codigo_estado` MEDIUMINT NOT NULL AUTO_INCREMENT COMMENT 'Código identificador do estado',
	`descricao` Varchar(60) NOT NULL COMMENT 'Nome descritivo do estado',
	`sigla` Char(2) NOT NULL COMMENT 'Sigla do estado',
	UNIQUE (`codigo_estado`),
	UNIQUE (`descricao`),
	UNIQUE (`sigla`),
 Primary Key (`codigo_estado`)) ENGINE = InnoDB
COMMENT = 'Cadastro de estados';

Create table `bairros` (
	`codigo_bairro` MEDIUMINT NOT NULL AUTO_INCREMENT COMMENT 'Código identificador do bairro',
	`descricao` Varchar(60) NOT NULL COMMENT 'Nome descritivo do bairro',
	`codigo_cidade` Int NOT NULL COMMENT 'Código da cidade',
	`codigo_estado` Int NOT NULL COMMENT 'Código do estado',
	UNIQUE (`codigo_bairro`),
 Primary Key (`codigo_bairro`)) ENGINE = InnoDB
COMMENT = 'Cadastro de bairros';

Create table `fornecedores_produtos` (
	`codigo_fornecedor` Int NOT NULL COMMENT 'Código do fornecedor',
	`codigo_produto` Int NOT NULL COMMENT 'Código do produto',
	`codigo_grupo` Int NOT NULL COMMENT 'Código do grupo de produtos',
 Primary Key (`codigo_fornecedor`,`codigo_produto`,`codigo_grupo`)) ENGINE = InnoDB
COMMENT = 'Produtos fornecedos pelos fornecedores';

Create table `clientes` (
	`codigo_cliente` MEDIUMINT NOT NULL AUTO_INCREMENT COMMENT 'Código do cliente',
	`nome` Varchar(60) NOT NULL COMMENT 'Nome do cliente',
	`cpfcnpj` Varchar(14) COMMENT 'Número do CNPJ',
	`contato` Varchar(30) COMMENT 'Nome do contato',
	`endereco` Varchar(60) COMMENT 'Endereço',
	`numero` Varchar(10) COMMENT 'Número',
	`complemento` Varchar(60) COMMENT 'Complemento do endereço',
	`cep` Varchar(20) COMMENT 'CEP',
	`referencia` Varchar(254) COMMENT 'Ponto de referência',
	`email` Varchar(254) COMMENT 'Endereço eletrônico (e-mail)',
	`telefone` Varchar(15) COMMENT 'Número do telefone',
	`fax` Varchar(15) COMMENT 'Número do fax',
	`celular` Varchar(15) COMMENT 'Número do celular',
	`website` Varchar(254) COMMENT 'Site na internet (www)',
	`situacao` Char(1) NOT NULL DEFAULT 'A' COMMENT 'Situação do cliente: A = ativo ou I = inativo',
	`codigo_bairro` Int COMMENT 'Código do bairro',
	`codigo_cidade` Int COMMENT 'Código da cidade',
	`codigo_estado` Int COMMENT 'Código do estado',
	UNIQUE (`nome`),
 Primary Key (`codigo_cliente`)) ENGINE = InnoDB
COMMENT = 'Cadastro de clientes';

Create table `caracteristicas` (
	`codigo_caracteristica` MEDIUMINT NOT NULL AUTO_INCREMENT COMMENT 'Código da característica',
	`descricao` Varchar(30) NOT NULL COMMENT 'Descrição da caracterísica',
	UNIQUE (`descricao`),
 Primary Key (`codigo_caracteristica`)) ENGINE = InnoDB;

Create table `itens_caracteristicas` (
	`codigo_item_caracteristica` MEDIUMINT NOT NULL AUTO_INCREMENT COMMENT 'Código do item da característica',
	`descricao` Varchar(30) NOT NULL COMMENT 'Descrição do item da característica',
	`resumo` Varchar(15) NOT NULL COMMENT 'Resumo do item da característica',
	`codigo_caracteristica` Int NOT NULL COMMENT 'Código da característica',
	UNIQUE (`descricao`),
	UNIQUE (`resumo`),
 Primary Key (`codigo_item_caracteristica`)) ENGINE = InnoDB;

Create table `orcamentos` (
	`codigo_orcamento` MEDIUMINT NOT NULL AUTO_INCREMENT COMMENT 'Código do orçamento',
	`data_orcamento` Date NOT NULL COMMENT 'Data do orçamento',
	`observacoes` Varbinary(20) COMMENT 'Observações gerais',
	`situacao` Char(1) NOT NULL DEFAULT 'A' COMMENT 'Situação do orçamento: A = aberto, F = fechado ou N = nulo',
	`tipo_servico` Char(1) NOT NULL DEFAULT 'N' COMMENT 'Tipo de serviço: N = novo ou R = reparo',
	`codigo_cliente` Int NOT NULL COMMENT 'Código do cliente',
 Primary Key (`codigo_orcamento`)) ENGINE = InnoDB;

Create table `produtos_orcamentos` (
	`codigo_produtos_orcamentos` MEDIUMINT NOT NULL AUTO_INCREMENT COMMENT 'Código sequencial do produto no orçamento',
	`quantidade` Double NOT NULL COMMENT 'Quantidade do produto',
	`precounitario` Double NOT NULL COMMENT 'Preço unitário do produto',
	`codigo_orcamento` Int NOT NULL COMMENT 'Código do orçamento',
	`codigo_grupo` Int NOT NULL COMMENT 'Código do grupo de produtos',
	`codigo_produto` Int NOT NULL COMMENT 'Código do produto',
	`codigo_unidade` Int NOT NULL COMMENT 'Código da unidade',
 Primary Key (`codigo_produtos_orcamentos`,`codigo_orcamento`)) ENGINE = InnoDB
COMMENT = 'Produtos do orçamento';

Create table `compras` (
	`codigo_compra` MEDIUMINT NOT NULL AUTO_INCREMENT COMMENT 'Código da compra',
	`data_compra` Date NOT NULL COMMENT 'Data da compra',
	`situacao` Char(1) NOT NULL DEFAULT 'A' COMMENT 'Situação da compra: A = aberta, N = nula ou F = fechada',
	`observacoes` Varbinary(20) COMMENT 'Observações gerais',
	`codigo_fornecedor` Int NOT NULL COMMENT 'Código do fornecedor',
 Primary Key (`codigo_compra`)) ENGINE = InnoDB;

Create table `produtos_compras` (
	`codigo_produtos_compra` MEDIUMINT NOT NULL AUTO_INCREMENT COMMENT 'Código sequencial do produto na compra',
	`quantidade` Double NOT NULL COMMENT 'Quantidade comprada do produto',
	`precounitario` Double NOT NULL COMMENT 'Preco do produto comprado',
	`codigo_compra` Int NOT NULL COMMENT 'Código da compra',
	`codigo_grupo` Int NOT NULL COMMENT 'Código do grupo de produtos',
	`codigo_produto` Int NOT NULL COMMENT 'Código do produto',
	`codigo_unidade` Int NOT NULL COMMENT 'Código da unidade',
 Primary Key (`codigo_produtos_compra`,`codigo_compra`)) ENGINE = InnoDB
COMMENT = 'Produtos da compra';

Create table `vendas` (
	`codigo_venda` MEDIUMINT NOT NULL AUTO_INCREMENT COMMENT 'Código da venda',
	`data_entrada` Date NOT NULL COMMENT 'Data de entrada da venda',
	`data_previsao_entrega` Date NOT NULL COMMENT 'Data de previsão da entrega',
	`data_entrega` Date COMMENT 'Data da entrega',
	`situacao` Char(1) NOT NULL DEFAULT 'A' COMMENT 'Situação da venda: A = aberta, N = nula, P = parcialmente atendida ou F = fechada',
	`tipo_servico` Char(1) NOT NULL DEFAULT 'N' COMMENT 'Tipo de serviço: N = novo ou R = reparo',
	`observacoes` Varbinary(20) COMMENT 'Observações gerais',
	`codigo_cliente` Int NOT NULL COMMENT 'Código do cliente',
	`codigo_orcamento` Int COMMENT 'Código do orçamento',
 Primary Key (`codigo_venda`)) ENGINE = InnoDB
COMMENT = 'Cadastro de vendas';

Create table `produtos_vendas` (
	`codigo_produtos_vendas` MEDIUMINT NOT NULL AUTO_INCREMENT COMMENT 'Código sequencial do produto na venda',
	`quantidade` Double NOT NULL COMMENT 'Quantidade vendida do produto',
	`quantidade_entregue` Double COMMENT 'Quantidade que já foi entregue do produto',
	`precounitario` Double NOT NULL COMMENT 'Preço vendido do produto',
	`situacao` Char(1) NOT NULL DEFAULT 'A' COMMENT 'Situação da venda: A = aberto, N = nulo, P = parcialmente atendido ou F = fechado',
	`codigo_venda` Int NOT NULL COMMENT 'Código da venda',
	`codigo_grupo` Int NOT NULL COMMENT 'Código do grupo de produtos',
	`codigo_produto` Int NOT NULL COMMENT 'Código do produto',
	`codigo_unidade` Int NOT NULL COMMENT 'Código da unidade',
 Primary Key (`codigo_produtos_vendas`,`codigo_venda`)) ENGINE = InnoDB
COMMENT = 'Produtos vendidos';

Create table `empresa` (
	`codigo` MEDIUMINT NOT NULL AUTO_INCREMENT COMMENT 'Código da empresa',
	`codigo_estado` Int,
	`codigo_bairro` Int,
	`codigo_cidade` Int,
	`nome` Varchar(60) COMMENT 'Nome da empresa',
	`cpfcnpj` Varchar(14) COMMENT 'Número do cpf ou cnpj',
	`inscricao_municipal` Varchar(15) COMMENT 'Inscrição municipal',
	`inscricao_estadual` Varchar(15) COMMENT 'Inscrição estadual',
	`responsavel` Varchar(60) COMMENT 'Nome do responsável pela empresa',
	`contato` Varchar(60) COMMENT 'Nome do contato na empresa',
	`endereco` Varchar(60) COMMENT 'Endereço',
	`numero` Varchar(10) COMMENT 'Número do estabelecimento',
	`telefone` Varchar(15) COMMENT 'Número do telefone fixo',
	`fax` Varchar(15) COMMENT 'Número do fax',
	`email` Varchar(254) COMMENT 'Endereço eletrônico (e-mail)',
	`website` Varchar(254) COMMENT 'Site (www)',
	`servidor_smtp` Varchar(60) COMMENT 'Servidor de e-mail SMTP',
	`logotipo` Bool COMMENT 'Logotipo da empresa',
	`observacoes` Varbinary(20) COMMENT 'Observações gerais',
 Primary Key (`codigo`)) ENGINE = InnoDB
COMMENT = 'Cadastro da empresa e parâmetros do sistema';


Create Index `estoque_data_idx` ON `estoque` (`data_estoque`);
Create Index `cidades_descricao_idx` ON `cidades` (`descricao`);
Create Index `estados_descricao_idx` ON `estados` (`descricao`);
Create Index `bairros_descricao_idx` ON `bairros` (`descricao`);
Create Index `caracteristica_descricao_idx` ON `caracteristicas` (`descricao`);


Alter table `estoque` add Foreign Key (`codigo_produto`,`codigo_grupo`) references `produtos` (`codigo_produto`,`codigo_grupo`) on delete  restrict on update  restrict;
Alter table `fornecedores_produtos` add Foreign Key (`codigo_produto`,`codigo_grupo`) references `produtos` (`codigo_produto`,`codigo_grupo`) on delete cascade on update  restrict;
Alter table `produtos_orcamentos` add Foreign Key (`codigo_produto`,`codigo_grupo`) references `produtos` (`codigo_produto`,`codigo_grupo`) on delete  restrict on update  restrict;
Alter table `produtos_compras` add Foreign Key (`codigo_produto`,`codigo_grupo`) references `produtos` (`codigo_produto`,`codigo_grupo`) on delete  restrict on update  restrict;
Alter table `produtos_vendas` add Foreign Key (`codigo_produto`,`codigo_grupo`) references `produtos` (`codigo_produto`,`codigo_grupo`) on delete  restrict on update  restrict;
Alter table `produtos` add Foreign Key (`codigo_grupo`) references `grupos` (`codigo_grupo`) on delete  restrict on update  restrict;
Alter table `produtos` add Foreign Key (`codigo_unidade`) references `unidades` (`codigo_unidade`) on delete  restrict on update  restrict;
Alter table `estoque` add Foreign Key (`codigo_unidade`) references `unidades` (`codigo_unidade`) on delete  restrict on update  restrict;
Alter table `produtos_orcamentos` add Foreign Key (`codigo_unidade`) references `unidades` (`codigo_unidade`) on delete  restrict on update  restrict;
Alter table `produtos_compras` add Foreign Key (`codigo_unidade`) references `unidades` (`codigo_unidade`) on delete  restrict on update  restrict;
Alter table `produtos_vendas` add Foreign Key (`codigo_unidade`) references `unidades` (`codigo_unidade`) on delete  restrict on update  restrict;
Alter table `fornecedores_produtos` add Foreign Key (`codigo_fornecedor`) references `fornecedores` (`codigo_fornecedor`) on delete cascade on update  restrict;
Alter table `compras` add Foreign Key (`codigo_fornecedor`) references `fornecedores` (`codigo_fornecedor`) on delete  restrict on update  restrict;
Alter table `bairros` add Foreign Key (`codigo_cidade`) references `cidades` (`codigo_cidade`) on delete  restrict on update  restrict;
Alter table `fornecedores` add Foreign Key (`codigo_cidade`) references `cidades` (`codigo_cidade`) on delete set null on update  restrict;
Alter table `clientes` add Foreign Key (`codigo_cidade`) references `cidades` (`codigo_cidade`) on delete set null on update  restrict;
Alter table `empresa` add Foreign Key (`codigo_cidade`) references `cidades` (`codigo_cidade`) on delete set null on update  restrict;
Alter table `cidades` add Foreign Key (`codigo_estado`) references `estados` (`codigo_estado`) on delete cascade on update  restrict;
Alter table `bairros` add Foreign Key (`codigo_estado`) references `estados` (`codigo_estado`) on delete cascade on update  restrict;
Alter table `fornecedores` add Foreign Key (`codigo_estado`) references `estados` (`codigo_estado`) on delete set null on update  restrict;
Alter table `clientes` add Foreign Key (`codigo_estado`) references `estados` (`codigo_estado`) on delete set null on update  restrict;
Alter table `empresa` add Foreign Key (`codigo_estado`) references `estados` (`codigo_estado`) on delete set null on update  restrict;
Alter table `fornecedores` add Foreign Key (`codigo_bairro`) references `bairros` (`codigo_bairro`) on delete set null on update  restrict;
Alter table `clientes` add Foreign Key (`codigo_bairro`) references `bairros` (`codigo_bairro`) on delete set null on update  restrict;
Alter table `empresa` add Foreign Key (`codigo_bairro`) references `bairros` (`codigo_bairro`) on delete set null on update  restrict;
Alter table `orcamentos` add Foreign Key (`codigo_cliente`) references `clientes` (`codigo_cliente`) on delete  restrict on update  restrict;
Alter table `vendas` add Foreign Key (`codigo_cliente`) references `clientes` (`codigo_cliente`) on delete  restrict on update  restrict;
Alter table `itens_caracteristicas` add Foreign Key (`codigo_caracteristica`) references `caracteristicas` (`codigo_caracteristica`) on delete cascade on update  restrict;
Alter table `grupos` add Foreign Key (`caracteristica_1`) references `caracteristicas` (`codigo_caracteristica`) on delete  restrict on update  restrict;
Alter table `grupos` add Foreign Key (`caracteristica_2`) references `caracteristicas` (`codigo_caracteristica`) on delete  restrict on update  restrict;
Alter table `grupos` add Foreign Key (`caracteristica_3`) references `caracteristicas` (`codigo_caracteristica`) on delete  restrict on update  restrict;
Alter table `produtos` add Foreign Key (`codigo_caracteristica_1`) references `itens_caracteristicas` (`codigo_item_caracteristica`) on delete set null on update  restrict;
Alter table `produtos` add Foreign Key (`codigo_caracteristica_2`) references `itens_caracteristicas` (`codigo_item_caracteristica`) on delete set null on update  restrict;
Alter table `produtos` add Foreign Key (`codigo_caracteristica_3`) references `itens_caracteristicas` (`codigo_item_caracteristica`) on delete set null on update  restrict;
Alter table `produtos_orcamentos` add Foreign Key (`codigo_orcamento`) references `orcamentos` (`codigo_orcamento`) on delete cascade on update  restrict;
Alter table `vendas` add Foreign Key (`codigo_orcamento`) references `orcamentos` (`codigo_orcamento`) on delete set null on update  restrict;
Alter table `produtos_compras` add Foreign Key (`codigo_compra`) references `compras` (`codigo_compra`) on delete cascade on update  restrict;
Alter table `estoque` add Foreign Key (`codigo_produtos_compra`,`codigo_compra`) references `produtos_compras` (`codigo_produtos_compra`,`codigo_compra`) on delete  restrict on update  restrict;
Alter table `produtos_vendas` add Foreign Key (`codigo_venda`) references `vendas` (`codigo_venda`) on delete cascade on update  restrict;
Alter table `estoque` add Foreign Key (`codigo_produtos_vendas`,`codigo_venda`) references `produtos_vendas` (`codigo_produtos_vendas`,`codigo_venda`) on delete set null on update  restrict;
