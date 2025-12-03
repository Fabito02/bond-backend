
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL
);


CREATE TABLE categorias (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) UNIQUE NOT NULL,
    descricao TEXT,
    cor VARCHAR(7) DEFAULT '#3498db',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


INSERT INTO categorias (nome, descricao, cor) VALUES
('Medicação', 'Medicamentos e remédios', '#e74c3c'),
('Água', 'Consumo de água', '#3498db'),
('Alimentação', 'Refeições e lanches', '#2ecc71'),
('Exercício', 'Atividades físicas', '#9b59b6'),
('Outros', 'Outras atividades', '#f39c12');


CREATE TABLE tipos_repeticao (
    id INT PRIMARY KEY AUTO_INCREMENT,
    codigo VARCHAR(20) UNIQUE NOT NULL,
    nome VARCHAR(50) NOT NULL,
    descricao TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


INSERT INTO tipos_repeticao (codigo, nome, descricao) VALUES
('diario', 'Diário', 'Repete todos os dias'),
('semanal', 'Semanal', 'Repete uma vez por semana'),
('mensal', 'Mensal', 'Repete uma vez por mês'),
('unico', 'Único', 'Apenas uma vez');


CREATE TABLE dispensers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(200) NOT NULL,
    descricao TEXT,
    user_id INT NOT NULL,
    categoria_id INT NOT NULL,
    tipo_repeticao_id INT NOT NULL,
    volume DECIMAL(10,2),
    hora TIME NOT NULL,
    data_inicio DATE NOT NULL,
    ativo BOOLEAN DEFAULT true,
    data_fim DATE NULL,
    imagem_url VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (categoria_id) REFERENCES categorias(id),
    FOREIGN KEY (tipo_repeticao_id) REFERENCES tipos_repeticao(id)
);


CREATE TABLE dispenser_logs (
    id INT PRIMARY KEY AUTO_INCREMENT,
    dispenser_id INT NOT NULL,
    user_id INT NOT NULL,
    data_execucao DATE NOT NULL,
    hora_execucao TIME NOT NULL,
    status VARCHAR(20) DEFAULT 'pendente' 
        CHECK (status IN ('pendente', 'realizado', 'ignorado', 'atrasado')),
    realizado_em TIMESTAMP NULL,
    observacao TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (dispenser_id) REFERENCES dispensers(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id),
    UNIQUE KEY unique_dispenser_data (dispenser_id, data_execucao)
);