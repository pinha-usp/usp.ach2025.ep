# Enunciado textual para visão

A tabela de usuários possui informações sensíveis como senha e email. Como o
perfil do usuário no sistema mostra todos os seus documentos, seria interessante
criarmos uma visão que encapsule o id, nome e documentos de cada usuário, sem
mostrar as informações sensíveis. Assim, todas as consultas que envolvam
obter informações de documentos de usuários seriam feitas diretamente na visão,
sem a necessidade de acessar a tabela de usuários.
