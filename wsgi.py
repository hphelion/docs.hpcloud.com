import os
from wsgiref.simple_server import make_server

def handle_no_file(env, start_response):
    f = open('_site/404error.html')
    status = '404 Not Found'  # HTTP Status
    headers = [('Content-type', 'text/html')]  # HTTP Headers
    start_response(status, headers)

    return f.readlines()

application = handle_no_file

if __name__ == '__main__':
    port = int(os.getenv('PORT', '8000'))
    srv = make_server('localhost', port, application)
    srv.serve_forever()
