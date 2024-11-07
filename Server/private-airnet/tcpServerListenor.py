import socket

# Configuration du serveur
host = ''  # écoute sur toutes les interfaces
port = 7880

# Créer et configurer le socket serveur
with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as server_socket:
    server_socket.bind((host, port))
    server_socket.listen()
    print(f"Serveur en écoute sur le port {port}...")

    # Accepter une connexion du client
    client_socket, client_address = server_socket.accept()
    with client_socket:
        print(f"Connexion établie avec {client_address}")
        while True:
            data = client_socket.recv(1024)
            if not data:  # Si aucune donnée n'est reçue, fermer la connexion
                print("Client déconnecté")
                break
            print("Reçu:", data.decode())
            try:
                # Envoyer une réponse
                client_socket.sendall(b"Message recu")
            except BrokenPipeError:
                print("Erreur : Le client a fermé la connexion.")
                break