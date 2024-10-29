import pyodbc
from astrapy import DataAPIClient
from cassandra import AuthenticationFailed
import requests

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
        # Intenta establecer la conexión
        client = DataAPIClient("AstraCS:dTeMFYyvEHErBPdqbHgmserc:0eccd97b6601f5e75d6cd0a94c4277a5ca3228a3288017bb73dae58be1a54ee9")
        db = client.get_database_by_api_endpoint(
            "https://b6b084ee-15b8-4dca-9b5a-bc15ee653c55-us-east1.apps.astra.datastax.com/",
            namespace="tinder"
        )
        print(f"Connected to Astra DB: {db.list_collection_names()}")

        # Crear la conexión
        # cluster = Cluster(cloud=cloud_config, auth_provider=auth_provider)
        # session = cluster.connect()

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

        
        








opcion = 8;
while opcion != 9:

        if  opcion == 8 :  
            print("-----------------------")
            print("Elige la Base De Datos:")
            print("1. SQL SERVER")
            print("2. MongoDB")
            print("3. Cassandra")
            bd = int(input("..."))

        print("Elige una opción:\n")
        print("1- ¿Cuántas coincidencias se generan en promedio por día en la plataforma? ")
        print("2- ¿Qué características son más populares en los perfiles de los usuarios? ")
        print("3- ¿Qué perfiles reciben más 'swipes' a la derecha?  ")
        print("4- ¿Cuál es la duración promedio de las conversaciones antes de una cita? ")
        print("5- ¿Qué intereses son más comunes entre los usuarios que coinciden? ")
        print("6- ¿Qué perfiles tienen más de 10 fotos Y al menos 3 intereses en común? ")
        print("7- ¿Cuántas coincidencias se generan en un día durante el fin de semana O en días festivos?")
        print("8- Cambiar Base De Datos")
        print("9- Salir\n ")
        opcion = int(input("..."))
        
        if bd == 1:
            connectSqlServer(opcion);
        elif bd == 3:
            connectCassandra(opcion)



    













    