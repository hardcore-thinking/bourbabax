import socket

# Configuration du client
host = "172.28.0.5"  # Adresse IP de la Machine B
port = 7880

# Créer et configurer le socket client
with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
    s.connect((host, port))
    print(f"Connecté à {host}:{port}")
    # Envoyer un message
    s.sendall(b"Hello, Machine B!")
    # Recevoir une réponse
    data = s.recv(1024)
    print("Réponse du serveur:", data.decode())