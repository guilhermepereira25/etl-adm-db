CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

create type severidade_enum as enum ('Baixa', 'Média', 'Alta');

alter type severidade_enum owner to dbadmin;

create type situacao_enum as enum ('Em Andamento', 'Concluído', 'Em Atraso', 'Aberto', 'Resolvido', 'Ativo', 'Devolvido', 'Encerrado', 'Baixa Urgência', 'Alerta de troca', 'Troca Urgente');

alter type situacao_enum owner to dbadmin;

create type tipo_enum as enum ('software', 'servidor', 'computador');

alter type tipo_enum owner to dbadmin;

create table if not exists area
(
    id        uuid    default gen_random_uuid() not null
        primary key,
    descricao varchar(255)                      not null
        constraint unique_name_area
            unique,
    deleted   boolean default false
);

alter table area
    owner to dbadmin;

create table if not exists situacao
(
    id         uuid    default gen_random_uuid() not null
        primary key,
    valor      situacao_enum                     not null,
    created_at timestamp                         not null,
    deleted    boolean default false
);

alter table situacao
    owner to dbadmin;

create table if not exists cargo
(
    id        uuid    default gen_random_uuid() not null
        primary key,
    descricao varchar(255)                      not null
        constraint unique_name_cargo
            unique,
    deleted   boolean default false
);

alter table cargo
    owner to dbadmin;

create table if not exists equipe
(
    id         uuid    default gen_random_uuid() not null
        primary key,
    nome       varchar(100)                      not null
        constraint unique_name_equipe
            unique,
    created_at timestamp                         not null,
    deleted    boolean default false
);

alter table equipe
    owner to dbadmin;

create table if not exists equipe_area
(
    id        uuid    default gen_random_uuid() not null
        primary key,
    equipe_id uuid                              not null
        references equipe,
    area_id   uuid                              not null
        references area,
    deleted   boolean default false
);

alter table equipe_area
    owner to dbadmin;

create table if not exists estoque_ativo_ti
(
    tipo       tipo_enum,
    quantidade integer,
    created_at timestamp default CURRENT_TIMESTAMP
);

alter table estoque_ativo_ti
    owner to dbadmin;

create table if not exists funcao
(
    id         uuid    default gen_random_uuid() not null
        primary key,
    descricao  varchar(255)                      not null
        constraint unique_name_funcao
            unique,
    created_at timestamp                         not null,
    updated_at timestamp                         not null,
    deleted    boolean default false
);

alter table funcao
    owner to dbadmin;

create table if not exists nivel
(
    id        uuid    default gen_random_uuid() not null
        primary key,
    descricao varchar(255)                      not null
        constraint unique_name_nivel
            unique,
    deleted   boolean default false
);

alter table nivel
    owner to dbadmin;

create table if not exists funcionario
(
    id         uuid    default gen_random_uuid() not null
        primary key,
    nome       varchar(100)                      not null,
    funcao_id  uuid                              not null
        constraint funcionario_id_funcao_fkey
            references funcao,
    nivel_id   uuid
        constraint funcionario_id_nivel_fkey
            references nivel,
    cargo_id   uuid
        constraint funcionario_id_cargo_fkey
            references cargo,
    created_at timestamp                         not null,
    deleted    boolean default false
);

alter table funcionario
    owner to dbadmin;

create table if not exists ativo_ti
(
    id                 uuid    default gen_random_uuid() not null
        primary key,
    tipo               tipo_enum                         not null,
    descricao          varchar(255),
    situacao_id        uuid                              not null
        references situacao,
    data_compra        date                              not null,
    data_fim_vida_util date,
    funcionario_id     uuid                              not null
        references funcionario,
    created_at         timestamp                         not null,
    dias_restante_vida integer,
    deleted            boolean default false
);

alter table ativo_ti
    owner to dbadmin;

create table if not exists equipe_funcionario
(
    id             uuid    default gen_random_uuid() not null
        primary key,
    equipe_id      uuid                              not null
        constraint fk_equipe
            references equipe,
    funcionario_id uuid                              not null
        constraint fk_funcionario
            references funcionario,
    deleted        boolean default false
);

alter table equipe_funcionario
    owner to dbadmin;

create table if not exists incidente
(
    id             uuid    default gen_random_uuid() not null
        primary key,
    descricao      varchar(255)                      not null,
    severidade     severidade_enum                   not null,
    situacao_id    uuid                              not null
        references situacao,
    funcionario_id uuid                              not null
        references funcionario,
    created_at     timestamp                         not null,
    updated_at     timestamp                         not null,
    deleted        boolean default false
);

