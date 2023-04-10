# Requisitos do sistema de Banco de Dados

Meu projeto simulará simplificadamente o serviço de armazenamento Google Drive.
Ele se chamará USP Drive, e será um sistema centralizado, ou seja, não distribuído
(como é o Google Drive), e portanto o banco de dados relacional ficará em um único
servidor. Os requisitos para o sistema de banco de dados se encontram nos próximos
parágrafos.

No USP Drive, existem diversos usuários que podem acessá-lo. Cada usuário terá
nome, email, senha e data de nascimento. A imagem do usuário é uma URL para
alguma imagem na internet. A senha deve ter limite de caracteres. Também é
necessário saber a data de ingresso do usuário no sistema. Cada usuário pode ter
diversas amizades opcionais com outros usuários.

Existem quatro tipos de documentos no USP Drive: planilhas, documentos de texto,
apresentações e formulários. Cada usuário poderá criar ou contribuir em diversas
instâncias desses documentos. Se o usuário criar uma instância, ele será o dono
do documento, caso contrário, ele será um contribuidor. Um usuário dono de um
documento não pode ser também um contribuidor do mesmo documento. Cada instância
de documento possui um nome e uma descrição, ambos com limite de caracteres.
Também deve ser armazenado a data de criação do documento.

Cada instância de planilha possui diversas células. Cada célula possui linha e
coluna. O conjunto (linha, coluna) de uma célula deve ser único na planilha, e
as linhas e colunas são representadas cada uma por um único caractere
(a, b, c, …, z). Cada célula armazena um texto sem limite de caracteres e uma
cor hexadecimal com valor padrão branco. A planilha também deve armazenar as
larguras de linha e de coluna.

O usuário poderá acessar um painel onde ficam todas as suas instâncias, mostrando
o título, a descrição e o tipo de documento referente àquela instância, assim como
o número de contribuidores.

Cada instância de documento de texto possui múltiplos blocos de texto. Cada bloco
contém um título e um texto, ambos obrigatórios e sem limite de caracteres. Devem
ser armazenados a fonte (que pode ser Arial, Times New Roman ou Courier New) e o
tamanho da fonte.

Cada instância de apresentação possui diversos slides. Cada slide armazena múltiplos
elementos, que podem ser: título, caixa de texto ou imagem. O título contém o nome
do título e um subtítulo opcional. Uma caixa de texto contém um texto simples,
sem limite de caracteres. Uma imagem é uma URL que aponta para um arquivo de
imagem na internet em qualquer formato (png, jpg, …). Note que cada slide deve
ter um único título obrigatório, e opcionalmente múltiplas caixas de texto e
imagens. A apresentação também deve armazenar um objetivo ou descrição, que indica
o propósito daquela apresentação.

Cada instância de formulário possui diversas perguntas. Cada pergunta é associada
com múltiplas alternativas de escolha, sendo necessário no mínimo duas alternativas
criadas por pergunta. Um usuário pode preencher um formulário uma única vez,
escolhendo uma das alternativas por pergunta, e esse preenchimento também deverá
ser armazenado. O formulário também deve ter uma data limite para conclusão.

Quando o usuário cria uma instância de um dos documentos, ele deve configurá-la
com valores referentes ao tipo de documento antes de usá-la (por exemplo, se o
usuário criar uma instância de planilha, ele deverá especificar as larguras de
linha e coluna antes de poder acessar a planilha em si).
