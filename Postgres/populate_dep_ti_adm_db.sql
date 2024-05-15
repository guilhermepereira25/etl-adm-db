CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE funcionario (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  nome varchar(100),
  id_funcao uuid,
  id_nivel uuid,
  id_cargo uuid,
  created_at timestamp
);

CREATE TABLE funcao (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  descricao varchar(255),
  created_at timestamp,
  updated_at timestamp
);

CREATE TABLE nivel (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  descricao varchar(255)
);

CREATE TABLE cargo (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  descricao varchar(255)
);

CREATE TABLE area (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  descricao varchar(255)
);

CREATE TABLE tipo_chamado (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  descricao varchar(255)
);

CREATE TABLE chamado (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  atendente varchar(100),
  requerente varchar(100),
  tipo_chamado_id uuid,
  situacao_id uuid,
  created_at timestamp
);

CREATE TABLE log_chamado (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  encaminhador varchar(100),
  receptor varchar(100),
  area_id uuid,
  created_at timestamp
);

CREATE TABLE rel_chamado_log_chamado (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  log_chamado_id uuid,
  chamado_id uuid
);

CREATE TABLE equipe (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  nome varchar(100),
  created_at timestamp
);

CREATE TABLE equipe_funcionario (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  equipe_id uuid,
  funcionario_id uuid,
  CONSTRAINT fk_equipe FOREIGN KEY (equipe_id) REFERENCES equipe (id),
  CONSTRAINT fk_funcionario FOREIGN KEY (funcionario_id) REFERENCES funcionario (id)                                                                            
);

CREATE TYPE situacao_enum AS ENUM ('Em Andamento','Concluído','Em Atraso','Aberto','Resolvido','Ativo','Devolvido','Encerrado');                                              

CREATE TABLE situacao (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  valor situacao_enum,
  created_at timestamp
);

CREATE TABLE projeto (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  nome varchar(100),
  situacao_id uuid,
  descricao varchar(255),
  created_at timestamp
);

CREATE TABLE equipe_projeto (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  projeto_id uuid,
  equipe_id uuid,
  CONSTRAINT fk_projeto FOREIGN KEY (projeto_id) REFERENCES projeto (id),
  CONSTRAINT fk_equipe FOREIGN KEY (equipe_id) REFERENCES equipe (id)
);

CREATE TYPE tipo_enum AS ENUM ('software','servidor','computador'); 

CREATE TABLE ativo_ti (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  tipo tipo_enum,
  descricao varchar(255),
  situacao_id uuid,
  data_compra date,
  data_fim_vida_util date,
  funcionario_id uuid,
  created_at timestamp
);

CREATE TYPE severidade_enum AS ENUM ('Baixa','Média','Alta');

CREATE TABLE incidente (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  descricao varchar(255),
  severidade severidade_enum,
  situacao_id uuid,
  funcionario_id uuid,
  created_at timestamp,
  updated_at timestamp
);

CREATE TABLE treinamento_ti (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  descricao varchar(255),
  data_hora timestamp,
  created_at timestamp
);

CREATE TABLE treinamento_funcionario (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  treinamento_id uuid,
  funcionario_id uuid
);

CREATE TABLE equipe_area (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  equipe_id uuid,
  area_id uuid
);

ALTER TABLE funcionario ADD FOREIGN KEY (id_cargo) REFERENCES cargo (id);

ALTER TABLE chamado ADD FOREIGN KEY (tipo_chamado_id) REFERENCES tipo_chamado (id);

ALTER TABLE chamado ADD FOREIGN KEY (situacao_id) REFERENCES situacao (id);

ALTER TABLE log_chamado ADD FOREIGN KEY (area_id) REFERENCES area (id);

ALTER TABLE rel_chamado_log_chamado ADD FOREIGN KEY (log_chamado_id) REFERENCES log_chamado (id);

ALTER TABLE rel_chamado_log_chamado ADD FOREIGN KEY (chamado_id) REFERENCES chamado (id);

ALTER TABLE projeto ADD FOREIGN KEY (situacao_id) REFERENCES situacao (id);

ALTER TABLE ativo_ti ADD FOREIGN KEY (situacao_id) REFERENCES situacao (id);

ALTER TABLE ativo_ti ADD FOREIGN KEY (funcionario_id) REFERENCES funcionario (id);

ALTER TABLE incidente ADD FOREIGN KEY (situacao_id) REFERENCES situacao (id);

ALTER TABLE incidente ADD FOREIGN KEY (funcionario_id) REFERENCES funcionario (id);

ALTER TABLE treinamento_funcionario ADD FOREIGN KEY (treinamento_id) REFERENCES treinamento_ti (id);

ALTER TABLE treinamento_funcionario ADD FOREIGN KEY (funcionario_id) REFERENCES funcionario (id);

ALTER TABLE equipe_area ADD FOREIGN KEY (equipe_id) REFERENCES equipe(id);

ALTER TABLE equipe_area ADD FOREIGN KEY (area_id) REFERENCES area(id);

ALTER TABLE funcionario ADD FOREIGN KEY (id_funcao) REFERENCES funcao(id);

ALTER TABLE funcionario ADD FOREIGN KEY (id_nivel) REFERENCES nivel(id);