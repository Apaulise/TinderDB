

-- Tabla Usuarios
CREATE TABLE Usuarios (
    id_usuario INT PRIMARY KEY IDENTITY(1,1),
    nombre NVARCHAR(50),
    edad INT,
    genero NVARCHAR(20),
    ubicacion NVARCHAR(100),
    biografia NVARCHAR(MAX),
    preferencias NVARCHAR(MAX)  -- Esto puede incluir un JSON con rango de edad e intereses, o desglosarse en otra tabla
);

--INSERTS--
INSERT INTO Usuarios (nombre, edad, genero, ubicacion, biografia, preferencias) VALUES
('Agustin', 20, 'Masculino', 'Buenos Aires', 'Amo viajar y conocer gente nueva.', '{"edad_min": 18, "edad_max": 30, "intereses": ["viajes", "tecnología"]}'),
('Lucia', 22, 'Femenino', 'Buenos Aires', 'Fanática de la música y el cine.', '{"edad_min": 20, "edad_max": 30, "intereses": ["música", "cine"]}'),
('Pedro', 25, 'Masculino', 'Córdoba', 'Amo los deportes y la aventura.', '{"edad_min": 20, "edad_max": 30, "intereses": ["deportes", "viajes"]}'),
('Ana', 21, 'Femenino', 'Córdoba', 'Disfruto de los libros y las caminatas.', '{"edad_min": 18, "edad_max": 25, "intereses": ["lectura", "naturaleza"]}'),
('Carlos', 23, 'Masculino', 'Rosario', 'Me gusta la comida y las nuevas experiencias.', '{"edad_min": 20, "edad_max": 30, "intereses": ["gastronomía", "cultura"]}');

INSERT INTO Usuarios (nombre, edad, genero, ubicacion, biografia, preferencias) VALUES 
('Alice', 25, 'F', 'New York', 'Adoro la música y los libros. Aventurera por naturaleza.', '{"rango_edad_min": 24, "rango_edad_max": 30, "intereses": ["música", "viajar", "libros"]}'),
('Bob', 27, 'M', 'Los Angeles', 'Ingeniero de software, apasionado por la tecnología y el senderismo.', '{"rango_edad_min": 24, "rango_edad_max": 28, "intereses": ["tecnología", "senderismo", "cine"]}'),
('Charlie', 30, 'M', 'Chicago', 'Fotógrafo profesional. Siempre en busca de la foto perfecta.', '{"rango_edad_min": 25, "rango_edad_max": 35, "intereses": ["fotografía", "cine", "arte"]}'),
('Diana', 24, 'F', 'San Francisco', 'Amo la naturaleza, los animales y el yoga.', '{"rango_edad_min": 22, "rango_edad_max": 30, "intereses": ["naturaleza", "animales", "yoga"]}'),
('Eve', 28, 'F', 'Miami', 'Chef y amante de los deportes acuáticos. Me encanta cocinar para amigos.', '{"rango_edad_min": 26, "rango_edad_max": 34, "intereses": ["cocina", "deportes acuáticos", "viajes"]}'),
('Frank', 31, 'M', 'Austin', 'Músico y entusiasta de los automóviles clásicos.', '{"rango_edad_min": 28, "rango_edad_max": 35, "intereses": ["música", "automóviles", "viajar"]}'),
('Grace', 26, 'F', 'Boston', 'Artista digital y diseñadora. Exploradora urbana y fan de los museos.', '{"rango_edad_min": 25, "rango_edad_max": 32, "intereses": ["arte", "diseño", "museos"]}'),
('Henry', 29, 'M', 'Seattle', 'Amo la literatura y el té. Escribiendo mi primera novela.', '{"rango_edad_min": 27, "rango_edad_max": 33, "intereses": ["literatura", "escritura", "café"]}'),
('Isabel', 32, 'F', 'San Diego', 'Entusiasta de la tecnología y la ciencia ficción. Aventurera a tiempo completo.', '{"rango_edad_min": 30, "rango_edad_max": 36, "intereses": ["tecnología", "ciencia ficción", "aventuras"]}'),
('Jack', 30, 'M', 'Denver', 'Emprendedor y viajero. Buscando a alguien para nuevas aventuras.', '{"rango_edad_min": 28, "rango_edad_max": 35, "intereses": ["emprendimiento", "viajes", "deportes extremos"]}');


UPDATE Usuarios
SET genero = CASE 
                WHEN genero = 'M' THEN 'Masculino'
                WHEN genero = 'F' THEN 'Femenino'
             END
WHERE genero IN ('M', 'F');





