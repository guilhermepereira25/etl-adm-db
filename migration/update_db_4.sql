-------alterações área-------------
ALTER TABLE area
ALTER COLUMN id SET NOT NULL;

ALTER TABLE area
ALTER COLUMN descricao SET NOT NULL;

ALTER TABLE area
ALTER COLUMN deleted SET DEFAULT false;

ALTER TABLE area ADD CONSTRAINT unique_name_area UNIQUE (descricao);

-------alterações ativo_ti-------------

ALTER TABLE ativo_ti 
ALTER COLUMN id SET NOT NULL;

ALTER TABLE ativo_ti
ALTER COLUMN tipo SET NOT NULL;

ALTER TABLE ativo_ti
ALTER COLUMN situacao_id  SET NOT NULL;

ALTER TABLE ativo_ti
ALTER COLUMN data_compra  SET NOT NULL;

-- ALTER TABLE ativo_ti
-- ALTER COLUMN data_fim_vida_util SET NOT NULL;

ALTER TABLE ativo_ti
ALTER COLUMN funcionario_id  SET NOT NULL;

ALTER TABLE ativo_ti
ALTER COLUMN created_at  SET NOT NULL;

ALTER TABLE ativo_ti
ALTER COLUMN deleted SET DEFAULT false;

-------alterações cargo-------------

ALTER TABLE cargo 
ALTER COLUMN id SET NOT NULL;

ALTER TABLE cargo 
ALTER COLUMN descricao SET NOT NULL;

ALTER TABLE cargo 
ALTER COLUMN deleted SET DEFAULT false;

ALTER TABLE cargo ADD CONSTRAINT unique_name_cargo UNIQUE (descricao);

-------alterações chamado-------------

ALTER TABLE chamado  
ALTER COLUMN id SET NOT NULL;

ALTER TABLE chamado  
ALTER COLUMN atendente SET NOT NULL;

ALTER TABLE chamado  
ALTER COLUMN requerente SET NOT NULL;

ALTER TABLE chamado  
ALTER COLUMN tipo_chamado_id SET NOT NULL;

ALTER TABLE chamado  
ALTER COLUMN situacao_id SET NOT NULL;

ALTER TABLE chamado  
ALTER COLUMN created_at SET NOT NULL;

ALTER TABLE chamado  
ALTER COLUMN deleted SET DEFAULT false;

-------alterações equipe-------------

ALTER TABLE equipe 
ALTER COLUMN id SET NOT NULL;

ALTER TABLE equipe 
ALTER COLUMN nome SET NOT NULL;

ALTER TABLE equipe 
ALTER COLUMN created_at SET NOT NULL;

ALTER TABLE equipe  
ALTER COLUMN deleted SET DEFAULT false;

ALTER TABLE equipe ADD CONSTRAINT unique_name_equipe UNIQUE (nome);


-------alterações equipe_area-------------

ALTER TABLE equipe_area  
ALTER COLUMN id SET NOT NULL;

ALTER TABLE equipe_area 
ALTER COLUMN equipe_id SET NOT NULL;

ALTER TABLE equipe_area 
ALTER COLUMN area_id SET NOT NULL;

ALTER TABLE equipe_area 
ALTER COLUMN deleted SET DEFAULT false;

-------alterações equipe_funcionario-------------

ALTER TABLE equipe_funcionario  
ALTER COLUMN id SET NOT NULL;

ALTER TABLE equipe_funcionario 
ALTER COLUMN equipe_id SET NOT NULL;

ALTER TABLE equipe_funcionario 
ALTER COLUMN funcionario_id SET NOT NULL;

ALTER TABLE equipe_funcionario 
ALTER COLUMN deleted SET DEFAULT false;


-------alterações equipe_projeto-------------

ALTER TABLE equipe_projeto  
ALTER COLUMN id SET NOT NULL;

ALTER TABLE equipe_projeto 
ALTER COLUMN equipe_id SET NOT NULL;

ALTER TABLE equipe_projeto 
ALTER COLUMN projeto_id SET NOT NULL;

