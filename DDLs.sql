-- Create table
create table CARTOES.TB_ARQUIVO_CONTROLE
(
  idarquivo_controle   RAW(16) default SYS_GUID() not null,
  nrarquivo            NUMBER(2) not null,
  dtalteracao          DATE,
  nrsequencial_arquivo NUMBER(10),
  dsdiretorio_arquivo  VARCHAR2(50),
  dhregistro           DATE default SYSDATE not null
)
tablespace TBS_CARTOES_D
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  )
compress for all operations;
-- Add comments to the table 
comment on table CARTOES.TB_ARQUIVO_CONTROLE
  is 'Proposito: Tabela de Controle para Arquivos de Integração do produto CARTAO. Finalidade: Tabela para armazenar parametros utilizados na integracao de arquivos com o parceiro, como diretorios utilizados e sequencial do arquivo. Volumetria: Inicial de 4 registros, com 0% ao mes. Politica de Expurgo: Nao se aplica.';
-- Add comments to the columns 
comment on column CARTOES.TB_ARQUIVO_CONTROLE.idarquivo_controle
  is 'Código único do Controle do Arquivo utilizado como Chave Primaria. #CLASSIFICACAO_DADO: I';
comment on column CARTOES.TB_ARQUIVO_CONTROLE.nrarquivo
  is 'Tipo do arquivo (Tabela de dominio = TB_DOMINIO_CAMPO). #CLASSIFICACAO_DADO: I';
comment on column CARTOES.TB_ARQUIVO_CONTROLE.dtalteracao
  is 'Data da Última alteração. #CLASSIFICACAO_DADO: I';
comment on column CARTOES.TB_ARQUIVO_CONTROLE.nrsequencial_arquivo
  is 'Número do último sequencial do arquivo. #CLASSIFICACAO_DADO: I';
comment on column CARTOES.TB_ARQUIVO_CONTROLE.dsdiretorio_arquivo
  is 'Caminho do diretório do arquivo. #CLASSIFICACAO_DADO: I';
comment on column CARTOES.TB_ARQUIVO_CONTROLE.dhregistro
  is 'Data/Hora de inclusao do registro. #CLASSIFICACAO_DADO: I';
-- Create/Recreate indexes 
create unique index CARTOES.TB_ARQUIVO_CONTROLE_NEW_PK on CARTOES.TB_ARQUIVO_CONTROLE (IDARQUIVO_CONTROLE)
  tablespace TBS_CARTOES_I
  pctfree 10
  initrans 2
  maxtrans 255
  storage   
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create unique index CARTOES.TB_ARQUIVO_CONTROLE_NEW_UK1 on CARTOES.TB_ARQUIVO_CONTROLE (NRARQUIVO)
  tablespace TBS_CARTOES_I
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Create/Recreate primary, unique and foreign key constraints 
alter table CARTOES.TB_ARQUIVO_CONTROLE
  add constraint TB_ARQUIVO_CONTROLE_PK primary key (IDARQUIVO_CONTROLE);
alter table CARTOES.TB_ARQUIVO_CONTROLE
  add constraint TB_ARQUIVO_CONTROLE_UK1 unique (NRARQUIVO);
-- Create/Recreate check constraints 
alter table CARTOES.TB_ARQUIVO_CONTROLE
  add constraint TB_ARQUIVO_CONTROLE_CK1
  check (NRARQUIVO BETWEEN 1 AND 99);

insert into CARTOES.TB_ARQUIVO_CONTROLE (IDARQUIVO_CONTROLE, NRARQUIVO, DTALTERACAO, NRSEQUENCIAL_ARQUIVO, DSDIRETORIO_ARQUIVO, DHREGISTRO)
values ('FF95CEC4CE732F48E0530100007FBDE5', 2, SYSDATE, 3731, '/temp', SYSDATE);
insert into CARTOES.TB_ARQUIVO_CONTROLE (IDARQUIVO_CONTROLE, NRARQUIVO, DTALTERACAO, NRSEQUENCIAL_ARQUIVO, DSDIRETORIO_ARQUIVO, DHREGISTRO)
values ('FF95CEC4D31A2F48E0530100007FBDE5', 3, SYSDATE, 3131, '/recebe', SYSDATE);
commit;

-- Create table
create table CARTOES.TB_ARQUIVO
(
  IDARQUIVO          RAW(16) default SYS_GUID() not null,
  idarquivo_controle RAW(16) not null,
  nmarquivo          VARCHAR2(256) not null,
  dtarquivo          DATE,
  dtinicio_processo  DATE,
  dtfim_processo     DATE,
  qtregistro_arquivo NUMBER(10),
  vltotal            NUMBER(13,2),
  dhregistro         DATE default SYSDATE not null
)
tablespace TBS_CARTOES_D
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  )
compress for all operations;
-- Add comments to the table 
comment on table CARTOES.TB_ARQUIVO
  is 'Proposito: Tabela para armazenar Arquivos de Integração do produto CARTAO que foram importados. Finalidade: Tabela para controle de arquivos gerados para os parceiros ou arquivos recebidos de parceiros e processados. Volumetria: Inicial de 10 registros, com taxa de 1% ao mes. uma media de 11.000 registros novos ao mes. Politica de Expurgo: Nao se aplica.';
