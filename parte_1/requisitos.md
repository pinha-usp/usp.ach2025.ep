# Requisitos do sistema de Banco de Dados

> Referente ao item (a)

Meu projeto simulará simplificadamente o serviço de armazenamento Google Drive.
Ele se chamará USP Drive, e será um sistema centralizado, ou seja, não distribuído
(como é o Google Drive), e portanto o banco de dados relacional ficará em um único
servidor. Os requisitos para o sistema de banco de dados se encontram nos próximos
parágrafos.

No USP Drive, existem diversos usuários que podem acessá-lo. Cada usuário terá nome,
email, senha e data de nascimento. Também é necessário saber a data de ingresso do
usuário no sistema. Cada usuário pode ter diversos contatos, que são outros usuários.

Existem quatro tipos de documentos no USP Drive: planilhas, documentos de texto,
apresentações e formulários. Cada usuário poderá criar ou contribuir em diversas
instâncias desses documentos. Se o usuário criar uma instância, ele será o dono
do documento, caso contrário, ele será um contribuidor. Cada instância de documento
possui um nome com limite de 64 caracteres e uma descrição com um limite de 256
caracteres.

Cada instância de planilha possui diversas células. Cada célula possui um número
de linha e outro de coluna. O conjunto (linha, coluna) de uma célula deve ser único
na planilha, e as linhas e colunas são representadas cada uma por um único caractere
(a, b, c, …). Cada célula armazena um texto sem limite de caracteres e uma cor RGB
com valor padrão branco.

Cada instância de documento de texto possui múltiplos blocos de texto. Cada bloco
contém um título e um texto, ambos obrigatórios e sem limite de caracteres.

Cada instância de apresentação possui diversos slides. Cada slide armazena múltiplos
elementos, que podem ser: título, caixa de texto ou imagem. O título contém o nome
do título e um subtítulo opcional. Uma caixa de texto contém um texto simples, sem
limite de caracteres. Uma imagem é um binário contendo informações de uma imagem
em qualquer formato (png, jpg, …). Note que cada slide deve ter um único título
obrigatório, e opcionalmente múltiplas caixas de texto e imagens.

Cada instância de formulário possui diversas perguntas. Cada pergunta é associada
com múltiplas alternativas de escolha, sendo necessário no mínimo duas alternativas
criadas por pergunta. Um usuário pode preencher um formulário uma única vez,
escolhendo uma das alternativas por pergunta, e esse preenchimento também deverá
ser armazenado.

Além dos documentos, os usuários também podem armazenar no USP Drive arquivos em
qualquer formato. Cada arquivo conterá um nome obrigatório com limite de 64
caracteres, uma descrição opcional com limite de 256 caracteres e um binário com
o conteúdo do arquivo.