alter table incidente
    owner to dbadmin;

create table if not exists log_chamado
(
    id              uuid    default gen_random_uuid() not null
        primary key,
    encaminhador_id uuid                              not null
        references funcionario,
    receptor_id     uuid
        references funcionario,
    area_id         uuid                              not null
        references area,
    created_at      timestamp                         not null,
    deleted         boolean default false
);

alter table log_chamado
    owner to dbadmin;

create table if not exists projeto
(
    id              uuid    default gen_random_uuid() not null
        primary key,
    nome            varchar(100)                      not null
        constraint unique_name_projeto
            unique,
    situacao_id     uuid                              not null
        references situacao,
    descricao       varchar(255),
    created_at      timestamp                         not null,
    data_estimativa timestamp,
    data_conclusao  timestamp,
    deleted         boolean default false
);

alter table projeto
    owner to dbadmin;

create table if not exists equipe_projeto
(
    id         uuid    default gen_random_uuid() not null
        primary key,
    projeto_id uuid                              not null
        constraint fk_projeto
            references projeto,
    equipe_id  uuid                              not null
        constraint fk_equipe
            references equipe,
    deleted    boolean default false
);

alter table equipe_projeto
    owner to dbadmin;

create table if not exists tipo_chamado
(
    id        uuid    default gen_random_uuid() not null
        primary key,
    descricao varchar(255)                      not null
        constraint unique_name_tipo_chamado
            unique,
    deleted   boolean default false
);

alter table tipo_chamado
    owner to dbadmin;

create table if not exists chamado
(
    id              uuid    default gen_random_uuid() not null
        primary key,
    atendente       varchar(100)                      not null,
    requerente      varchar(100)                      not null,
    tipo_chamado_id uuid                              not null
        references tipo_chamado,
    situacao_id     uuid                              not null
        references situacao,
    created_at      timestamp                         not null,
    deleted         boolean default false
);

alter table chamado
    owner to dbadmin;

create table if not exists rel_chamado_log_chamado
(
    id             uuid    default gen_random_uuid() not null
        primary key,
    log_chamado_id uuid
        references log_chamado,
    chamado_id     uuid                              not null
        references chamado,
    deleted        boolean default false
);

alter table rel_chamado_log_chamado
    owner to dbadmin;

create table if not exists treinamento_ti
(
    id          uuid    default gen_random_uuid() not null
        primary key,
    descricao   varchar(255)                      not null,
    data_hora   timestamp,
    created_at  timestamp                         not null,
    data_inicio timestamp,
    data_fim    timestamp,
    deleted     boolean default false
);

alter table treinamento_ti
    owner to dbadmin;

create table if not exists treinamento_funcionario
(
    id             uuid    default gen_random_uuid() not null
        primary key,
    treinamento_id uuid                              not null
        references treinamento_ti,
    funcionario_id uuid                              not null
        references funcionario,
    data_conclusao timestamp,
    nota_final     double precision,
    aprovado       boolean,
    deleted        boolean default false
);

alter table treinamento_funcionario
    owner to dbadmin;

create table if not exists sistema
(
    id      uuid         not null
        primary key,
    nome    varchar(100) not null
        constraint unique_name_sistema
            unique,
    deleted boolean default false
);

alter table sistema
    owner to dbadmin;

create table if not exists perfil
(
    id      uuid         not null
        primary key,
    nome    varchar(100) not null
        constraint unique_name_perfil
            unique,
    deleted boolean default false
);

alter table perfil
    owner to dbadmin;

create table if not exists permissao
(
    id      uuid         not null
        primary key,
    nome    varchar(100) not null
        constraint unique_name_permissao
            unique,
    deleted boolean default false
);

alter table permissao
    owner to dbadmin;

create table if not exists funcionario_sistema
(
    id             uuid not null
        primary key,
    perfil_id      uuid not null
        references perfil,
    funcionario_id uuid not null
        references funcionario,
    sistema_id     uuid not null
        references sistema,
    deleted        boolean default false
);

alter table funcionario_sistema
    owner to dbadmin;

create table if not exists perfil_permissao
(
    id           uuid not null
        primary key,
    perfil_id    uuid not null
        references perfil,
    permissao_id uuid not null
        references permissao,
    deleted      boolean default false
);

alter table perfil_permissao
    owner to dbadmin;

create or replace view ativos_por_situacao(situacao, quantidade_ativos) as
SELECT situacao.valor AS situacao,
       count(*)       AS quantidade_ativos
