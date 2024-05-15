-- Populando tabela funcao
INSERT INTO funcao (descricao, created_at, updated_at)
VALUES 
  ('Analista de Suporte', NOW(), NOW()),
  ('Desenvolvedor', NOW(), NOW()),
  ('Gerente de Projetos', NOW(), NOW()),
  ('Analista de Sistemas', NOW(), NOW()),
  ('DBA', NOW(), NOW());

-- Populando tabela nivel
INSERT INTO nivel (descricao)
VALUES 
  ('Junior'),
  ('Pleno'),
  ('Senior');

-- Populando tabela cargo
INSERT INTO cargo (descricao)
VALUES 
  ('Técnico de Suporte'),
  ('Engenheiro de Software'),
  ('Diretor de Tecnologia');

-- Populando tabela area
INSERT INTO area (descricao)
VALUES 
  ('Suporte Técnico'),
  ('Desenvolvimento'),
  ('Infraestrutura');

-- Populando tabela tipo_chamado
INSERT INTO tipo_chamado (descricao)
VALUES 
  ('Incidente'),
  ('Solicitação'),
  ('Requisição');

-- Populando tabela situacao
INSERT INTO situacao (valor, created_at)
VALUES 
  ('Em Andamento', NOW()),
  ('Concluído', NOW()),
  ('Em Atraso', NOW()),
  ('Aberto', NOW()),
  ('Resolvido', NOW()),
  ('Ativo', NOW()),
  ('Devolvido', NOW()),
  ('Encerrado', NOW());


-- Populando tabela funcionario
INSERT INTO funcionario (nome, id_funcao, id_nivel, id_cargo, created_at)
VALUES 
  ('João Silva', (SELECT id FROM funcao WHERE descricao = 'Analista de Suporte'), (SELECT id FROM nivel WHERE descricao = 'Junior'), (SELECT id FROM cargo WHERE descricao = 'Técnico de Suporte'), NOW()),
  ('Maria Souza', (SELECT id FROM funcao WHERE descricao = 'Desenvolvedor'), (SELECT id FROM nivel WHERE descricao = 'Pleno'), (SELECT id FROM cargo WHERE descricao = 'Engenheiro de Software'), NOW()),
  ('José Santos', (SELECT id FROM funcao WHERE descricao = 'Gerente de Projetos'), (SELECT id FROM nivel WHERE descricao = 'Senior'), (SELECT id FROM cargo WHERE descricao = 'Diretor de Tecnologia'), NOW());

-- Populando tabela chamado
INSERT INTO chamado (atendente, requerente, tipo_chamado_id, situacao_id, created_at)
VALUES 
  ('Ana Oliveira', 'Carlos Lima', (SELECT id FROM tipo_chamado WHERE descricao = 'Incidente'), (SELECT id FROM situacao WHERE valor = 'Em Andamento'), NOW()),
  ('Pedro Rocha', 'Fernanda Almeida', (SELECT id FROM tipo_chamado WHERE descricao = 'Solicitação'), (SELECT id FROM situacao WHERE valor = 'Concluído'), NOW()),
  ('Mariana Costa', 'Paulo Santos', (SELECT id FROM tipo_chamado WHERE descricao = 'Requisição'), (SELECT id FROM situacao WHERE valor = 'Em Atraso'), NOW());

-- Populando tabela log_chamado
INSERT INTO log_chamado (encaminhador, receptor, area_id, created_at)
VALUES 
  ('Ana Oliveira', 'Pedro Rocha', (SELECT id FROM area WHERE descricao = 'Suporte Técnico'), NOW()),
  ('Mariana Costa', 'João Silva', (SELECT id FROM area WHERE descricao = 'Desenvolvimento'), NOW()),
  ('Pedro Rocha', 'Mariana Costa', (SELECT id FROM area WHERE descricao = 'Infraestrutura'), NOW());

-- Populando tabela rel_chamado_log_chamado
INSERT INTO rel_chamado_log_chamado (log_chamado_id, chamado_id)
VALUES 
  ((SELECT id FROM log_chamado LIMIT 1), (SELECT id FROM chamado LIMIT 1)),
  ((SELECT id FROM log_chamado LIMIT 1 OFFSET 1), (SELECT id FROM chamado LIMIT 1 OFFSET 1)),
  ((SELECT id FROM log_chamado LIMIT 1 OFFSET 2), (SELECT id FROM chamado LIMIT 1 OFFSET 2));

