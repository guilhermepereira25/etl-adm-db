<center>

# Temboard

</center>

## Iniciando docker

Para iniciar o projeto, basta rodar o comando:

```bash
docker compose --profile with-temboard up --build -d;
```

Ou rodar o script
    
```bash
/bin/bash run.sh up_with_temboard;
```

## Acessando o Temboard

Para acessar o Temboard, basta acessar o endereço:

http://localhost:3010

## Configurando agent

Para configurar o agente, basta adicionar o host do agent no temboard.

Agent: `producao.postgressourcedb'

Port: `5432`

Pronto, agora você já pode monitorar o seu banco de dados.