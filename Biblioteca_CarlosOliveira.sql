CREATE TABLE TiposDeObras 
( 
    codigo varchar(30) not null,
    categoria varchar(30) not null,
    descricao varchar(500), 

    constraint tipos_de_obra CHECK (codigo IN ('Livro','Revista','Outros')),
    constraint check_descricao CHECK (LENGTH(descricao) <= 500),
    constraint check_categoria CHECK (categoria IN ('Fantasia', 'Romance', 'Sci-Fi','Drama','Comedia')),
    constraint pk_codigo PRIMARY KEY (codigo)
);

CREATE TABLE Autores
( 	
    nome_do_autor varchar(150) NOT NULL,
    codigo_obra_autor varchar(30) NOT NULL, 
    
    constraint check_codigo_obra_autor CHECK (LENGTH(codigo_obra_autor) <= 30),
    constraint check_nome_do_autor CHECK (LENGTH(nome_do_autor) <= 150),
    constraint pk_nome_do_autor PRIMARY KEY(nome_do_autor)
);

CREATE TABLE Obras 
( 
    codigo_obra varchar(30) not null, 
    titulo varchar(150) not null, 
    nro_de_paginas numeric(4) not null, 
    tipo_obra_codigo varchar(30) not null,
    autor varchar (150) not null,
 
    constraint check_codigo CHECK (LENGTH(codigo_obra) <= 30),
    constraint check_titulo CHECK (LENGTH(titulo) <= 150),
    constraint check_nro_de_paginas CHECK (nro_de_paginas > 0 and nro_de_paginas <= 10000),
    constraint check_codigo_obra CHECK (LENGTH(tipo_obra_codigo) <= 30),
    constraint fk_autor FOREIGN KEY (autor) REFERENCES Autores(nome_do_autor),
    constraint pk_codigo_obra PRIMARY KEY(codigo_obra), 
    constraint fk_tipo_obra_codigo FOREIGN KEY(tipo_obra_codigo) REFERENCES TiposDeObras(codigo)
);

CREATE TABLE Pessoas 
( 
    cpf char(11) not null, 
    nome varchar(150) not null, 
    email varchar(150) not null, 
    telefone varchar(13) not null, 

    constraint check_cpf CHECK (LENGTH(cpf) = 11),
    constraint check_nome CHECK (LENGTH(nome) <= 150),
    constraint check_telefone CHECK (LENGTH(telefone) = 13),
    constraint check_email CHECK (LENGTH(email) <= 150),
    constraint pk_cpf PRIMARY KEY(cpf),
    constraint ak_nome unique (nome),
    constraint ak_email unique (email),
    constraint ak_telefone unique (telefone)
);

CREATE TABLE Alunos
(  
    cpf_do_aluno char(11) not null,
    nome_do_aluno varchar(150) not null,
    email_do_aluno varchar (150) not null,
    telefone_do_aluno varchar (13) not null,
    nro_de_matricula varchar(9) not null,  
    nro_credito_concluido numeric(5) not null, 

    constraint check_cpf_aluno CHECK (LENGTH(cpf_do_aluno) = 11),
    constraint check_nro_de_matricula CHECK (LENGTH(nro_de_matricula) = 9),
    constraint check_nro_de_creditos CHECK (nro_credito_concluido >= 0 and nro_credito_concluido <= 5),
    constraint fk_email_do_aluno FOREIGN KEY (email_do_aluno) REFERENCES Pessoas(email),
    constraint pk_cpf_do_aluno PRIMARY KEY (cpf_do_aluno)
);

CREATE TABLE Professores
( 
    cpf_do_professor char(11) not null,
    nome_do_professor varchar(150) not null, 
    email_do_professor varchar(150) not null, 
    telefone_do_professor varchar(13) not null,
    data_de_contratacao date not null,
    
    constraint check_cpf_do_prof CHECK (LENGTH(cpf_do_professor) = 11),
    constraint fk_nome_pessoa_professor FOREIGN KEY (nome_do_professor) REFERENCES Pessoas(nome), 
    constraint pk_cpf_do_professor PRIMARY KEY(cpf_do_professor), 
    constraint fk_cpf_pessoa_professor FOREIGN KEY(cpf_do_professor) REFERENCES Pessoas(cpf)
);

