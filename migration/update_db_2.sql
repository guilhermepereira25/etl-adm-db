  -- Populando tabela projeto
INSERT INTO projeto (nome, situacao_id, descricao, created_at)
VALUES
  ('Projeto A', (SELECT id FROM situacao WHERE valor = 'Em Andamento'), 'Descrição do Projeto A', NOW()),
  ('Projeto B', (SELECT id FROM situacao WHERE valor = 'Em Andamento'), 'Descrição do Projeto B', NOW()),
  ('Projeto C', (SELECT id FROM situacao WHERE valor = 'Em Andamento'), 'Descrição do Projeto C', NOW());

UPDATE equipe_projeto
SET projeto_id = (SELECT id FROM projeto LIMIT 1)
WHERE equipe_id = (SELECT id FROM projeto LIMIT 1);

SELECT * FROM projeto;

--- view

CREATE OR REPLACE VIEW incidentes_criticos AS
SELECT i.descricao, i.severidade, s.valor as situacao
FROM incidente i
JOIN situacao s ON i.situacao_id = s.id
WHERE i.severidade = 'Alta';

CREATE VIEW ativos_por_situacao AS
SELECT
    situacao.valor AS situacao,
    COUNT(*) AS quantidade_ativos
FROM
    ativo_ti
JOIN
    situacao ON ativo_ti.situacao_id = situacao.id
GROUP BY
    situacao.valor;


-- function

CREATE OR REPLACE FUNCTION calcular_tempo_resolucao_chamado(chamado_id uuid) RETURNS INTERVAL AS $$
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
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION relatorio_treinamentos_por_funcionario(id_funcionario uuid) RETURNS TABLE (
    nome_funcionario varchar(100),
    descricao_treinamento varchar(255),
    data_hora_treinamento timestamp
) AS $$
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
$$ LANGUAGE plpgsql;

SELECT * FROM relatorio_treinamentos_por_funcionario('e1fd5064-d2cd-44f0-8a8c-b6219cb69f34');

SELECT * FROM ativo_ti;

CREATE TABLE estoque_ativo_ti
(
    tipo       tipo_enum,
    quantidade int,
    created_at timestamp default current_timestamp
);

CREATE OR REPLACE FUNCTION atualizar_estoque_ativos() RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        UPDATE estoque_ativos
        SET quantidade = quantidade + 1
        WHERE tipo = NEW.tipo;

    ELSIF TG_OP = 'DELETE' THEN
        UPDATE estoque_ativos
        SET quantidade = quantidade - 1
        WHERE tipo = OLD.tipo;
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE TRIGGER trigger_estoque_ativos
AFTER INSERT OR DELETE ON ativo_ti
FOR EACH ROW EXECUTE FUNCTION atualizar_estoque_ativos();

INSERT INTO estoque_ativo_ti (tipo, quantidade) VALUES
('software', 0),
('servidor', 0),
('computador', 0);

SELECT * FROM estoque_ativo_ti;

CREATE OR REPLACE PROCEDURE sync_estoque_ativo_ti()
language plpgsql AS $$
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

CALL sync_estoque_ativo_ti();