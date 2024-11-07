import pyodbc
from astrapy import DataAPIClient
from cassandra import AuthenticationFailed
import requests

def insertarUserSql(name,age,genre,location,biography,interests):


    try:
        # Conexión a la base de datos (personaliza tus datos de conexión)
        conn = pyodbc.connect('DRIVER={SQL Server};'
                    'SERVER=tpotinder.database.windows.net;'
                    'DATABASE=TinderDB;'
                    'UID=user_compartido;'
                    'PWD=Tinder1234;')
        cursor = conn.cursor()

        # Consulta con placeholders para evitar problemas de inyección y sintaxis
        query = 'INSERT INTO Usuarios (nombre, edad, genero, ubicacion, biografia) VALUES (?, ?, ?, ?, ?)'
        
        # Ejecutar la consulta pasando los valores como una tupla
        cursor.execute(query, (name, age, genre, location, biography))
        
        # Confirmar los cambios en la base de datos
        conn.commit()
        print("Usuario insertado correctamente.")

    except pyodbc.Error as e:
        print(f"Error al insertar el usuario: {e}")

    finally:
        # Cerrar la conexión
        cursor.close()
        conn.close()



def connectSqlServer(num):
    try:
        conn = pyodbc.connect('DRIVER={SQL Server};'
                        'SERVER=tpotinder.database.windows.net;'
                        'DATABASE=TinderDB;'
                        'UID=user_compartido;'
                        'PWD=Tinder1234;')
        cursor = conn.cursor();
    

        if num == 1:
            cursor.execute("SELECT COUNT(*) / COUNT(DISTINCT CAST(fecha_match AS DATE)) AS promedio_matches_por_dia FROM Matches")
            resultados = cursor.fetchall();
            print(f'Se generan {resultados[0][0]} matches por dia en promedio en la plataforma')
            print("-----------------------------------------------------------")
            cursor.execute(" SELECT CONVERT(DATE, fecha_match) AS fecha, COUNT(id_match) AS cantidad_matches FROM Matches GROUP BY CONVERT(DATE, fecha_match) ORDER BY fecha ASC;")
            resultados= cursor.fetchall()
            for fila in resultados:
                print(f'Fecha: {fila[0]} \nCantidad de matches: {fila[1]} \n ------------------ ')
        elif num ==2 :
            #Generos
            cursor.execute("SELECT  genero, COUNT(*) AS cantidad FROM Usuarios GROUP BY genero ORDER BY cantidad DESC;")
            resultados = cursor.fetchall()
            print("Genero:\n")
            for fila in resultados:
                print(f'{fila[0]}: {fila[1]}' )
        elif num == 3:
            cursor.execute("SELECT Likes.id_usuario_destino, COUNT(*) AS cantidad_likes_recibidos, Usuarios.nombre FROM Likes INNER JOIN Usuarios ON Likes.id_usuario_destino = Usuarios.id_usuario  GROUP BY Usuarios.nombre,Likes.id_usuario_destino ORDER BY cantidad_likes_recibidos DESC ")
            resultados = cursor.fetchall();
            print(f'El usuario con mas Swipes a la derecha es: { resultados[0][2]}\n')
            for fila in resultados:
                print(f'{fila[2]} Recibió {fila[1]} swipes a la derecha ')
        elif num == 4:
            cursor.execute("WITH Duraciones AS ( SELECT  id_match, DATEDIFF(day, MIN(fecha_envio), MAX(fecha_envio)) AS duracion_dias FROM  Mensajes GROUP BY  id_match) SELECT  AVG(duracion_dias) AS duracion_promedio FROM  Duraciones;   ")
            resultados = cursor.fetchall();
            print(f'La duración promedio de las conversaciones antes de una cita es de {resultados[0][0]} dias')
        elif num == 7:
                cursor.execute("SELECT COUNT(*) AS coincidencias_fin_de_semana_festivos  FROM Matches  WHERE DATEPART(weekday, fecha_match) IN (1, 7) OR CONVERT(DATE, fecha_match) IN ('2024-12-25', '2024-01-01'); -- Lista de días festivos")
                resultados = cursor.fetchall();
                print(f"Se generaron {resultados[0][0]} coincidencias durante fines de semana y/o dias festivos")
                print("---------------------------------------------------------------------")
                print("Estas fechas son:")
                cursor.execute("SELECT  CONVERT(DATE, Matches.fecha_match) AS fecha,  COUNT(Matches.id_match) AS cantidad_matches  FROM Matches  WHERE DATEPART(weekday, CONVERT(DATE, fecha_match)) IN (1, 7)  OR CONVERT(DATE, fecha_match) IN ('2024-12-25', '2024-01-01') GROUP BY CONVERT(DATE, Matches.fecha_match) ORDER BY fecha;")
                resultados = cursor.fetchall()
                for fila in resultados:
                    print(f'{fila[0]}: {fila[1]} matches  ')
                print(" ")
    except pyodbc.Error as e:
        print("Error en la conexión o en la consulta:", e)
    finally:
        conn.close()




