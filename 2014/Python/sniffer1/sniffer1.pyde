import socket
s = 0
def setup():
    size(640, 360)
    noLoop()
    s = socket.socket(socket.AF_INET, socket.SOCK_RAW, socket.IPPROTO_TCP)

def draw():
    print s.recvfrom(65565)

