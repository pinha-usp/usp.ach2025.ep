/**
 * Usuários
 *
 * [id] [nome]
 * 1    Willian
 * 2    Fatima
 * 3    Vagner
 * 4    Luciano
 * 5    Alexandre
 */
INSERT INTO usuario (nome, email, senha, data_nasc) VALUES
('Willian', 'willian@email.com', 'senha_w', '2000-11-11'),
('Fatima', 'fatima@email.com', 'senha_f', '2000-01-01'),
('Vagner', 'vagner@email.com', 'senha_v', '2000-02-02'),
('Luciano', 'luciano@email.com', 'senha_l', '2000-03-03'),
('Alexandre', 'alexandre@email.com', 'senha_a', '2000-04-04');

/**
 * Amizades entre usuários
 *
 * [remetente] [destinatario]
 * Willian     Fatima, Vagner
 * Fatima      Luciano, Alexandre
 * Vagner      Luciano 
 * Luciano     -
 * Alexandre   -
 */
INSERT INTO amizade (id_remetente, id_destinatario) VALUES
(1, 2),
(1, 3),
(2, 4),
(2, 5),
(3, 4);

/**
 * Documentos dos usuários
 *
 * [id] [dono]    [tipo] 
 * 1    Willian   PLANILHA
 * 2    Willian   PLANILHA
 * 3    Willian   DOCUMENTO_TEXTO
 * 4    Willian   FORMULARIO
 * 5    Fatima    PLANILHA
 * 6    Fatima    APRESENTACAO
 * 7    Fatima    APRESENTACAO
 * 8    Fatima    FORMULARIO
 * 9    Vagner    PLANILHA
 * 10   Vagner    APRESENTACAO
 * 11   Vagner    DOCUMENTO_TEXTO
 * 12   Vagner    DOCUMENTO_TEXTO
 * 13   Luciano   PLANILHA
 * 14   Luciano   APRESENTACAO
 * 15   Luciano   FORMULARIO
 * 16   Luciano   FORMULARIO
 * 17   Alexandre PLANILHA
 * 18   Alexandre APRESENTACAO
 * 19   Alexandre DOCUMENTO_TEXTO
 * 20   Alexandre FORMULARIO
 */
INSERT INTO documento (tipo, nome, descricao, id_dono) VALUES
('PLANILHA', 'Planilha', 'Planilha teste', 1),
('PLANILHA', 'Planilha', 'Planilha teste', 1),
('DOCUMENTO_TEXTO', 'Documento de texto', 'Documento de texto teste', 1),
('FORMULARIO', 'Formulario', 'Formulario teste', 1),
('PLANILHA', 'Planilha', 'Planilha teste', 2),
('APRESENTACAO', 'Apresentacao', 'Apresentacao teste', 2),
('APRESENTACAO', 'Apresentacao', 'Apresentacao teste', 2),
('FORMULARIO', 'Formulario', 'Formulario teste', 2),
('PLANILHA', 'Planilha', 'Planilha teste', 3),
('APRESENTACAO', 'Apresentacao', 'Apresentacao teste', 3),
('DOCUMENTO_TEXTO', 'Documento de texto', 'Documento de texto teste', 3),
('DOCUMENTO_TEXTO', 'Documento de texto', 'Documento de texto teste', 3),
('PLANILHA', 'Planilha', 'Planilha teste', 4),
('APRESENTACAO', 'Apresentacao', 'Apresentacao teste', 4),
('FORMULARIO', 'Formulario', 'Formulario teste', 4),
('FORMULARIO', 'Formulario', 'Formulario teste', 4),
('PLANILHA', 'Planilha', 'Planilha teste', 5),
('APRESENTACAO', 'Apresentacao', 'Apresentacao teste', 5),
('DOCUMENTO_TEXTO', 'Documento de texto', 'Documento de texto teste', 5),
('FORMULARIO', 'Formulario', 'Formulario teste', 5);

/**
 * Contribuição de usuários em documentos de outros usuários
 *
 * [documento]  [dono]    [contribuidor]
 * 1            Willian   Fatima, Alexandre
 * 2            Willian   Vagner
 * 3            Willian   -
 * 4            Willian   -
 * 5            Fatima    Willian, Luciano
 * 6            Fatima    Willian, Vagner, Alexandre
 * 7            Fatima    -
 * 8            Fatima    -
 * 9            Vagner    -
 * 10           Vagner    Willian, Luciano 
 * 11           Vagner    Fatima, Alexandre
 * 12           Vagner    Luciano, Alexandre
 * 13           Luciano   Fatima
 * 14           Luciano   -
 * 15           Luciano   -
 * 16           Luciano   Vagner, Alexandre
 * 17           Alexandre Willian, Luciano
 * 18           Alexandre -
 * 19           Alexandre Fatima, Vagner
 * 20           Alexandre Willian
 */
