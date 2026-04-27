# # import socket
# # socket_server=socket.socket(socket.AF_INET, socket.SOCK_STREAM)
# # socket_server.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
# # socket_server.bind(("127.0.0.1", 5000))
# # socket_server.listen()
# # print("Сервер запущен и ждет клиента")
# # client_socket, clien_address=socket_server.accept()
# # print("Подключился клиент", clien_address)
# # data=client_socket.recv(1024)
# # print("Получено сообщение")
# # data.decode("utf-8")
# # client_socket.close()
# # socket_server.close()

# # import  threading
# # import time

# # def count():
# #     count=0
# #     while True:
# #         count+=1
# #         time.sleep(2)
# #         print(f"прошло {count}")

# # t1=threading.Thread(target=count, daemon=True).start()

# # a = input("вы хотите выйти?")


# import  threading
# import socket
# lock=threading.Lock()

# clients = []
# def server_thr(client_socket, client_address):
#     print(f"клиент {client_address} подключен")
#     while True:
#         data=client_socket.recv(1024)
#         if not data:
#             break
#         message=data.decode("utf-8")
#         print(f"{client_address} пришло {message}")
#     with lock:
#         if client_socket in clients:
#             clients.remove(client_socket)
#     client_socket.close()

# socket_server=socket.socket(socket.AF_INET, socket.SOCK_STREAM)
# socket_server.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
# socket_server.bind(("127.0.0.1", 5000))
# socket_server.listen()
# print("Сервер запущен и ждет клиента")

# while True:
#     client_socket, client_addr = socket_server.accept()
#     with lock:
#         clients.append(client_socket)
#     th = threading.Thread(target=server_thr, args=(client_socket,client_addr), daemon=True).start()


# пр3
import socket
import threading

clients = []
lock = threading.Lock()

def broadcast(message, sender_socket=None):
# отправляет сообщение всем клиентам, кроме отправителя
    with lock:
        for client in clients[:]:  # используем копию списка
            if client != sender_socket:
                try:
                    client.send(message)
                except:
# если не удалось отправить, удаляем клиента
                    if client in clients:
                        clients.remove(client)
                    client.close()

def handle_client(client_socket, client_address):
# обработка одного клиента
    print(f"Клиент {client_address} подключился")
    
# отправляем приветственное сообщение новому клиенту
    try:
        client_socket.send("Добро пожаловать в чат!".encode('utf-8'))
    except:
        pass
    
# оповещаем всех о новом участнике
    broadcast(f"Пользователь {client_address} присоединился к чату".encode('utf-8'), client_socket)
    
    while True:
        try:
            data = client_socket.recv(1024)
            if not data:
                break
            
            message = data.decode('utf-8')
            print(f"{client_address}: {message}")
            
# рассылаем сообщение всем остальным клиентам
            broadcast(f"{client_address}: {message}".encode('utf-8'), client_socket)
            
        except:
            break
    
# клиент отключился
    with lock:
        if client_socket in clients:
            clients.remove(client_socket)
    
    client_socket.close()
    print(f"Клиент {client_address} отключился")
    
# оповещаем всех об отключении
    broadcast(f"Пользователь {client_address} покинул чат".encode('utf-8'))

def start_server():
# запуск сервера
    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    server_socket.bind(('127.0.0.1', 5000))
    server_socket.listen(5)
    
    print("сервер чата запущен")
    print("ожидание подключений\n")
    
    while True:
        client_socket, client_address = server_socket.accept()
        
        with lock:
            clients.append(client_socket)
        
# поток для нового клиента
        client_thread = threading.Thread(target=handle_client, args=(client_socket, client_address))
        client_thread.daemon = True
        client_thread.start()

if __name__ == "__main__":
    try:
        start_server()
    except KeyboardInterrupt:
        print("\nсервер остановлен")