ALTER TABLE equipe_projeto 
ALTER COLUMN deleted SET DEFAULT false;

-------alterações funcao-------------

ALTER TABLE funcao  
ALTER COLUMN id SET NOT NULL;

ALTER TABLE funcao  
ALTER COLUMN descricao SET NOT NULL;

ALTER TABLE funcao  
ALTER COLUMN created_at SET NOT NULL;

ALTER TABLE funcao  
ALTER COLUMN updated_at SET NOT NULL;

ALTER TABLE funcao  
ALTER COLUMN deleted SET DEFAULT false;

ALTER TABLE funcao ADD CONSTRAINT unique_name_funcao UNIQUE (descricao);


-------alterações funcionario-------------
ALTER TABLE funcionario RENAME COLUMN id_funcao TO funcao_id;
ALTER TABLE funcionario RENAME COLUMN id_nivel TO nivel_id;
ALTER TABLE funcionario RENAME COLUMN id_cargo TO cargo_id;

ALTER TABLE funcionario  
ALTER COLUMN id SET NOT NULL;

ALTER TABLE funcionario  
ALTER COLUMN nome SET NOT NULL;

ALTER TABLE funcionario  
ALTER COLUMN funcao_id SET NOT NULL;

ALTER TABLE funcionario  
ALTER COLUMN created_at SET NOT NULL;

ALTER TABLE funcionario  
ALTER COLUMN deleted SET DEFAULT false;


-------alterações funcionario_sistema-------------

ALTER TABLE funcionario_sistema  
ALTER COLUMN id SET NOT NULL;

ALTER TABLE funcionario_sistema 
ALTER COLUMN perfil_id SET NOT NULL;

ALTER TABLE funcionario_sistema 
ALTER COLUMN funcionario_id SET NOT NULL;

ALTER TABLE funcionario_sistema 
ALTER COLUMN sistema_id SET NOT NULL;

ALTER TABLE funcionario_sistema 
ALTER COLUMN deleted SET DEFAULT false;

-------alterações incidente-------------

ALTER TABLE incidente  
ALTER COLUMN id SET NOT NULL;

ALTER TABLE incidente 
ALTER COLUMN descricao SET NOT NULL;

ALTER TABLE incidente 
ALTER COLUMN severidade SET NOT NULL;

ALTER TABLE incidente 
ALTER COLUMN situacao_id SET NOT NULL;

ALTER TABLE incidente 
ALTER COLUMN funcionario_id SET NOT NULL;

ALTER TABLE incidente 
ALTER COLUMN created_at SET NOT NULL;

ALTER TABLE incidente 
ALTER COLUMN updated_at SET NOT NULL;

ALTER TABLE incidente 
ALTER COLUMN deleted SET DEFAULT false;

-------alterações log_chamado-------------

ALTER TABLE log_chamado  
ALTER COLUMN id SET NOT NULL;

ALTER TABLE log_chamado 
ALTER COLUMN encaminhador_id SET NOT NULL;

ALTER TABLE log_chamado 
ALTER COLUMN area_id SET NOT NULL;

ALTER TABLE log_chamado 
ALTER COLUMN created_at SET NOT NULL;

ALTER TABLE log_chamado 
ALTER COLUMN deleted SET DEFAULT false;

-------alterações nivel-------------

ALTER TABLE nivel  
ALTER COLUMN id SET NOT NULL;

ALTER TABLE nivel  
ALTER COLUMN descricao SET NOT NULL;

ALTER TABLE nivel  
ALTER COLUMN deleted SET DEFAULT false;

ALTER TABLE nivel ADD CONSTRAINT unique_name_nivel UNIQUE (descricao);


-------alterações perfil-------------

ALTER TABLE perfil  
ALTER COLUMN id SET NOT NULL;

ALTER TABLE perfil  
ALTER COLUMN nome SET NOT NULL;

ALTER TABLE perfil  
ALTER COLUMN deleted SET DEFAULT false;

ALTER TABLE perfil  ADD CONSTRAINT unique_name_perfil UNIQUE (nome);