-- Populando tabela equipe
INSERT INTO equipe (nome, created_at)
VALUES 
  ('Equipe de Suporte', NOW()),
  ('Equipe de Desenvolvimento', NOW()),
  ('Equipe de Infraestrutura', NOW());

  -- Populando tabela projeto
INSERT INTO projeto (nome, situacao_id, descricao, created_at)
VALUES 
  ('Projeto A', (SELECT id FROM situacao WHERE valor = 'Em Andamento'), 'Descrição do Projeto A', NOW()),
  ('Projeto B', (SELECT id FROM situacao WHERE valor = 'Em Andamento'), 'Descrição do Projeto B', NOW()),
  ('Projeto C', (SELECT id FROM situacao WHERE valor = 'Em Andamento'), 'Descrição do Projeto C', NOW());


-- Populando tabela equipe_funcionario
INSERT INTO equipe_funcionario (equipe_id, funcionario_id)
VALUES 
  ((SELECT id FROM equipe WHERE nome = 'Equipe de Suporte'), (SELECT id FROM funcionario WHERE nome = 'João Silva')),
  ((SELECT id FROM equipe WHERE nome = 'Equipe de Desenvolvimento'), (SELECT id FROM funcionario WHERE nome = 'Maria Souza')),
  ((SELECT id FROM equipe WHERE nome = 'Equipe de Infraestrutura'), (SELECT id FROM funcionario WHERE nome = 'José Santos'));

-- Populando tabela equipe_projeto
INSERT INTO equipe_projeto (projeto_id, equipe_id)
VALUES 
  ((SELECT id FROM projeto LIMIT 1), (SELECT id FROM equipe LIMIT 1)),
  ((SELECT id FROM projeto LIMIT 1 OFFSET 1), (SELECT id FROM equipe LIMIT 1 OFFSET 1));

-- Populando tabela ativo_ti
INSERT INTO ativo_ti (tipo, descricao, situacao_id, data_compra, data_fim_vida_util, funcionario_id, created_at)
VALUES 
  ('computador', 'Computador HP', (SELECT id FROM situacao WHERE valor = 'Ativo'), '2022-01-15', '2026-01-15', (SELECT id FROM funcionario LIMIT 1), NOW()),
  ('software', 'Licença Microsoft Office', (SELECT id FROM situacao WHERE valor = 'Ativo'), '2022-03-10', NULL, (SELECT id FROM funcionario LIMIT 1 OFFSET 1), NOW());

-- Populando tabela incidente
INSERT INTO incidente (descricao, severidade, situacao_id, funcionario_id, created_at, updated_at)
VALUES 
  ('Problema na impressora', 'Média', (SELECT id FROM situacao WHERE valor = 'Em Andamento'), (SELECT id FROM funcionario LIMIT 1), NOW(), NOW()),
  ('Erro de página não encontrada', 'Alta', (SELECT id FROM situacao WHERE valor = 'Concluído'), (SELECT id FROM funcionario LIMIT 1 OFFSET 1), NOW(), NOW());

-- Populando tabela treinamento_ti
INSERT INTO treinamento_ti (descricao, data_hora, created_at)
VALUES 
  ('Treinamento de Segurança da Informação', '2024-06-20 09:00:00', NOW()),
  ('Curso de Python Avançado', '2024-07-10 13:30:00', NOW());

-- Populando tabela treinamento_funcionario
INSERT INTO treinamento_funcionario (treinamento_id, funcionario_id)
VALUES 
  ((SELECT id FROM treinamento_ti LIMIT 1), (SELECT id FROM funcionario LIMIT 1)),
  ((SELECT id FROM treinamento_ti LIMIT 1 OFFSET 1), (SELECT id FROM funcionario LIMIT 1 OFFSET 1));

-- Populando tabela equipe_area
INSERT INTO equipe_area (equipe_id, area_id)
VALUES 
  ((SELECT id FROM equipe LIMIT 1), (SELECT id FROM area LIMIT 1)),
  ((SELECT id FROM equipe LIMIT 1 OFFSET 1), (SELECT id FROM area LIMIT 1 OFFSET 1)),
  ((SELECT id FROM equipe LIMIT 1 OFFSET 2), (SELECT id FROM area LIMIT 1 OFFSET 2));