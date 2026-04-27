# import socket

# client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
# client_socket.connect(('127.0.0.1', 5000))
# client_socket.send('Привет от клиента'.encode('utf-8'))
# client_socket.close()

import socket
import threading
import sys

def receive_messages(client_socket):
# прием соо от серв
    while True:
        try:
            message = client_socket.recv(1024).decode('utf-8')
            if not message:
                break
            print(f"\n{message}")
            print("Вы: ", end="", flush=True)  # возвращаем приглашение для ввода
        except:
            print("\nСоединение с сервером потеряно")
            break
    
    print("завершение работы клиента")
    client_socket.close()
    sys.exit(0)

def send_messages(client_socket):
# отправка соо на серв
    while True:
        try:
            message = input()
            if message:
                if message.lower() == '/quit':
                    print("Выход из чата...")
                    client_socket.close()
                    sys.exit(0)
                client_socket.send(message.encode('utf-8'))
        except:
            break

def start_client(): 
    # запуск клиента
    client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    
    try:
        client_socket.connect(('127.0.0.1', 5000))
        print("Подключено к чат-серверу")
        print("Введите /quit для выхода\n")
    except:
        print("Не удалось подключиться к серверу")
        return
    
# прием соо
    receive_thread = threading.Thread(target=receive_messages, args=(client_socket,))
    receive_thread.daemon = True
    receive_thread.start()
    
#  отправка соо
    send_thread = threading.Thread(target=send_messages, args=(client_socket,))
    send_thread.daemon = True
    send_thread.start()
    
    try:
        receive_thread.join()
        send_thread.join()
    except KeyboardInterrupt:
        print("\nзавершение работы")
        client_socket.close()

if __name__ == "__main__":
    start_client()