-- Add comments to the columns 
comment on column CARTOES.TB_ARQUIVO.idarquivo
  is 'Código único do arquivo utilizado como Chave Primaria. #CLASSIFICACAO_DADO: I';
comment on column CARTOES.TB_ARQUIVO.idarquivo_controle
  is 'Código único do Controle do Arquivo utilizado como Chave Estrangeira com a tabela TB_ARQUIVO_CONTROLE_NEW. #CLASSIFICACAO_DADO: I';
comment on column CARTOES.TB_ARQUIVO.nmarquivo
  is 'Nome do arquivo. #CLASSIFICACAO_DADO: I';
comment on column CARTOES.TB_ARQUIVO.dtarquivo
  is 'Data do arquivo. #CLASSIFICACAO_DADO: I';
comment on column CARTOES.TB_ARQUIVO.dtinicio_processo
  is 'Data Início do Processamento. #CLASSIFICACAO_DADO: I';
comment on column CARTOES.TB_ARQUIVO.dtfim_processo
  is 'Data Fim do Processamento. #CLASSIFICACAO_DADO: I';
comment on column CARTOES.TB_ARQUIVO.qtregistro_arquivo
  is 'Quantidade de Registros processados do arquivo. #CLASSIFICACAO_DADO: I';
comment on column CARTOES.TB_ARQUIVO.vltotal
  is 'Valor Total dos registros processados do arquivo. #CLASSIFICACAO_DADO: I';
comment on column CARTOES.TB_ARQUIVO.dhregistro
  is 'Data/Hora de inclusao do registro. #CLASSIFICACAO_DADO: I';
-- Create/Recreate indexes 
create unique index CARTOES.TB_ARQUIVO_NEW_PK on CARTOES.TB_ARQUIVO (IDARQUIVO)
  tablespace TBS_CARTOES_I
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Create/Recreate primary, unique and foreign key constraints 
alter table CARTOES.TB_ARQUIVO
  add constraint TB_ARQUIVO_PK primary key (IDARQUIVO);
alter table CARTOES.TB_ARQUIVO
  add constraint TB_ARQUIVO_FK1 foreign key (IDARQUIVO_CONTROLE)
  references CARTOES.TB_ARQUIVO_CONTROLE (IDARQUIVO_CONTROLE);
-- Grant/Revoke object privileges 
grant select, insert, update, delete on CARTOES.TB_ARQUIVO to RILAKECARTOES;


-- Create table
create table CARTOES.TB_CARTAO
(
  idcartao             RAW(16) default SYS_GUID() not null,
  idcartao_proposta    RAW(16) not null,
  idconta_cartao       RAW(16) not null,
  nrcartao             NUMBER(16) not null,
  dtvalidade           DATE,
  nrdia_debito         NUMBER(2),
  tppagamento          NUMBER(1),
  cdsituacao           NUMBER(1) not null,
  dtentrega            DATE,
  dtcancelamento       DATE,
  cdmotivo             NUMBER(2),
  cdoperador_inclusao  VARCHAR2(10) not null,
  dhregistro           DATE default SYSDATE not null,
  cdoperador_alteracao VARCHAR2(10),
  dhalteracao          DATE,
  idcomponente         NUMBER(25)
)
tablespace TBS_CARTOES_D
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  )
compress for all operations;
-- Add comments to the table 
comment on table CARTOES.TB_CARTAO
  is 'Proposito: Tabela de cartao do produto CARTAO. Finalidade: Tabela com o objetivo de amarzenar todos os cartoes solicitados para cooperados, indepente do status. Principal tabela para que o cooperado consiga efetuar a utilizacao do seu cartao. Volumetria: Incio dom 12 registros, com uma media de 11.000 registros novos ao mes. Politica de Expurgo: Nao se aplica.';
-- Add comments to the columns 
comment on column CARTOES.TB_CARTAO.idcartao
  is 'Codigo unico de cartao utilizado como Chave Primaria. #CLASSIFICACAO_DADO: I';
comment on column CARTOES.TB_CARTAO.idcartao_proposta
  is 'Codigo unico de proposta cartao, Chave Estrangeira com a tabela CARTOES.TB_CARTAO_PROPOSTA. #CLASSIFICACAO_DADO: I';
