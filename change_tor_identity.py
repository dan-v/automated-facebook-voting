# Taken from: http://stackoverflow.com/questions/9887505/changing-tor-identity-inside-python-script

import socket,sys

try:
    tor_ctrl = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
    tor_ctrl.connect(("127.0.0.1", 9151))
    tor_ctrl.send('AUTHENTICATE "{}"\r\nSIGNAL NEWNYM\r\n'.format("passwd"))
    response = tor_ctrl.recv(1024)
    if response != '250 OK\r\n250 OK\r\n':
        sys.stderr.write('Unexpected response from Tor control port: {}\n'.format(response))
except Exception, e:
    sys.stderr.write('Error connecting to Tor control port: {}\n'.format(repr(e)))