-- Tabla Me gusta
CREATE TABLE Likes (
    id_like INT PRIMARY KEY IDENTITY(1,1),
    id_usuario_origen INT,
    id_usuario_destino INT,
    fecha_like DATETIME,
    CONSTRAINT FK_Likes_UsuarioOrigen FOREIGN KEY (id_usuario_origen) REFERENCES Usuarios(id_usuario),
    CONSTRAINT FK_Likes_UsuarioDestino FOREIGN KEY (id_usuario_destino) REFERENCES Usuarios(id_usuario)
);


--INSERTS-- 

INSERT INTO Likes (id_usuario_origen, id_usuario_destino, fecha_like) VALUES
(1, 2, '2024-10-01 10:00:00'),  -- Agustin le gusta a Lucia
(2, 1, '2024-10-01 11:00:00'),  -- Lucia le gusta a Agustin
(1, 3, '2024-10-02 12:00:00'),  -- Agustin le gusta a Pedro
(3, 4, '2024-10-03 13:00:00'),  -- Pedro le gusta a Ana
(4, 3, '2024-10-04 14:00:00'),  -- Ana le gusta a Pedro
(1, 5, '2024-10-05 15:00:00'),  -- Agustin le gusta a Carlos
(2, 5, '2024-10-06 16:00:00');  -- Lucia le gusta a Carlos


INSERT INTO Likes (id_usuario_origen, id_usuario_destino, fecha_like) VALUES
(1, 2, '2024-10-01 14:30:00'),  -- Alice le da like a Bob
(2, 1, '2024-10-01 14:31:00'),  -- Bob le da like a Alice (Match generado)
(3, 4, '2024-10-01 15:15:00'),  -- Charlie le da like a Diana
(4, 3, '2024-10-01 15:18:00'),  -- Diana le da like a Charlie (Match generado)
(5, 6, '2024-10-02 18:30:00'),  -- Eve le da like a Frank
(6, 5, '2024-10-02 18:32:00'),  -- Frank le da like a Eve (Match generado)
(7, 8, '2024-10-02 12:10:00'),  -- Grace le da like a Henry
(8, 7, '2024-10-02 12:13:00'),  -- Henry le da like a Grace (Match generado)
(1, 3, '2024-10-03 16:50:00'),  -- Alice le da like a Charlie
(3, 1, '2024-10-03 16:54:00'),  -- Charlie le da like a Alice (Match generado)
(2, 5, '2024-10-03 11:25:00'),  -- Bob le da like a Eve
(5, 2, '2024-10-03 11:29:00'),  -- Eve le da like a Bob (Match generado)
(4, 6, '2024-10-03 19:35:00'),  -- Diana le da like a Frank
(6, 4, '2024-10-03 19:39:00'),  -- Frank le da like a Diana (Match generado)
(8, 9, '2024-10-04 17:00:00'),  -- Henry le da like a Isabel
(9, 8, '2024-10-04 17:03:00'),  -- Isabel le da like a Henry (Match generado)
(10, 1, '2024-10-04 13:15:00'), -- Jack le da like a Alice
(1, 10, '2024-10-04 13:18:00'), -- Alice le da like a Jack (Match generado)
(3, 7, '2024-10-04 11:45:00'),  -- Charlie le da like a Grace
(7, 3, '2024-10-04 11:48:00'),  -- Grace le da like a Charlie (Match generado)
(5, 9, '2024-10-05 09:55:00'),  -- Eve le da like a Isabel
(9, 5, '2024-10-05 09:58:00'),  -- Isabel le da like a Eve (Match generado)
(2, 6, '2024-10-05 14:30:00'),  -- Bob le da like a Frank
(6, 2, '2024-10-05 14:34:00'),  -- Frank le da like a Bob (Match generado)
(7, 10, '2024-10-05 16:10:00'), -- Grace le da like a Jack
(10, 7, '2024-10-05 16:13:00'), -- Jack le da like a Grace (Match generado)
(1, 6, '2024-10-06 20:45:00'),  -- Alice le da like a Frank
(6, 1, '2024-10-06 20:48:00'),  -- Frank le da like a Alice (Match generado)
(4, 8, '2024-10-06 11:20:00'),  -- Diana le da like a Henry
(8, 4, '2024-10-06 11:24:00'),  -- Henry le da like a Diana (Match generado)
(9, 10, '2024-10-07 17:55:00'), -- Isabel le da like a Jack
(10, 9, '2024-10-07 17:58:00'), -- Jack le da like a Isabel (Match generado)
(1, 8, '2024-10-07 12:05:00'),  -- Alice le da like a Henry
(8, 1, '2024-10-07 12:09:00'),  -- Henry le da like a Alice (Match generado)
(3, 5, '2024-10-07 16:45:00'),  -- Charlie le da like a Eve
(5, 3, '2024-10-07 16:49:00'),  -- Eve le da like a Charlie (Match generado)
(2, 7, '2024-10-08 13:55:00'),  -- Bob le da like a Grace
(7, 2, '2024-10-08 13:59:00'),  -- Grace le da like a Bob (Match generado)
(4, 9, '2024-10-08 15:25:00'),  -- Diana le da like a Isabel
(9, 4, '2024-10-08 15:28:00'),  -- Isabel le da like a Diana (Match generado)
(6, 10, '2024-10-08 10:45:00'), -- Frank le da like a Jack
(10, 6, '2024-10-08 10:49:00'); -- Jack le da like a Frank (Match generado)






