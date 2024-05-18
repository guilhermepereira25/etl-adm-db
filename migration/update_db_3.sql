CREATE TABLE "sistema" (
  "id" uuid PRIMARY KEY,
  "nome" varchar(100),
  "deleted" bool
);

CREATE TABLE "perfil" (
  "id" uuid PRIMARY KEY,
  "nome" varchar(100),
  "deleted" bool
);

CREATE TABLE "permissao" (
  "id" uuid PRIMARY KEY,
  "nome" varchar(100),
  "deleted" bool
);

CREATE TABLE "funcionario_sistema" (
  "id" uuid PRIMARY KEY,
  "perfil_id" uuid,
  "funcionario_id" uuid,
  "sistema_id" uuid,
  "deleted" bool
);

CREATE TABLE "perfil_permissao" (
  "id" uuid PRIMARY KEY,
  "perfil_id" uuid,
  "permissao_id" uuid,
  "deleted" bool
);

ALTER TABLE "funcionario_sistema" ADD FOREIGN KEY ("perfil_id") REFERENCES "perfil" ("id");

ALTER TABLE "funcionario_sistema" ADD FOREIGN KEY ("funcionario_id") REFERENCES "funcionario" ("id");

ALTER TABLE "funcionario_sistema" ADD FOREIGN KEY ("sistema_id") REFERENCES "sistema" ("id");

ALTER TABLE "perfil_permissao" ADD FOREIGN KEY ("perfil_id") REFERENCES "perfil" ("id");

ALTER TABLE "perfil_permissao" ADD FOREIGN KEY ("permissao_id") REFERENCES "permissao" ("id");
