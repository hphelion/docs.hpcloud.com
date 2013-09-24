import os
from wsgiref.simple_server import make_server

# Lookup is a lookup for redirects to files in object storage.
lookup = {}
lookup['/file/hpNET-1.3.0.6.nupkg'] = 'https://a248.e.akamai.net/cdn.hpcloudsvc.com/hdb0a98359ca04396dd429335015a1b4b/prodaw2/HPCloud-API.1.3.0.6.nupkg'
lookup['/file/hpPHP-1.1.0.zip'] = 'https://a248.e.akamai.net/cdn.hpcloudsvc.com/hdb0a98359ca04396dd429335015a1b4b/prodaw2/HPCloud-PHP-1.1.0.zip'
lookup['/file/nova-stuff.tar'] = 'https://a248.e.akamai.net/cdn.hpcloudsvc.com/hdb0a98359ca04396dd429335015a1b4b/prodaw2/prettytable-0.5.tar.gz'


def handle_no_file(env, start_response):
    if env['PATH_INFO'] in lookup:
        status = '307 Temporary Redirect'  # HTTP temporary redirect.
        headers = [('Location', lookup[env['PATH_INFO']])]
        start_response(status, headers)
        return env['PATH_INFO']
    else:
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