-- Tabla Matches
CREATE TABLE Matches (
    id_match INT PRIMARY KEY IDENTITY(1,1),
    id_usuario1 INT,
    id_usuario2 INT,
    fecha_match DATETIME,
    CONSTRAINT FK_Matches_Usuario1 FOREIGN KEY (id_usuario1) REFERENCES Usuarios(id_usuario),
    CONSTRAINT FK_Matches_Usuario2 FOREIGN KEY (id_usuario2) REFERENCES Usuarios(id_usuario)
);


--INSERTS--

INSERT INTO Matches (id_usuario1, id_usuario2, fecha_match) VALUES
(1, 2, '2024-10-01 10:15:00'),  -- Coincidencia entre Agustin y Lucia
(3, 4, '2024-10-03 13:15:00');  -- Coincidencia entre Pedro y Ana

INSERT INTO Matches (id_usuario1, id_usuario2, fecha_match) VALUES
(1, 2, '2024-10-01 14:31:00'),  -- Alice y Bob
(3, 4, '2024-10-01 15:18:00'),  -- Charlie y Diana
(5, 6, '2024-10-02 18:32:00'),  -- Eve y Frank
(7, 8, '2024-10-02 12:13:00'),  -- Grace y Henry
(1, 3, '2024-10-03 16:54:00'),  -- Alice y Charlie
(2, 5, '2024-10-03 11:29:00'),  -- Bob y Eve
(4, 6, '2024-10-03 19:39:00'),  -- Diana y Frank
(8, 9, '2024-10-04 17:03:00'),  -- Henry e Isabel
(1, 10, '2024-10-04 13:18:00'), -- Alice y Jack
(3, 7, '2024-10-04 11:48:00'),  -- Charlie y Grace
(5, 9, '2024-10-05 09:58:00'),  -- Eve e Isabel
(2, 6, '2024-10-05 14:34:00'),  -- Bob y Frank
(7, 10, '2024-10-05 16:13:00'), -- Grace y Jack
(1, 6, '2024-10-06 20:48:00'),  -- Alice y Frank
(4, 8, '2024-10-06 11:24:00'),  -- Diana y Henry
(9, 10, '2024-10-07 17:58:00'), -- Isabel y Jack
(1, 8, '2024-10-07 12:09:00'),  -- Alice y Henry
(3, 5, '2024-10-07 16:49:00'),  -- Charlie y Eve
(2, 7, '2024-10-08 13:59:00'),  -- Bob y Grace
(4, 9, '2024-10-08 15:28:00'),  -- Diana e Isabel
(6, 10, '2024-10-08 10:49:00'); -- Frank y Jack


select * from Matches


-- Tabla Mensajes
CREATE TABLE Mensajes (
    id_mensaje INT PRIMARY KEY IDENTITY(1,1),
    id_match INT,
    id_usuario_emisor INT, -- Nuevo campo agregado para identificar al emisor del mensaje
    texto NVARCHAR(MAX),
    fecha_envio DATETIME,
    CONSTRAINT FK_Mensajes_Match FOREIGN KEY (id_match) REFERENCES Matches(id_match),
    CONSTRAINT FK_Mensajes_Usuario FOREIGN KEY (id_usuario_emisor) REFERENCES Usuarios(id_usuario) -- Clave foránea que referencia a la tabla Usuarios
);


--INSERTS-- 

INSERT INTO Mensajes (id_match, id_usuario_emisor, texto, fecha_envio) VALUES
(1, 1, 'Hola Lucia, ¿cómo estás?', '2024-10-01 10:20:00'),  -- Mensaje de Agustin a Lucia
(1, 2, '¡Hola Agustin! Muy bien, ¿y tú?', '2024-10-01 10:25:00'),  -- Mensaje de Lucia a Agustin
(2, 3, 'Hola Ana, encantado de conocerte.', '2024-10-03 13:20:00'),  -- Mensaje de Pedro a Ana
(2, 4, 'Igualmente, Pedro. ¿Qué te gusta hacer?', '2024-10-03 13:25:00');  -- Mensaje de Ana a Pedro


