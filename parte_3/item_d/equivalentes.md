# Comparação de consultas equivalentes

## Consulta original

```sql
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
```

![](https://github.com/willpinha/willpinha/assets/86596621/5022517d-dfda-4333-8f48-ae31716316a5)

## Consulta equivalente 1

```sql
SELECT
    d.id,
    d.nome,
    d.descricao,
    d.data_criacao,
    a.nome AS nome_amigo
FROM documento d
INNER JOIN (
    SELECT
        u.id,
        u.nome
    FROM usuario u
    INNER JOIN amizade a ON u.id = a.id_remetente OR u.id = a.id_destinatario
    INNER JOIN usuario u2 ON
        (u.id = a.id_remetente AND u2.id = a.id_destinatario) OR
        (u.id = a.id_destinatario AND u2.id = a.id_remetente)
    WHERE u2.email = 'fatima@email.com'
) AS a ON d.id_dono = a.id
WHERE d.data_criacao >= NOW() - INTERVAL '1 week'
ORDER BY d.data_criacao DESC;
```

![](https://github.com/willpinha/willpinha/assets/86596621/ee042cdf-a1c4-4fb3-b4b2-d8a37c232654)

## Consulta equivalente 2

```sql
SELECT
    d.id,
    d.nome,
    d.descricao,
    d.data_criacao,
    u.nome AS nome_amigo
FROM documento d
INNER JOIN usuario u ON d.id_dono = u.id
INNER JOIN amizade a ON
    (u.id = a.id_remetente OR u.id = a.id_destinatario) AND
    (u.id = a.id_remetente OR u.id = a.id_destinatario)
INNER JOIN usuario u2 ON
    (u.id = a.id_remetente AND u2.id = a.id_destinatario) OR
    (u.id = a.id_destinatario AND u2.id = a.id_remetente)
WHERE
    u2.email = 'fatima@email.com' AND
    d.data_criacao >= NOW() - INTERVAL '1 week'
ORDER BY d.data_criacao DESC;
```

![](https://github.com/willpinha/willpinha/assets/86596621/18405ab1-2475-4767-9271-f902bb7e680c)

## Comparação

A consulta equivalente 1 possui o mesmo plano de execução de consulta que a
consulta original. No entanto, a consulta equivalente 2, por mais que possua o
mesmo plano de execução, possui um custo ligeiramente maior. Essa alteração pode
ter ocorrido por conta da mudança de estatísticas sobre os dados que o
otimizador utiliza para gerar o plano de execução.