comment on column CARTOES.TB_CARTAO.idconta_cartao
  is 'Codigo unico de conta cartao, Chave Estrangeira com a tabela CARTOES.TB_CONTA_CARTAO. #CLASSIFICACAO_DADO: I';
comment on column CARTOES.TB_CARTAO.nrcartao
  is 'Numero do cartao do cooperado. #CLASSIFICACAO_DADO: C';
comment on column CARTOES.TB_CARTAO.dtvalidade
  is 'Data de validade do cartao. #CLASSIFICACAO_DADO: C';
comment on column CARTOES.TB_CARTAO.nrdia_debito
  is 'Dia de debito do cartao. #CLASSIFICACAO_DADO: C';
comment on column CARTOES.TB_CARTAO.tppagamento
  is 'Codigo de tipo de pagamento da fatura (Tabela de dominio = TB_DOMINIO_CAMPO): 1-Boleto. #CLASSIFICACAO_DADO: C';
comment on column CARTOES.TB_CARTAO.cdsituacao
  is 'Flag de status do cartao (Tabela de dominio = TB_DOMINIO_CAMPO):1-Solicitado, 2-Liberado, 3-Ativo, 4-Cancelado, 5-Bloqueado. #CLASSIFICACAO_DADO: C';
comment on column CARTOES.TB_CARTAO.dtentrega
  is 'Data de entrega do cartao. #CLASSIFICACAO_DADO: C';
comment on column CARTOES.TB_CARTAO.dtcancelamento
  is 'Data de cancelamento do cartao. #CLASSIFICACAO_DADO: C';
comment on column CARTOES.TB_CARTAO.cdmotivo
  is 'Codigo de motivo de cancelamento do cartao (Tabela de dominio = TB_DOMINIO_CAMPO). #CLASSIFICACAO_DADO: C';
comment on column CARTOES.TB_CARTAO.cdoperador_inclusao
  is 'Codigo do operador de inclusao do registro. #CLASSIFICACAO_DADO: I';
comment on column CARTOES.TB_CARTAO.dhregistro
  is 'Data/Hora de registro na base de dados. #CLASSIFICACAO_DADO: I';
comment on column CARTOES.TB_CARTAO.cdoperador_alteracao
  is 'Codigo do operador da ultima alteracao do registro. #CLASSIFICACAO_DADO: I';
comment on column CARTOES.TB_CARTAO.dhalteracao
  is 'Data/Hora da ultima alteracao do registro. #CLASSIFICACAO_DADO: I';
comment on column CARTOES.TB_CARTAO.idcomponente
  is 'Identificador do cartao no Sicoob. #CLASSIFICACAO_DADO: I';
-- Create/Recreate indexes 
create unique index CARTOES.TB_CARTAO_NEW_PK on CARTOES.TB_CARTAO (IDCARTAO)
  tablespace TBS_CARTOES_I
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Create/Recreate primary, unique and foreign key constraints 
alter table CARTOES.TB_CARTAO
  add constraint TB_CARTAO_PK primary key (IDCARTAO);
alter table CARTOES.TB_CARTAO
  add constraint TB_CARTAO_FK1 foreign key (IDCARTAO_PROPOSTA)
  references CARTOES.TB_CARTAO_PROPOSTA (IDCARTAO_PROPOSTA);
alter table CARTOES.TB_CARTAO
  add constraint TB_CARTAO_FK2 foreign key (IDCONTA_CARTAO)
  references CARTOES.TB_CONTA_CARTAO (IDCONTA_CARTAO);
-- Create/Recreate check constraints 
alter table CARTOES.TB_CARTAO
  add constraint TB_CARTAO_CK1
  check (CDSITUACAO IN (1,2,3,4,5));
alter table CARTOES.TB_CARTAO
  add constraint TB_CARTAO_CK2
  check (TPPAGAMENTO IN (1,2,3));
alter table CARTOES.TB_CARTAO
  add constraint TB_CARTAO_CK3
  check (CDMOTIVO BETWEEN 0 AND 99);
-- Grant/Revoke object privileges 


