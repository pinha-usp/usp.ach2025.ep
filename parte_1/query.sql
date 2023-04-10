/**
 * As consultas foram feitas com base em requisitos que de fato seriam encontrados
 * no sistema USP Drive. Nenhuma dessas consultas é dispensável
 * 
 * Como no sistema normalmente as consultas seriam feitas com base em informações
 * de um usuário já logado, elas contém uma cláusula WHERE que filtra os resultados
 * de acordo com o email do usuário logado
 */

/**
 * Seleciona o id, tipo, nome, descrição e número de contribuidores de todos os
 * documentos de um usuário com um email em específico
 */
SELECT
    d.id,
    d.tipo,
    d.nome,
    d.descricao,
    COUNT(c.id_documento) AS numero_contribuidores
FROM documento d
INNER JOIN usuario u ON u.id = d.id_dono
LEFT JOIN contribuicao c ON d.id = c.id_documento
WHERE u.email = 'willian@email.com'
GROUP BY d.id;

/**
 * Seleciona o id e a data limite de todos os formulários de um usuário com um
 * email em específico e o número de usuários que responderam ao menos uma pergunta
 * de cada formulário
 */
SELECT
    f.id_documento,
    f.data_limite,
    COUNT(DISTINCT r.id_usuario) as numero_respostas
FROM formulario f
INNER JOIN documento d ON f.id_documento = d.id
INNER JOIN usuario u ON d.id_dono = u.id
LEFT JOIN pergunta p ON f.id_documento = p.id_formulario
LEFT JOIN resposta r ON p.id = r.id_pergunta
WHERE u.email = 'luciano@email.com'
GROUP BY f.id_documento;

/**
 * Seleciona o id, tipo, nome e descrição de todos os documentos não inicializados
 * de um usuário com um email em específico
 *
 * De todas as soluções especificadas na consulta abaixo e nas observações,
 * provavelmente a da observação 2 é a mais indicada (apesar de trazer redundância),
 * pois é a que tem a melhor performance e a menor complexidade de consulta
 *
 * Observação 1: Um documento não inicializado é aquele em que um registro da tabela 
 * "documento" não está relacionado com nenhum registro de nenhuma das suas tabelas
 * filhas (planilha, formulario, documento_texto, apresentacao)
 *
 * Observação 2: Uma possível alternativa para essa consulta seria ter um campo
 * booleano indicando se um documento foi inicializado ou não. Note que essa solução
 * traz redundância de dados, pois o mesmo resultado poderia ser obtido com a consulta
 * abaixo, e seria necessário manter o campo booleano atualizado sempre que um
 * documento fosse inicializado
 *
 * Observação 3: Outra possível alternativa seria utilizar um JOIN para cada tabela
 * filha de documento, e verificar se os campos id_documento de cada tabela filha
 * são nulos ou não. Essa solução pode ser menos eficiente por ter muitos JOINs
 *
 * Observação 4: Outra possível alternativa seria selecionar todos os documentos
 * de um usuário, e programaticamente fazer uma consulta para cada documento para
 * verificar com base em seu tipo se ele foi inicializado ou não, verificando em
 * sua tabela corresondente. Essa solução é com certeza a mais lenta de todas,
 * ainda mais se o usuário tiver muitos documentos
 */
SELECT
    d.id,
    d.tipo,
    d.nome,
    d.descricao
FROM documento d
INNER JOIN usuario u ON d.id_dono = u.id
WHERE u.email = 'willian@email.com' 
AND NOT EXISTS (
    SELECT 1
    FROM planilha p
    WHERE p.id_documento = d.id 
) AND NOT EXISTS (
    SELECT 1
    FROM formulario f
    WHERE f.id_documento = d.id
) AND NOT EXISTS (
    SELECT 1
    FROM documento_texto dt
    WHERE dt.id_documento = d.id
) AND NOT EXISTS (
    SELECT 1
    FROM apresentacao a
    WHERE a.id_documento = d.id
);

/**
 * Seleciona o id, nome, descrição e data de criação dos documentos que foram
 * criados na última semana por todos os amigos de um usuário com um email em
 * específico. Também deve ser selecionado o nome do amigo que criou o documento.
 * Os resultados devem ser ordenados por data de criação, do mais recente para o
 * mais antigo
 */
WITH amigos_usuario AS (
    SELECT
        u.id,
        u.nome
    FROM usuario u
    INNER JOIN amizade a ON u.id = a.id_remetente OR u.id = a.id_destinatario
    INNER JOIN usuario u2 ON
        (u.id = a.id_remetente AND u2.id = a.id_destinatario) OR
        (u.id = a.id_destinatario AND u2.id = a.id_remetente)
    WHERE u2.email = 'fatima@email.com'
)
SELECT
    d.id,
    d.nome,
    d.descricao,
    d.data_criacao,
    a.nome AS nome_amigo
FROM documento d
INNER JOIN amigos_usuario a ON d.id_dono = a.id
WHERE d.data_criacao >= NOW() - INTERVAL '1 week'
ORDER BY d.data_criacao DESC;