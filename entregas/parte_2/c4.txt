/**
 * Seleciona o número de documentos criados por cada amizade de Fátima na última
 * semana 
 */
SELECT
    id_amigo,
    COUNT(*) AS quantidade_documentos
FROM atividades_amizades_fatima
GROUP BY id_amigo;

/**
 * Seleciona todas as amizades de Fátima que criaram documentos ontem
 */
SELECT
    id_amigo
FROM atividades_amizades_fatima
WHERE data_criacao_documento = NOW() - INTERVAL '1 day';
