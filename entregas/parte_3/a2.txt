/**
 * Aqui, adicionamos um campo respostas do tipo array de textos à tabela pergunta.
 * A tabela resposta poderia ser excluída, porém deixamos ela para mantermos a
 * semântica das consultas da parte 1 válidas.
 *
 * Com isso, podemos armazenar as respostas de uma pergunta em um único campo,
 * sem a necessidade de criar uma tabela para isso. Assim não precisamos fazer
 * joins para recuperar as respostas de uma pergunta.
 */
 
ALTER TABLE pergunta ADD COLUMN respostas TEXT[];