-------alterações perfil_permissao-------------

ALTER TABLE perfil_permissao  
ALTER COLUMN id SET NOT NULL;

ALTER TABLE perfil_permissao  
ALTER COLUMN perfil_id SET NOT NULL;

ALTER TABLE perfil_permissao  
ALTER COLUMN permissao_id SET NOT NULL;

ALTER TABLE perfil_permissao  
ALTER COLUMN deleted SET DEFAULT false;

-------alterações permissao-------------

ALTER TABLE permissao  
ALTER COLUMN id SET NOT NULL;

ALTER TABLE permissao  
ALTER COLUMN nome SET NOT NULL;

ALTER TABLE permissao  
ALTER COLUMN deleted SET DEFAULT false;

ALTER TABLE permissao  ADD CONSTRAINT unique_name_permissao UNIQUE (nome);

-------alterações projeto-------------

ALTER TABLE projeto  
ALTER COLUMN id SET NOT NULL;

ALTER TABLE projeto  
ALTER COLUMN nome SET NOT NULL;

ALTER TABLE projeto  
ALTER COLUMN situacao_id SET NOT NULL;

ALTER TABLE projeto  
ALTER COLUMN created_at SET NOT NULL;

ALTER TABLE projeto  
ALTER COLUMN deleted SET DEFAULT false;

ALTER TABLE projeto  ADD CONSTRAINT unique_name_projeto UNIQUE (nome);

-------alterações rel_chamado_log_chamado-------------

ALTER TABLE rel_chamado_log_chamado  
ALTER COLUMN id SET NOT NULL;

ALTER TABLE rel_chamado_log_chamado  
ALTER COLUMN log_chamado_id SET NOT NULL;

ALTER TABLE rel_chamado_log_chamado  
ALTER COLUMN chamado_id SET NOT NULL;

ALTER TABLE rel_chamado_log_chamado  
ALTER COLUMN deleted SET DEFAULT false;

-------alterações sistema-------------

ALTER TABLE sistema  
ALTER COLUMN id SET NOT NULL;

ALTER TABLE sistema  
ALTER COLUMN nome SET NOT NULL;

ALTER TABLE sistema  
ALTER COLUMN deleted SET DEFAULT false;

ALTER TABLE sistema  ADD CONSTRAINT unique_name_sistema UNIQUE (nome);

-------alterações situacao-------------

ALTER TABLE situacao  
ALTER COLUMN id SET NOT NULL;

ALTER TABLE situacao  
ALTER COLUMN valor SET NOT NULL;

ALTER TABLE situacao  
ALTER COLUMN created_at SET NOT NULL;

ALTER TABLE situacao  
ALTER COLUMN deleted SET DEFAULT false;

-------alterações tipo_chamado-------------

ALTER TABLE tipo_chamado  
ALTER COLUMN id SET NOT NULL;

ALTER TABLE tipo_chamado  
ALTER COLUMN descricao SET NOT NULL;

ALTER TABLE tipo_chamado  
ALTER COLUMN deleted SET DEFAULT false;

ALTER TABLE tipo_chamado  ADD CONSTRAINT unique_name_tipo_chamado UNIQUE (descricao);

-------alterações treinamento_funcionario-------------

ALTER TABLE treinamento_funcionario  
ALTER COLUMN id SET NOT NULL;

ALTER TABLE treinamento_funcionario  
ALTER COLUMN treinamento_id SET NOT NULL;

ALTER TABLE treinamento_funcionario  
ALTER COLUMN funcionario_id SET NOT NULL;

ALTER TABLE treinamento_funcionario  
ALTER COLUMN deleted SET DEFAULT false;

-------alterações treinamento_ti-------------

ALTER TABLE treinamento_ti  
ALTER COLUMN id SET NOT NULL;

ALTER TABLE treinamento_ti  
ALTER COLUMN descricao SET NOT NULL;

ALTER TABLE treinamento_ti  
ALTER COLUMN created_at SET NOT NULL;

ALTER TABLE treinamento_ti  
ALTER COLUMN deleted SET DEFAULT false;
