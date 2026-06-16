DROP USER IF EXISTS 'recepcionista'@'localhost';
DROP USER IF EXISTS 'veterinario'@'localhost';
DROP USER IF EXISTS 'gerente'@'localhost';
DROP USER IF EXISTS 'admin'@'localhost';

CREATE USER 'recepcionista'@'localhost' IDENTIFIED BY 'SenhaRec123';
CREATE USER 'veterinario'@'localhost' IDENTIFIED BY 'SenhaVet123';
CREATE USER 'gerente'@'localhost' IDENTIFIED BY 'SenhaGer123';
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'SenhaAdm123';

GRANT SELECT, INSERT ON db_pet_vida.tutores TO 'recepcionista'@'localhost';
GRANT SELECT, INSERT ON db_pet_vida.animais TO 'recepcionista'@'localhost';
GRANT SELECT, INSERT ON db_pet_vida.consultas TO 'recepcionista'@'localhost';
GRANT SELECT, INSERT ON db_pet_vida.especies TO 'recepcionista'@'localhost';

GRANT EXECUTE ON PROCEDURE db_pet_vida.sp_agendar_consulta TO 'recepcionista'@'localhost';
GRANT EXECUTE ON PROCEDURE db_pet_vida.sp_cadastrar_animal TO 'recepcionista'@'localhost';

GRANT SELECT ON db_pet_vida.* TO 'veterinario'@'localhost';
GRANT UPDATE (diagnostico, status) ON db_pet_vida.consultas TO 'veterinario'@'localhost';
GRANT EXECUTE ON PROCEDURE db_pet_vida.sp_concluir TO 'veterinario'@'localhost';

GRANT SELECT, INSERT, UPDATE ON db_pet_vida.* TO 'gerente'@'localhost';
GRANT DELETE ON db_pet_vida.consultas TO 'gerente'@'localhost';
GRANT EXECUTE ON db_pet_vida.* TO 'gerente'@'localhost';

GRANT ALL PRIVILEGES ON db_pet_vida.* TO 'admin'@'localhost';

REVOKE INSERT ON db_pet_vida.tutores FROM 'recepcionista'@'localhost';
REVOKE INSERT ON db_pet_vida.animais FROM 'recepcionista'@'localhost';
REVOKE INSERT ON db_pet_vida.consultas FROM 'recepcionista'@'localhost';
REVOKE INSERT ON db_pet_vida.especies FROM 'recepcionista'@'localhost';

FLUSH PRIVILEGES;