INSERT INTO contribuicao (id_documento, id_usuario) VALUES
(1, 2),
(1, 5),
(2, 3),
(5, 1),
(5, 4),
(6, 1),
(6, 3),
(6, 5),
(10, 1),
(10, 4),
(11, 2),
(11, 5),
(12, 4),
(12, 5),
(13, 2),
(16, 3),
(16, 5),
(17, 1),
(17, 4),
(19, 2),
(19, 3),
(20, 1);

/**
 * Planilhas
 */
INSERT INTO planilha (id_documento, largura_linhas, largura_colunas) VALUES
(2, 10, 10),
(5, 5, 10),
(9, 7, 9),
(13, 8, 8),
(17, 4, 4);

/**
 * Células das planilhas
 */
INSERT INTO celula (id_planilha, linha, coluna, conteudo, cor) VALUES
(2, 'a', 'a', 'Conteudo da celula', '#008744'),
(2, 'a', 'b', 'Conteudo da celula', '#0057e7'),
(2, 'b', 'b', 'Conteudo da celula', '#d62d20'),
(2, 'b', 'c', 'Conteudo da celula', '#ffa700'),
(2, 'c', 'c', 'Conteudo da celula', '#ffffff'),
(5, 'a', 'a', 'Conteudo da celula', '#008744'),
(5, 'a', 'b', 'Conteudo da celula', '#0057e7'),
(5, 'b', 'b', 'Conteudo da celula', '#d62d20'),
(5, 'b', 'c', 'Conteudo da celula', '#ffa700'),
(5, 'c', 'c', 'Conteudo da celula', '#ffffff'),
(9, 'a', 'a', 'Conteudo da celula', '#008744'),
(9, 'a', 'b', 'Conteudo da celula', '#0057e7'),
(9, 'b', 'b', 'Conteudo da celula', '#d62d20'),
(9, 'b', 'c', 'Conteudo da celula', '#ffa700'),
(9, 'c', 'c', 'Conteudo da celula', '#ffffff'),
(13, 'a', 'a', 'Conteudo da celula', '#008744'),
(13, 'a', 'b', 'Conteudo da celula', '#0057e7'),
(13, 'b', 'b', 'Conteudo da celula', '#d62d20'),
(13, 'b', 'c', 'Conteudo da celula', '#ffa700'),
(13, 'c', 'c', 'Conteudo da celula', '#ffffff'),
(17, 'a', 'a', 'Conteudo da celula', '#008744'),
(17, 'a', 'b', 'Conteudo da celula', '#0057e7'),
(17, 'b', 'b', 'Conteudo da celula', '#d62d20'),
(17, 'b', 'c', 'Conteudo da celula', '#ffa700'),
(17, 'c', 'c', 'Conteudo da celula', '#ffffff');

/**
 * Documentos de texto
 */
INSERT INTO documento_texto (id_documento, fonte, tamanho_fonte) VALUES
(3, 'ARIAL', 12),
(11, 'TIMES_NEW_ROMAN', 18),
(12, 'TIMES_NEW_ROMAN', 22),
(19, 'COURIER_NEW', 96);

/**
 * Blocos de texto dos documentos de texto
 */
INSERT INTO bloco_texto (id_documento_texto, titulo, conteudo) VALUES
(3, 'Titulo A1', 'Conteudo A1'),
(3, 'Titulo B1', 'Conteudo B1'),
(3, 'Titulo C1', 'Conteudo C1'),
(3, 'Titulo D1', 'Conteudo D1'),
(11, 'Titulo A2', 'Conteudo A2'),
(11, 'Titulo B2', 'Conteudo B2'),
(11, 'Titulo C2', 'Conteudo C2'),
(11, 'Titulo D2', 'Conteudo D2'),
(12, 'Titulo A3', 'Conteudo A3'),
(12, 'Titulo B3', 'Conteudo B3'),
(12, 'Titulo C3', 'Conteudo C3'),
(12, 'Titulo D3', 'Conteudo D3'),
(19, 'Titulo A4', 'Conteudo A4'),
(19, 'Titulo B4', 'Conteudo B4'),
(19, 'Titulo C4', 'Conteudo C4'),
(19, 'Titulo D4', 'Conteudo D4');

/**
 * Formulários
 */
INSERT INTO formulario (id_documento, data_limite) VALUES
(4, '2023-01-01'),
(8, '2023-02-02'),
(15, '2023-03-03'),
(16, '2023-04-04'),
(20, '2023-05-05');

/**
 * Perguntas dos formulários
 */
