import sys
import mysql.connector

conn = mysql.connector.connect(
    host="bourbabax-db",
    user="www",
    password="bourbabax255",
    database="serverdb",
    port=3306                    
)

# Curseur pour exécuter des requêtes
cursor = conn.cursor()

# Requête SQL
query = "SELECT ssh_key FROM raspberries;"
cursor.execute(query)

# Récupérer les résultats
raspberries = cursor.fetchall()

# Enregistrer les résultats dans un fichier texte stocké dans le répertoire /usr/local/bin/
with open("/usr/local/bin/ssh_keys.txt", "w+") as f:
    for raspberry in raspberries:
        f.write(f"{raspberry[0]}\n")

# Valider la transaction
conn.commit()

# Fermer le curseur et la connexion
cursor.close()
conn.close()