def connectCassandra(num):
    try:
        cloud_config = {
            'secure_connect_bundle': 'secure-connect-db-tinder2.zip'
            }
    # Cargar credenciales desde el archivo JSON
        with open("db_tinder2-token.json") as f:
            secrets = json.load(f)

        CLIENT_ID = secrets["clientId"]
        CLIENT_SECRET = secrets["secret"]

    # Configuración de autenticación
        auth_provider = PlainTextAuthProvider(CLIENT_ID, CLIENT_SECRET)

    # Conectar al cluster de Cassandra
        cluster = Cluster(cloud=cloud_config, auth_provider=auth_provider)
        session = cluster.connect("tinder")
        print("conectado a Astra")

        if num == 1:
            query = "SELECT AVG(cantidad_coincidencias) AS promedio_coincidencias_diarias FROM coincidencias_por_dia;"
            rows = session.execute(query)
            print("======================================================================")
            for row in rows:
                print(f"Promedio de coincidencias diarias: \n{row.promedio_coincidencias_diarias}")
                print("----------------------------------------------------------------------")
        elif num == 2:
            ####
            query = ""
            rows = session.execute(query)
            print("======================================================================")

        elif num == 3:
            query = "SELECT nombre, cantidad_likes from perfiles_swipes_derecha"
            rows = session.execute(query)
            print("======================================================================")
            for row in rows:
                print(f"Nombre: {row.nombre}, \nCantidad de Likes: {row.cantidad_likes} ")
                print("----------------------------------------------------------------------")
        elif num == 4:
            query = ""
            rows = session.execute(query)

    # Manejo de errores específicos de Cassandra
    except AuthenticationFailed as auth_err:
        print("Error: Failed to authenticate. Check your token or credentials.")
        print(f"Details: {auth_err}")

    # Manejo de errores relacionados con peticiones HTTP
    except requests.exceptions.RequestException as req_err:
        print("Error: An HTTP error occurred during the connection.")
        print(f"Details: {req_err}")

    # Cualquier otro tipo de error
    except Exception as e:
        print("An unexpected error occurred.")
        print(f"Details: {e}")

        
    
# print("Bienvenido a Tinder, Crea un Usuario para Continuar:")

# nombre = str(input("Indicanos tu Nombre Porfavor: "))
# edad = int(input("Ahora dinos cuantos años tienes: "))
# genero = str(input("Indicanos tu genero: "))
# ubicacion = str(input("¿Donde vives? (CABA , Buenos Aires,etc..): "))
# biografia= str(input("Hablanos un poco de ti.. escribe una pequeña biografia: "))
# intereses = []
# interes = input("Por Elgie  algunos Intereses que te identifiquen pon 0 para finalizar:\n  1- deportes 2- música 3- viajes 4- cine 5- lectura 6- tecnología 7- comida 8- arte 9- fotografía 10- gimnasio\n")
# intereses.append(interes)

# while interes != 0:
#     interes = int(input("..."))
#     intereses.append(interes)


# insertarUserSql(nombre,edad,genero,ubicacion,biografia,intereses);

# print("¡Usuario Creado con Éxito!")


opcion = 0;
while opcion != 8:

        print("Elige una opción:\n")
        print("1- ¿Cuántas coincidencias se generan en promedio por día en la plataforma? ")
        print("2- ¿Qué características son más populares en los perfiles de los usuarios? ")
        print("3- ¿Qué perfiles reciben más 'swipes' a la derecha?  ")
        print("4- ¿Cuál es la duración promedio de las conversaciones antes de una cita? ")
        print("5- ¿Qué intereses son más comunes entre los usuarios que coinciden? ")
        print("6- ¿Qué perfiles tienen más de 10 fotos Y al menos 3 intereses en común? ")
        print("7- ¿Cuántas coincidencias se generan en un día durante el fin de semana O en días festivos?")
        print("8- Salir\n ")
        opcion = int(input("..."))
        
        if opcion == 4 or opcion == 7:
            connectSqlServer(opcion);
            print("")
        elif opcion == 1 or opcion == 3:
            connectCassandra(opcion)
        #elif opcion == 2 or opcion == 5 or opcion == 6:
            



    













    