insert into CARTOES.TB_CARTAO IDCARTAO, IDCARTAO_PROPOSTA, IDCONTA_CARTAO, NRCARTAO, DTVALIDADE, NRDIA_DEBITO, TPPAGAMENTO, CDSITUACAO, DTENTREGA, DTCANCELAMENTO, CDMOTIVO, CDOPERADOR_INCLUSAO, DHREGISTRO, CDOPERADOR_ALTERACAO, DHALTERACAO, IDCOMPONENTE)
values ('FF95CEC4CBF82F48E0530100007FBDE5', 'FF95CEC4CBF72F48E0530100007FBDE5', 'FF95CEC4C8792F48E0530100007FBDE5','5151070044387015', to_date('30-06-2027', 'dd-mm-yyyy'), 10, 1, 3, to_date('15-06-2023', 'dd-mm-yyyy'), null, null, '1', to_date('15-06-2023 10:32:38', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);

insert into CARTOES.TB_CARTAO (TO_CHAR(NRCARTAO), IDCARTAO, IDCARTAO_PROPOSTA, IDCONTA_CARTAO, NRCARTAO, DTVALIDADE, NRDIA_DEBITO, TPPAGAMENTO, CDSITUACAO, DTENTREGA, DTCANCELAMENTO, CDMOTIVO, CDOPERADOR_INCLUSAO, DHREGISTRO, CDOPERADOR_ALTERACAO, DHALTERACAO, IDCOMPONENTE)
values ('FF95CEC4CBFC2F48E0530100007FBDE5', 'FF95CEC4CBFB2F48E0530100007FBDE5', 'FF95CEC4C87B2F48E0530100007FBDE5', '5151070044381239', to_date('30-06-2027', 'dd-mm-yyyy'), 10, 1, 3, to_date('15-06-2023', 'dd-mm-yyyy'), null, null, '1', to_date('15-06-2023 10:32:38', 'dd-mm-yyyy hh24:mi:ss'), null, null, null);
commit;

-- Create table
create table CARTOES.TB_ARQUIVO_LINHA
(
  idarquivo_linha RAW(16) default SYS_GUID() not null,
  idarquivo       RAW(16) not null,
  nrlinha         NUMBER(10) not null,
  dsconteudo      VARCHAR2(2000) not null,
  dtprocesso      DATE,
  cdsituacao      NUMBER(1),
  dhregistro      DATE default SYSDATE not null
)
tablespace TBS_CARTOES_D
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  )
compress for all operations;
-- Add comments to the table 
comment on table CARTOES.TB_ARQUIVO_LINHA
  is 'Proposito:Tabela de Linhas dos arquivos de integração do produto CARTAO. Finalidade: Tabela para armazenar dados das lihas de cada arquivo recebido ou gerado com integracao com o parceiro. Tabela filha da tabela CARTOES.TB_ARQUIVO. Volumetria: Inicla de 20.000 registros, com 200% ao mes. Politica de Expurgo: 6 meses de retencao.';
-- Add comments to the columns 
comment on column CARTOES.TB_ARQUIVO_LINHA.idarquivo_linha
  is 'Código único da linha do arquivo utilizado como Chave Primaria composta com o campo IDARQUIVO. #CLASSIFICACAO_DADO: I';
comment on column CARTOES.TB_ARQUIVO_LINHA.idarquivo
  is 'Código único do arquivo utilizado como Chave Primaria composta com o campo IDLINHA_ARQUIVO. Chave estrangeira para a tabela CARTOES.TB_ARQUIVO #CLASSIFICACAO_DADO: I';
comment on column CARTOES.TB_ARQUIVO_LINHA.nrlinha
  is 'Número da Linha. #CLASSIFICACAO_DADO: I';
comment on column CARTOES.TB_ARQUIVO_LINHA.dsconteudo
  is 'Conteúdo da Linha. #CLASSIFICACAO_DADO: I';
comment on column CARTOES.TB_ARQUIVO_LINHA.dtprocesso
  is 'Data do processamento da linha. #CLASSIFICACAO_DADO: I';
comment on column CARTOES.TB_ARQUIVO_LINHA.cdsituacao
  is 'Status processamento da linha (Tabela de dominio = TB_DOMINIO_CAMPO):01Pendente, 1-Processado, 2-Erro, 3-Gerado Ailosmais, 4-Gerado Aimaro. #CLASSIFICACAO_DADO: I';
comment on column CARTOES.TB_ARQUIVO_LINHA.dhregistro
  is 'Data/Hora de inclusao do registro. #CLASSIFICACAO_DADO: I';
-- Create/Recreate indexes 
create unique index CARTOES.TB_ARQUIVO_LINHA_NEW_PK on CARTOES.TB_ARQUIVO_LINHA (IDARQUIVO, IDARQUIVO_LINHA)
  tablespace TBS_CARTOES_I
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Create/Recreate primary, unique and foreign key constraints 
alter table CARTOES.TB_ARQUIVO_LINHA
  add constraint TB_ARQUIVO_LINHA_PK primary key (IDARQUIVO, IDARQUIVO_LINHA);
alter table CARTOES.TB_ARQUIVO_LINHA
  add constraint TB_ARQUIVO_LINHA_FK1 foreign key (IDARQUIVO)
  references CARTOES.TB_ARQUIVO (IDARQUIVO);
-- Create/Recreate check constraints 
alter table CARTOES.TB_ARQUIVO_LINHA
  add constraint TB_ARQUIVO_LINHA_CK1
  check (CDSITUACAO IN (0,1,2,3,4));


  
 