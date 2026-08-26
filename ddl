-- 1. Criação de Tabela Simples
CREATE TABLE Alunos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    data_nascimento DATE,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Alteração de Esquema
ALTER TABLE Alunos ADD COLUMN telefone VARCHAR(20);
ALTER TABLE Alunos ALTER COLUMN nome TYPE VARCHAR(150);

-- 3. Relacionamentos (Chaves Estrangeiras)
CREATE TABLE Cursos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    carga_horaria INT NOT NULL
);

CREATE TABLE Matriculas (
    id SERIAL PRIMARY KEY,
    aluno_id INT REFERENCES Alunos(id) ON DELETE CASCADE,
    curso_id INT REFERENCES Cursos(id) ON DELETE CASCADE,
    data_matricula DATE DEFAULT CURRENT_DATE
);

-- 4. Remoção Segura
CREATE TABLE Temp_Logs (id INT, mensagem TEXT);
TRUNCATE TABLE Temp_Logs;
DROP TABLE IF EXISTS Temp_Logs;

-- 5. Restrições de Integridade
CREATE TABLE Produtos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10, 2) CHECK (preco > 0),
    status VARCHAR(20) DEFAULT 'ativo'
);

-- 6. Modelagem N:N (Autores e Livros)
CREATE TABLE Autores (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE Livros (
    id SERIAL PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL
);

CREATE TABLE Livro_Autor (
    livro_id INT REFERENCES Livros(id) ON DELETE CASCADE,
    autor_id INT REFERENCES Autores(id) ON DELETE CASCADE,
    PRIMARY KEY (livro_id, autor_id)
);