FROM ativo_ti
         JOIN situacao ON ativo_ti.situacao_id = situacao.id
GROUP BY situacao.valor;

alter table ativos_por_situacao
    owner to dbadmin;

create or replace view incidentes_criticos(descricao, severidade, situacao) as
SELECT i.descricao,
       i.severidade,
       s.valor AS situacao
FROM incidente i
         JOIN situacao s ON i.situacao_id = s.id
WHERE i.severidade = 'Alta'::severidade_enum;

alter table incidentes_criticos
    owner to dbadmin;

create or replace view view_funcionarios_de_cargo_engenheiro_de_software(nome, descricao) as
SELECT funcionario.nome,
       c.descricao
FROM funcionario
         JOIN cargo c ON funcionario.cargo_id = c.id AND c.descricao::text = 'Engenheiro de Software'::text;

alter table view_funcionarios_de_cargo_engenheiro_de_software
    owner to dbadmin;

create or replace function uuid_nil() returns uuid
    immutable
    strict
    parallel safe
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function uuid_nil() owner to dbadmin;

create or replace function uuid_ns_dns() returns uuid
    immutable
    strict
    parallel safe
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function uuid_ns_dns() owner to dbadmin;

create or replace function uuid_ns_url() returns uuid
    immutable
    strict
    parallel safe
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function uuid_ns_url() owner to dbadmin;

create or replace function uuid_ns_oid() returns uuid
    immutable
    strict
    parallel safe
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function uuid_ns_oid() owner to dbadmin;

create or replace function uuid_ns_x500() returns uuid
    immutable
    strict
    parallel safe
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function uuid_ns_x500() owner to dbadmin;

create or replace function uuid_generate_v1() returns uuid
    strict
    parallel safe
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function uuid_generate_v1() owner to dbadmin;

create or replace function uuid_generate_v1mc() returns uuid
    strict
    parallel safe
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function uuid_generate_v1mc() owner to dbadmin;

create or replace function uuid_generate_v3(namespace uuid, name text) returns uuid
    immutable
    strict
    parallel safe
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function uuid_generate_v3(uuid, text) owner to dbadmin;

create or replace function uuid_generate_v4() returns uuid
    strict
    parallel safe
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function uuid_generate_v4() owner to dbadmin;

create or replace function uuid_generate_v5(namespace uuid, name text) returns uuid
    immutable
    strict
    parallel safe
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function uuid_generate_v5(uuid, text) owner to dbadmin;

create or replace function atualizar_estoque_ativos() returns trigger
    language plpgsql
as
$$
BEGIN
    IF TG_OP = 'INSERT' THEN
        UPDATE estoque_ativo_ti
        SET quantidade = quantidade + 1
        WHERE tipo = NEW.tipo;

    ELSIF TG_OP = 'DELETE' THEN
        UPDATE estoque_ativo_ti
        SET quantidade = quantidade - 1
        WHERE tipo = OLD.tipo;
    END IF;
    RETURN NULL;
END;
$$;

alter function atualizar_estoque_ativos() owner to dbadmin;

create trigger trigger_estoque_ativos
    after insert or delete
    on ativo_ti
    for each row
execute procedure atualizar_estoque_ativos();

create or replace function calcular_tempo_resolucao_chamado(chamado_id uuid) returns interval
    language plpgsql
as
$$
DECLARE
    abertura_chamado timestamp;
    fechamento_chamado timestamp;
    tempo_resolucao INTERVAL;
BEGIN
    -- Obtém a data de abertura do chamado
    SELECT created_at INTO abertura_chamado FROM chamado WHERE id = chamado_id;

    -- Obtém a data de fechamento do chamado
    SELECT created_at INTO fechamento_chamado FROM chamado WHERE id = chamado_id;

    -- Calcula o tempo decorrido entre a abertura e o fechamento do chamado
    tempo_resolucao := fechamento_chamado - abertura_chamado;

    -- Retorna o tempo de resolução
    RETURN tempo_resolucao;
END;
$$;

alter function calcular_tempo_resolucao_chamado(uuid) owner to dbadmin;

create or replace function relatorio_treinamentos_por_funcionario(id_funcionario uuid)
    returns TABLE(nome_funcionario character varying, descricao_treinamento character varying, data_hora_treinamento timestamp without time zone)
    language plpgsql