CREATE TABLE Emprestimos 
( 
    cpf_da_pessoa char(11) not null, 
    codigo_da_obra VARCHAR(30) not null, 
    codigo_de_emprestimo VARCHAR(30) not null, 
    data_de_emprestimo DATE not null, 
    data_de_devolucao DATE not null, 
    
    constraint check_cpf_da_pessoa CHECK (LENGTH(cpf_da_pessoa) = 11),
    constraint check_codigo_da_obra CHECK (LENGTH(codigo_da_obra) <= 30),
    constraint check_codigo_de_emprestimo CHECK (LENGTH(codigo_de_emprestimo) <= 30),
    constraint check_data_de_emprestimo CHECK (data_de_emprestimo < data_de_devolucao), 
    constraint pk_cpf_codigo_de_emprestimo PRIMARY KEY (cpf_da_pessoa, codigo_da_obra, codigo_de_emprestimo), 
    constraint fk_cpf_da_pessoa FOREIGN KEY (cpf_da_pessoa) REFERENCES Pessoas(cpf), 
    constraint fk_codigo_da_obra FOREIGN KEY (codigo_da_obra) REFERENCES Obras(codigo_obra)
);

INSERT INTO TiposDeObras VALUES ('Livro', 'Fantasia', 'Livros de ficção que envolvem coisas fantasiosas.');
INSERT INTO TiposDeObras VALUES ('Revista', 'Romance', 'Revistas sobre diversas coisas.');
INSERT INTO TiposDeObras VALUES ('Outros', 'Drama', 'Outros tipos de obras.');

INSERT INTO Autores VALUES ('Stan Lee', '00003');
INSERT INTO Autores VALUES ('Rafael Manganes', '00002');
INSERT INTO Autores VALUES ('J.K Rowling', '00001');

INSERT INTO Obras VALUES ('00001', 'Harry Potter e a Pedra Filosofal', 320, 'Livro', 'J.K Rowling');
INSERT INTO Obras VALUES ('00002', 'Veja', 56, 'Revista', 'Rafael Manganes');
INSERT INTO Obras VALUES ('00003', 'Homem Aranha VS Duende Verde', 99, 'Outros', 'Stan Lee');

INSERT INTO Pessoas VALUES ('12345678901', 'João Silva', 'joao.silva@outlook.com', '11 99865-4321');
INSERT INTO Pessoas VALUES ('98765432109', 'Maria Souza', 'maria.souza@outlook.com', '22 95685-6789');
INSERT INTO Pessoas VALUES ('93123013934', 'Helena Cristine', 'helena.cristine@gmail.com', '51 99270-6880');
INSERT INTO Pessoas VALUES ('03460528079', 'Carlos Eduardo Santos Oliveira', 'z4pduz@gmail.com', '51 98225-9281');
INSERT INTO Pessoas VALUES ('12456893245', 'Maria Eduarda Santos Oliveira', 'maria.oliveira@gmail.com', '51 95935-6789');
INSERT INTO Pessoas VALUES ('45678901234', 'Ana Carolina Xavier', 'ana.carolina@gmail.com', '51 98755-5555');
INSERT INTO Pessoas VALUES ('90123456789', 'Kauana Galan', 'kauana.galan@gmail.com', '51 99951-9141');
INSERT INTO Pessoas VALUES ('34567890123', 'Lucas Chaves', 'lucas.chaves@gmail.com', '51 99655-1535');

INSERT INTO Professores VALUES ('12345678901', 'João Silva', 'joao.silva@outlook.com', '11 99865-4321', to_date('2020-01-15','yyyy-mm-dd'));
INSERT INTO Professores VALUES ('98765432109', 'Maria Souza', 'maria.souza@outlook.com', '22 95685-6789', to_date('2018-05-20','yyyy-mm-dd'));
INSERT INTO Professores VALUES ('93123013934', 'Helena Cristine', 'helena.cristine@gmail.com', '51 99270-6880', to_date('2023-05-15','yyyy-mm-dd'));

