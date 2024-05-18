-------- Atualizar aprovação de funcionário no treinamento mediante a nota---------
create or replace function aprovar_funcionario_treinamento ()
RETURNS TRIGGER as $$

DECLARE

	aprovacao bool;
	nota_funcionario float;
	data_aprovacao timestamp;
begin 
	SELECT 
		treinamento_funcionario.nota_final, CURRENT_TIMESTAMP INTO nota_funcionario, data_aprovacao
	from treinamento_funcionario 
	where treinamento_funcionario.treinamento_id = new.treinamento_id AND treinamento_funcionario.funcionario_id = NEW.funcionario_id
	
	IF nota_funcionario IS NULL THEN 
		UPDATE treinamento_funcionario 
			SET aprovado = NULL;	
		where treinamento_funcionario.treinamento_id = new.treinamento_id AND treinamento_funcionario.funcionario_id = NEW.funcionario_id
	
	ELSIF nota_funcionario >= 7 THEN 
		UPDATE treinamento_funcionario 
			SET aprovado = TRUE, data_conclusão = data_aprovacao;
		where treinamento_funcionario.treinamento_id = new.treinamento_id AND treinamento_funcionario.funcionario_id = NEW.funcionario_id
	
	ELSE 
		UPDATE treinamento_funcionario 
			SET aprovado = FALSE;
		where treinamento_funcionario.treinamento_id = new.treinamento_id AND treinamento_funcionario.funcionario_id = NEW.funcionario_id
		
	END IF;
	
	RETURN NEW;

end;
$$ LANGUAGE plpgsql;

create trigger atualizar_aprovacao_funcionario_treinamento
after insert or update ON treinamento_funcionario 

for each row

execute function aprovar_funcionario_treinamento();


-------------------Trigger para deletar funcionário de equipe--------------------------


CREATE OR REPLACE FUNCTION funcionario_deletado_remover_equipes ()
RETURNS TRIGGER AS $$

DECLARE 
	funcionario_deletado bool;
BEGIN 
	SELECT 
		deleted INTO funcionario_deletado
	FROM equipe_funcionario
	WHERE equipe_funcionario.funcionario_id = NEW.id
	
	IF funcionario_deletado = TRUE THEN
	UPDATE equipe_funcionario 
		SET deleted = TRUE;
	WHERE equipe_funcionario.funcionario_id = NEW.id
	
	END IF;

	RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER funcionario_deletado
AFTER INSERT OR UPDATE ON funcionario
FOR EACH ROW
EXECUTE FUNCTION funcionario_deletado_remover_equipes ()

-------------- trigger Atualizar situação de projeto ------------------------


CREATE OF REPLACE FUNCTION atualizar_situacao_projeto ()
RETURNS TRIGGER AS $$

DECLARE
	status_projeto varchar;
	data_da_conclusao timestamp;
BEGIN
	SELECT 
		projeto.data_conclusao  INTO data_da_conclusao
	FROM projeto
	WHERE projeto.id = NEW.id
	
	IF data_da_conclusao IS NOT NULL THEN 
		SELECT 
			id INTO status_projeto
		FROM situacao
		WHERE situacao.valor = 'Concluido'	-- forçar o texto direto NO lugar
	
		UPDATE projeto
			SET projeto.situacao_id = status_projeto
		WHERE projeto.id = NEW.id
	
	END IF;
	
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER atualizar_status_projeto
AFTER INSERT OR UPDATE ON projeto
FOR EACH ROW
EXECUTE FUNCTION atualizar_situacao_projeto()