INSERT INTO pergunta (id_formulario, conteudo) VALUES
(4, 'Pergunta A1?'),
(4, 'Pergunta B1?'),
(4, 'Pergunta C1?'),
(4, 'Pergunta D1?'),
(8, 'Pergunta A2?'),
(8, 'Pergunta B2?'),
(8, 'Pergunta C2?'),
(8, 'Pergunta D2?'),
(15, 'Pergunta A3?'),
(15, 'Pergunta B3?'),
(15, 'Pergunta C3?'),
(15, 'Pergunta D3?'),
(16, 'Pergunta A4?'),
(16, 'Pergunta B4?'),
(16, 'Pergunta C4?'),
(16, 'Pergunta D4?'),
(20, 'Pergunta A5?'),
(20, 'Pergunta B5?'),
(20, 'Pergunta C5?'),
(20, 'Pergunta D5?');

/**
 * Respostas dos formulários
 *
 * [pergunta] [usuario]
 * 4          Willian, Fatima
 * 8          Vagner, Luciano, Alexandre
 * 15         Willian, Fatima, Vagner, Luciano, Alexandre
 * 16         Fatima, Vagner
 * 20         Willian, Vagner, Alexandre 
 */
INSERT INTO resposta (id_pergunta, id_usuario, conteudo) VALUES
(4, 1, 'Resposta A1'),
(4, 2, 'Resposta B1'),
(8, 3, 'Resposta A2'),
(8, 4, 'Resposta B2'),
(8, 5, 'Resposta C2'),
(15, 1, 'Resposta A3'),
(15, 2, 'Resposta B3'),
(15, 3, 'Resposta C3'),
(15, 4, 'Resposta D3'),
(15, 5, 'Resposta E3'),
(16, 2, 'Resposta A4'),
(16, 3, 'Resposta B4'),
(20, 1, 'Resposta A5'),
(20, 3, 'Resposta B5'),
(20, 5, 'Resposta C5');

/**
 * Apresentações
 */
INSERT INTO apresentacao (id_documento, objetivo) VALUES
(6, 'Objetivo teste'),
(7, 'Objetivo teste'),
(10, 'Objetivo teste'),
(14, 'Objetivo teste'),
(18, 'Objetivo teste');

/**
 * Slides das apresentações
 */
INSERT INTO slide (id_apresentacao, titulo, subtitulo, imagem, conteudo) VALUES
(6, 'Titulo A', 'Subtitulo A', 'https://imagem.com/a.png', 'Conteudo A'),
(6, 'Titulo B', 'Subtitulo B', 'https://imagem.com/b.png', 'Conteudo B'),
(6, 'Titulo C', 'Subtitulo C', 'https://imagem.com/c.png', 'Conteudo C'),
(6, 'Titulo D', 'Subtitulo D', 'https://imagem.com/d.png', 'Conteudo D'),
(7, 'Titulo A', 'Subtitulo A', 'https://imagem.com/a.png', 'Conteudo A'),
(7, 'Titulo B', 'Subtitulo B', 'https://imagem.com/b.png', 'Conteudo B'),
(7, 'Titulo C', 'Subtitulo C', 'https://imagem.com/c.png', 'Conteudo C'),
(7, 'Titulo D', 'Subtitulo D', 'https://imagem.com/d.png', 'Conteudo D'),
(10, 'Titulo A', 'Subtitulo A', 'https://imagem.com/a.png', 'Conteudo A'),
(10, 'Titulo B', 'Subtitulo B', 'https://imagem.com/b.png', 'Conteudo B'),
(10, 'Titulo C', 'Subtitulo C', 'https://imagem.com/c.png', 'Conteudo C'),
(10, 'Titulo D', 'Subtitulo D', 'https://imagem.com/d.png', 'Conteudo D'),
(14, 'Titulo A', 'Subtitulo A', 'https://imagem.com/a.png', 'Conteudo A'),
(14, 'Titulo B', 'Subtitulo B', 'https://imagem.com/b.png', 'Conteudo B'),
(14, 'Titulo C', 'Subtitulo C', 'https://imagem.com/c.png', 'Conteudo C'),
(14, 'Titulo D', 'Subtitulo D', 'https://imagem.com/d.png', 'Conteudo D'),
(18, 'Titulo A', 'Subtitulo A', 'https://imagem.com/a.png', 'Conteudo A'),
(18, 'Titulo B', 'Subtitulo B', 'https://imagem.com/b.png', 'Conteudo B'),
(18, 'Titulo C', 'Subtitulo C', 'https://imagem.com/c.png', 'Conteudo C'),
(18, 'Titulo D', 'Subtitulo D', 'https://imagem.com/d.png', 'Conteudo D');