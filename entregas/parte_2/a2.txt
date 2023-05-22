-- Gatilho 1

CREATE OR REPLACE FUNCTION verificar_data_formulario()
RETURNS TRIGGER
AS
$$
DECLARE
    id_formulario INT;
    data_limite DATE;

BEGIN
    SELECT
        f.id_documento,
        f.data_limite
    INTO
        id_formulario,
        data_limite
    FROM formulario f
    JOIN pergunta p ON p.id_formulario = f.id_documento
    WHERE p.id = NEW.id_pergunta;

    IF (data_limite < CURRENT_DATE) THEN
        RAISE EXCEPTION
            'Formulário % não aceita mais respostas. Data limite: %',
            id_formulario,
            data_limite;
    END IF;

    RETURN NEW;
END
$$
LANGUAGE plpgsql;

CREATE TRIGGER verificar_data_formulario
BEFORE INSERT OR UPDATE ON resposta 
FOR EACH ROW
EXECUTE PROCEDURE verificar_data_formulario();

-- Gatilho 2

CREATE OR REPLACE FUNCTION inicializar_documento()
RETURNS TRIGGER
AS
$$
BEGIN
    CASE NEW.tipo
        WHEN 'PLANILHA' THEN
            INSERT INTO planilha (id_documento, largura_linhas, largura_colunas)
            VALUES (NEW.id, 10, 10);

        WHEN 'DOCUMENTO_TEXTO' THEN
            INSERT INTO documento_texto (id_documento, fonte, tamanho_fonte)
            VALUES (NEW.id, 'ARIAL', 12);

        WHEN 'FORMULARIO' THEN
            INSERT INTO formulario (id_documento, data_limite)
            VALUES (NEW.id, CURRENT_DATE + INTERVAL '1' MONTH);

        WHEN 'APRESENTACAO' THEN
            INSERT INTO apresentacao (id_documento, objetivo)
            VALUES (NEW.id, 'Apresentação de slides');
    END CASE;

    RAISE NOTICE 'Documento % inicializado', NEW.id;

    RETURN NEW;
END
$$
LANGUAGE plpgsql;

CREATE TRIGGER inicializar_documento
AFTER INSERT ON documento
FOR EACH ROW
EXECUTE PROCEDURE inicializar_documento();