INSERT INTO Alunos VALUES ('03460528079', 'Carlos Eduardo Santos Oliveira', 'z4pduz@gmail.com', '51 98225-9281', '221111547', 4);
INSERT INTO Alunos VALUES ('12456893245', 'Maria Eduarda Santos Oliveira', 'maria.oliveira@gmail.com', '51 95935-6789', '221111537', 2);
INSERT INTO Alunos VALUES ('45678901234', 'Ana Carolina Xavier', 'ana.carolina@gmail.com', '51 98755-5555', '221723761', 5);
INSERT INTO Alunos VALUES ('90123456789', 'Kauana Galan', 'kauana.galan@gmail.com', '51 99951-9141', '215354237', 1);
INSERT INTO Alunos VALUES ('34567890123', 'Lucas Chaves', 'lucas.chaves@gmail.com', '51 99655-1535', '230223689', 2);

INSERT INTO Emprestimos VALUES ('03460528079', '00001', 'EM001', to_date('2023-05-15','yyyy-mm-dd'), to_date('2023-05-23','yyyy-mm-dd'));
INSERT INTO Emprestimos VALUES ('98765432109', '00002', 'EM002', to_date('2023-06-22','yyyy-mm-dd'), to_date('2023-07-09','yyyy-mm-dd'));
INSERT INTO Emprestimos VALUES ('45678901234', '00001', 'EM003', to_date('2023-10-30','yyyy-mm-dd'), to_date('2023-11-10','yyyy-mm-dd'));
INSERT INTO Emprestimos VALUES ('90123456789', '00003', 'EM004', to_date('2023-10-18','yyyy-mm-dd'), to_date('2023-11-11','yyyy-mm-dd'));
INSERT INTO Emprestimos VALUES ('34567890123', '00002', 'EM005', to_date('2023-12-25','yyyy-mm-dd'), to_date('2024-01-12','yyyy-mm-dd'));
INSERT INTO Emprestimos VALUES ('03460528079', '00003', 'EM006', to_date('2023-11-06','yyyy-mm-dd'), to_date('2023-12-13','yyyy-mm-dd'));
INSERT INTO Emprestimos VALUES ('98765432109', '00001', 'EM007', to_date('2023-09-07','yyyy-mm-dd'), to_date('2023-10-14','yyyy-mm-dd'));
INSERT INTO Emprestimos VALUES ('45678901234', '00002', 'EM008', to_date('2023-09-13','yyyy-mm-dd'), to_date('2023-10-15','yyyy-mm-dd'));
INSERT INTO Emprestimos VALUES ('90123456789', '00003', 'EM009', to_date('2023-01-09','yyyy-mm-dd'), to_date('2023-02-16','yyyy-mm-dd'));
INSERT INTO Emprestimos VALUES ('34567890123', '00001', 'EM010', to_date('2023-02-04','yyyy-mm-dd'), to_date('2023-02-17','yyyy-mm-dd'));

--Pegar Obras que sejam Livros e tenham mais de 100 paginas.
SELECT titulo
FROM Obras
WHERE tipo_obra_codigo = 'Livro' AND nro_de_paginas > 100;

--Media de emprestimos das revistas
SELECT AVG(data_de_devolucao, data_de_emprestimo) AS media
FROM Emprestimos
JOIN Obras ON Emprestimos.codigo_da_obra = Obras.codigo_obra
JOIN TiposDeObras ON Obras.tipo_obra_codigo = TiposDeObras.codigo
WHERE TiposDeObras.codigo = 'Revista';

--Pegar o nome, matricula e nro de creditos de todos os alunos que tenham mais de 1 credito concluido
SELECT nome_do_aluno, nro_de_matricula, nro_credito_concluido
FROM Alunos
WHERE nro_credito_concluido >= 2;


