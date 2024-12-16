import mysql.connector
from datetime import datetime
import time 

time.sleep(60)

conn = mysql.connector.connect(
    host="bourbabax-db",
    user="www",
    password="bourbabax255",
    database="serverdb",
    port=3306                    
)

# Curseur pour exécuter des requêtes
cursor = conn.cursor()
while True:
    print("Checking for dead raspberries...")
    # Requête SQL
    query = "SELECT mac_addr, last_seen FROM raspberries;"
    cursor.execute(query)

    # Récupérer les résultats
    raspberries = cursor.fetchall()
    for raspberry in raspberries:
        datetime_start = raspberry[1]
        minutes_diff = round((datetime.now() - datetime_start).total_seconds() / 60)
        if minutes_diff > 12:
            query = f"UPDATE `raspberries` SET `port`=0 WHERE `mac_addr` = '{raspberry[0]}'; "
            cursor.execute(query)
    print("Done.")
    # Valider la transaction
    conn.commit()
    time.sleep(60)

# Fermer le curseur et la connexion
cursor.close()
conn.close()