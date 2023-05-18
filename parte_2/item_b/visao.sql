CREATE VIEW documentos_usuarios AS
SELECT
    u.id as id_usuario,
    u.nome as nome_usuario,
    d.id as id_documento,
    d.nome as nome_documento,
    d.descricao as descricao_documento,
    d.data_criacao as data_criacao_documento,
    COUNT(c.id_usuario) as numero_contribuidores
FROM usuario u
JOIN documento d ON u.id = d.id_dono
JOIN contribuicao c ON d.id = c.id_documento
GROUP BY u.id, d.id;
