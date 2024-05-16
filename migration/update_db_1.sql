
alter table log_chamado rename column encaminhador to encaminhador_id;

alter table log_chamado alter column encaminhador_id type uuid using encaminhador_id::uuid;

alter table log_chamado rename column receptor to receptor_id;

alter table log_chamado alter column receptor_id type uuid using receptor_id::uuid;

alter table log_chamado add foreign key (encaminhador_id) references funcionario (id);

alter table log_chamado add foreign key (receptor_id) references funcionario (id);

alter type situacao_enum add VALUE 'Baixa Urgência';
alter type situacao_enum add VALUE 'Alerta de troca';
alter type situacao_enum add VALUE 'Troca Urgente';

alter table treinamento_ti add column data_inicio timestamp, 
						   add column data_fim timestamp;
						  
alter table treinamento_funcionario add column data_conclusao timestamp, 
						   add column nota_final float,
						   add column aprovado bool;

alter table projeto add column data_estimativa timestamp, 
						   add column data_conclusao timestamp;

ALTER TABLE ativo_ti ADD COLUMN dias_restante_vida int;

ALTER TABLE funcionario  ADD COLUMN deleted bool;
ALTER TABLE funcao  ADD COLUMN deleted bool;
ALTER TABLE nivel  ADD COLUMN deleted bool;
ALTER TABLE cargo  ADD COLUMN deleted bool;
ALTER TABLE area  ADD COLUMN deleted bool;
ALTER TABLE tipo_chamado  ADD COLUMN deleted bool;
ALTER TABLE chamado  ADD COLUMN deleted bool;
ALTER TABLE log_chamado  ADD COLUMN deleted bool;
ALTER TABLE rel_chamado_log_chamado  ADD COLUMN deleted bool;
ALTER TABLE equipe ADD COLUMN deleted bool;
ALTER TABLE equipe_funcionario ADD COLUMN deleted bool;
ALTER TABLE situacao ADD COLUMN deleted bool;
ALTER TABLE projeto ADD COLUMN deleted bool;
ALTER TABLE equipe_projeto ADD COLUMN deleted bool;
ALTER TABLE ativo_ti  ADD COLUMN deleted bool;
ALTER TABLE incidente ADD COLUMN deleted bool;
ALTER TABLE treinamento_ti ADD COLUMN deleted bool;
ALTER TABLE treinamento_funcionario ADD COLUMN deleted bool;
ALTER TABLE equipe_area  ADD COLUMN deleted bool;