as
$$
BEGIN
    RETURN QUERY
    SELECT
        f.nome AS nome_funcionario,
        tt.descricao AS descricao_treinamento,
        tt.data_hora AS data_hora_treinamento
    FROM
        treinamento_ti tt
    JOIN
        treinamento_funcionario tf ON tt.id = tf.treinamento_id
    JOIN
        funcionario f ON tf.funcionario_id = f.id
    WHERE
        f.id = id_funcionario;
END;
$$;

alter function relatorio_treinamentos_por_funcionario(uuid) owner to dbadmin;

create or replace procedure sync_estoque_ativo_ti()
    language plpgsql
as
$$
  DECLARE
        qnt_ativo_aux int;
        tipo_ativo_aux tipo_enum;
        cur CURSOR FOR SELECT ativo_ti.tipo, count(*) as quantidade FROM ativo_ti GROUP BY ativo_ti.tipo;
  BEGIN
    FOR cursor_record IN cur LOOP
        qnt_ativo_aux := cursor_record.quantidade;
        tipo_ativo_aux := cursor_record.tipo;

        UPDATE
            estoque_ativo_ti
        SET quantidade = qnt_ativo_aux
        WHERE tipo = tipo_ativo_aux;
        end loop;
  end;
$$;

alter procedure sync_estoque_ativo_ti() owner to dbadmin;

create or replace function aprovar_funcionario_treinamento() returns trigger
    language plpgsql
as
$$

DECLARE

	aprovacao bool;
	nota_funcionario float;
	data_aprovacao timestamp;
begin
	SELECT
		treinamento_funcionario.nota_final, CURRENT_TIMESTAMP INTO nota_funcionario, data_aprovacao
	from treinamento_funcionario
	where treinamento_funcionario.treinamento_id = new.treinamento_id AND treinamento_funcionario.funcionario_id = NEW.funcionario_id;

	IF nota_funcionario IS NULL THEN
		UPDATE treinamento_funcionario
			SET aprovado = NULL
		where treinamento_funcionario.treinamento_id = new.treinamento_id AND treinamento_funcionario.funcionario_id = NEW.funcionario_id;

	ELSIF nota_funcionario >= 7 THEN
		UPDATE treinamento_funcionario
			SET aprovado = TRUE, data_conclusão = data_aprovacao
		where treinamento_funcionario.treinamento_id = new.treinamento_id AND treinamento_funcionario.funcionario_id = NEW.funcionario_id;

	ELSE
		UPDATE treinamento_funcionario
			SET aprovado = FALSE
		where treinamento_funcionario.treinamento_id = new.treinamento_id AND treinamento_funcionario.funcionario_id = NEW.funcionario_id;

	END IF;

	RETURN NEW;

end;
$$;

alter function aprovar_funcionario_treinamento() owner to dbadmin;

create trigger atualizar_aprovacao_funcionario_treinamento
    after insert or update
    on treinamento_funcionario
    for each row
execute procedure aprovar_funcionario_treinamento();

create or replace function funcionario_deletado_remover_equipes() returns trigger
    language plpgsql
as
$$

DECLARE
	funcionario_deletado bool;
BEGIN
	SELECT
		deleted INTO funcionario_deletado
	FROM equipe_funcionario
	WHERE equipe_funcionario.funcionario_id = NEW.id;

	IF funcionario_deletado = TRUE THEN
		UPDATE equipe_funcionario
			SET deleted = TRUE
		WHERE equipe_funcionario.funcionario_id = NEW.id;
	END IF;

	RETURN NEW;
END;
$$;

alter function funcionario_deletado_remover_equipes() owner to dbadmin;

create trigger funcionario_deletado
    after insert or update
    on funcionario
    for each row
execute procedure funcionario_deletado_remover_equipes();

create or replace function atualizar_situacao_projeto() returns trigger
    language plpgsql
as
$$

DECLARE
	status_projeto varchar;
	data_da_conclusao timestamp;
BEGIN
	SELECT
		projeto.data_conclusao  INTO data_da_conclusao
	FROM projeto
	WHERE projeto.id = NEW.id;

	IF data_da_conclusao IS NOT NULL THEN
		SELECT
			id INTO status_projeto
		FROM situacao
		WHERE situacao.valor = 'Concluido';	-- forçar o texto direto NO lugar

		UPDATE projeto
			SET projeto.situacao_id = status_projeto
		WHERE projeto.id = NEW.id;

	END IF;

	RETURN NEW;
END;
$$;

alter function atualizar_situacao_projeto() owner to dbadmin;

create trigger atualizar_status_projeto
    after insert or update
    on projeto
    for each row
execute procedure atualizar_situacao_projeto();