-- Inserción de mensajes para el match entre usuarios 1 y 2
INSERT INTO Mensajes (id_match, id_usuario_emisor, texto, fecha_envio)
VALUES 
(1, 1, '¡Hola! ¿Cómo estás?', '2024-10-01 10:30:00'),
(1, 2, '¡Hola! Estoy bien, ¿y tú?', '2024-10-01 10:32:00'),
(1, 1, 'Muy bien, gracias. ¿Te gustaría salir algún día?', '2024-10-01 10:34:00'),
(1, 2, 'Sí, sería genial. ¿Este fin de semana?', '2024-10-01 10:35:00'),
(1, 1, '¡Perfecto! Nos vemos entonces.', '2024-10-01 10:36:00');





-- Tabla Bloqueos
CREATE TABLE Blocks (
    id_block INT PRIMARY KEY IDENTITY(1,1),
    id_usuario_bloqueador INT,
    id_usuario_bloqueado INT,
    fecha_bloqueo DATETIME,
    CONSTRAINT FK_Blocks_UsuarioBloqueador FOREIGN KEY (id_usuario_bloqueador) REFERENCES Usuarios(id_usuario),
    CONSTRAINT FK_Blocks_UsuarioBloqueado FOREIGN KEY (id_usuario_bloqueado) REFERENCES Usuarios(id_usuario)
);


--INSERTS--

INSERT INTO Blocks (id_usuario_bloqueador, id_usuario_bloqueado, fecha_bloqueo) VALUES
(1, 3, '2024-10-02 10:00:00'),  -- Agustin bloquea a Pedro
(2, 4, '2024-10-02 11:00:00');  -- Lucia bloquea a Ana



-- Tabla Eventos Sociales
CREATE TABLE Eventos (
    id_evento INT PRIMARY KEY IDENTITY(1,1),
    nombre_evento NVARCHAR(100),
    fecha_evento DATETIME,
    ubicacion NVARCHAR(100),
    id_creador INT,
    CONSTRAINT FK_Eventos_Creador FOREIGN KEY (id_creador) REFERENCES Usuarios(id_usuario)
);

--INSERTS-- 

INSERT INTO Eventos (nombre_evento, fecha_evento, ubicacion, id_creador) VALUES
('Picnic en el Parque', '2024-10-10 15:00:00', 'Parque Central', 1),
('Noche de Juegos', '2024-10-15 19:00:00', 'Casa de Lucia', 2),
('Excursión a la Montaña', '2024-10-20 08:00:00', 'Cerro Córdoba', 3);



-- Tabla Asistentes a Eventos
CREATE TABLE Event_Attendees (
    id_evento INT,
    id_usuario INT,
    PRIMARY KEY (id_evento, id_usuario),
    CONSTRAINT FK_Event_Attendees_Evento FOREIGN KEY (id_evento) REFERENCES Eventos(id_evento),
    CONSTRAINT FK_Event_Attendees_Usuario FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
);


INSERT INTO Event_Attendees (id_evento, id_usuario) VALUES
(1, 1),  -- Agustin asiste al Picnic
(1, 2),  -- Lucia asiste al Picnic
(2, 2),  -- Lucia asiste a la Noche de Juegos
(2, 3),  -- Pedro asiste a la Noche de Juegos
(3, 3),  -- Pedro asiste a la Excursión
(3, 4);  -- Ana asiste a la Excursión


select * from Usuarios;


SELECT 
    COUNT(*) / COUNT(DISTINCT CAST(fecha_match AS DATE)) AS promedio_matches_por_dia
FROM Matches;




SELECT 
    genero, COUNT(*) AS cantidad 
FROM Usuarios 
GROUP BY genero
ORDER BY cantidad DESC;



--Perfiles con mas likes 
SELECT 
	Likes.id_usuario_destino, COUNT(*) AS cantidad_likes_recibidos, Usuarios.nombre
FROM Likes INNER JOIN Usuarios ON
Likes.id_usuario_destino = Usuarios.id_usuario 
GROUP BY Usuarios.nombre,Likes.id_usuario_destino
ORDER BY cantidad_likes_recibidos DESC 


SELECT 
    COUNT(*) AS coincidencias_fin_de_semana_festivos 
FROM Matches 
WHERE DATEPART(weekday, fecha_match) IN (1, 7) 
      OR CONVERT(DATE, fecha_match) IN ('2024-12-25', '2024-01-01'); -- Lista de días festivos


SELECT 
    CONVERT(DATE, Matches.fecha_match) AS fecha, 
    COUNT(Matches.id_match) AS cantidad_matches 
FROM Matches 
WHERE DATEPART(weekday, CONVERT(DATE, fecha_match)) IN (1, 7) 
      OR CONVERT(DATE, fecha_match) IN ('2024-12-25', '2024-01-01')
GROUP BY CONVERT(DATE, Matches.fecha_match)
ORDER BY fecha;  -- Ordenar por fecha si es necesario

