USE TinderDB

-- Tabla Usuarios
CREATE TABLE Usuarios (
    id_usuario INT PRIMARY KEY IDENTITY(1,1),
    nombre NVARCHAR(50),
    edad INT,
    genero NVARCHAR(20),
    ubicacion NVARCHAR(100),
    biografia NVARCHAR(MAX),
 
);

select * from Usuarios;






select preferencias from Usuarios;

CREATE TABLE Intereses(
	id int Primary key identity,
	interes NVARCHAR(50));

	-- Inserciones en la tabla Intereses

select * from Intereses


CREATE TABLE Intereses_x_usuario(
	id_usuario int ,
	id_interes int,
	primary key(id_usuario,id_interes),
	CONSTRAINT FK_Interes_user FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario),
	CONSTRAINT FK_Interes_Interes FOREIGN KEY (id_interes) REFERENCES Intereses(id));



--INSERTS--
INSERT INTO Usuarios (nombre, edad, genero, ubicacion, biografia, preferencias) VALUES
('Agustin', 20, 'Masculino', 'Buenos Aires', 'Amo viajar y conocer gente nueva.', '{"edad_min": 18, "edad_max": 30, "intereses": ["viajes", "tecnología"]}'),
('Lucia', 22, 'Femenino', 'Buenos Aires', 'Fanática de la música y el cine.', '{"edad_min": 20, "edad_max": 30, "intereses": ["música", "cine"]}'),
('Pedro', 25, 'Masculino', 'Córdoba', 'Amo los deportes y la aventura.', '{"edad_min": 20, "edad_max": 30, "intereses": ["deportes", "viajes"]}'),
('Ana', 21, 'Femenino', 'Córdoba', 'Disfruto de los libros y las caminatas.', '{"edad_min": 18, "edad_max": 25, "intereses": ["lectura", "naturaleza"]}'),
('Carlos', 23, 'Masculino', 'Rosario', 'Me gusta la comida y las nuevas experiencias.', '{"edad_min": 20, "edad_max": 30, "intereses": ["gastronomía", "cultura"]}');


INSERT INTO Usuarios (nombre, edad, genero, ubicacion, biografia) VALUES
('Agustin', 20, 'Masculino', 'Buenos Aires', 'Amo viajar y conocer gente nueva.')


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


--Coincidencias durante el fin de semana o días festivos:

SELECT 
    CONVERT(DATE, Matches.fecha_match) AS fecha, 
    COUNT(Matches.id_match) AS cantidad_matches 
FROM Matches 
WHERE DATEPART(weekday, CONVERT(DATE, fecha_match)) IN (1, 7) 
      OR CONVERT(DATE, fecha_match) IN ('2024-12-25', '2024-01-01')
GROUP BY CONVERT(DATE, Matches.fecha_match)
ORDER BY fecha;  -- Ordenar por fecha si es necesario

--Duración promedio de las conversaciones antes de una cita:


-- Subconsulta para obtener la duración de cada conversación (diferencia entre la primera y última fecha de cada conversación)

WITH Duraciones AS (
    SELECT 
        id_match,
        DATEDIFF(day, MIN(fecha_envio), MAX(fecha_envio)) AS duracion_dias
    FROM 
        Mensajes
    GROUP BY 
        id_match
)

-- Calcular el promedio de duración de las conversaciones antes de una cita
SELECT 
    AVG(duracion_dias) AS duracion_promedio
FROM 
    Duraciones;



select * from Mensajes where id_match = 11;


select * from Matches;