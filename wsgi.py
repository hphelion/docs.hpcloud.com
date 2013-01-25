import os
from wsgiref.simple_server import make_server

# Lookup is a lookup for redirects to files in object storage.
lookup = {}
lookup['/file/hpcloud-1.0.0.gem'] = 'https://a248.e.akamai.net/cdn.hpcloudsvc.com/hdb0a98359ca04396dd429335015a1b4b/prodaw2/hpcloud-1.0.0.gem'
lookup['/file/hpcloud-1.0.1.gem'] = 'https://a248.e.akamai.net/cdn.hpcloudsvc.com/hdb0a98359ca04396dd429335015a1b4b/prodaw2/hpcloud-1.0.1.gem'
lookup['/file/hpcloud-1.1.0.gem'] = 'https://a248.e.akamai.net/cdn.hpcloudsvc.com/hdb0a98359ca04396dd429335015a1b4b/prodaw2/unixcli/v1.1.0/hpcloud-1.1.0.gem'
lookup['/file/hpcloud-1.2.0.gem'] = 'https://a248.e.akamai.net/cdn.hpcloudsvc.com/hdb0a98359ca04396dd429335015a1b4b/prodaw2/unixcli/v1.2.0/hpcloud-1.2.0.gem'
lookup['/file/hpcloud-1.3.0.gem'] = 'https://a248.e.akamai.net/cdn.hpcloudsvc.com/hdb0a98359ca04396dd429335015a1b4b/prodaw2/unixcli/v1.3.0/hpcloud-1.3.0.gem'
lookup['/file/hpcloud-1.4.0.gem'] = 'https://a248.e.akamai.net/cdn.hpcloudsvc.com/hdb0a98359ca04396dd429335015a1b4b/prodaw2/unixcli/v1.4.0/hpcloud-1.4.0.gem'
lookup['/file/hpcloud-1.5.0.gem'] = 'https://a248.e.akamai.net/cdn.hpcloudsvc.com/hdb0a98359ca04396dd429335015a1b4b/prodaw2/unixcli/v1.5.0/hpcloud-1.5.0.gem'
lookup['/file/hpcloud-1.6.0.gem'] = 'https://a248.e.akamai.net/cdn.hpcloudsvc.com/hdb0a98359ca04396dd429335015a1b4b/prodaw2/unixcli/v1.6.0/hpcloud-1.6.0.gem'
lookup['/file/hpcloud.gem'] = 'https://a248.e.akamai.net/cdn.hpcloudsvc.com/hdb0a98359ca04396dd429335015a1b4b/prodaw2/unixcli/v1.5.0/hpcloud-1.5.0.gem'
lookup['/file/hpcloud.tar'] = 'https://a248.e.akamai.net/cdn.hpcloudsvc.com/hdb0a98359ca04396dd429335015a1b4b/prodaw2/hpcloud_5.tar'
lookup['/file/hpfog-0.0.16.gem'] = 'https://a248.e.akamai.net/cdn.hpcloudsvc.com/hdb0a98359ca04396dd429335015a1b4b/prodaw2/hpfog-0.0.16.gem'
lookup['/file/hpfog-0.0.17.gem'] = 'https://a248.e.akamai.net/cdn.hpcloudsvc.com/hdb0a98359ca04396dd429335015a1b4b/prodaw2/hpfog-0.0.17.gem'
lookup['/file/hpfog-0.0.18.gem'] = 'https://a248.e.akamai.net/cdn.hpcloudsvc.com/hdb0a98359ca04396dd429335015a1b4b/prodaw2/hpfog-0.0.18.gem'
lookup['/file/hpfog-0.0.19.gem'] = 'https://a248.e.akamai.net/cdn.hpcloudsvc.com/hdb0a98359ca04396dd429335015a1b4b/prodaw2/hpfog-0.0.19.gem'
lookup['/file/hpfog.gem'] = 'https://a248.e.akamai.net/cdn.hpcloudsvc.com/hdb0a98359ca04396dd429335015a1b4b/prodaw2/hpfog-0.0.15.gem'
lookup['/file/hpfog.tar'] = 'https://a248.e.akamai.net/cdn.hpcloudsvc.com/hdb0a98359ca04396dd429335015a1b4b/prodaw2/hpfog_3.tar'
lookup['/file/hpNET-1.3.0.6.nupkg'] = 'https://a248.e.akamai.net/cdn.hpcloudsvc.com/hdb0a98359ca04396dd429335015a1b4b/prodaw2/HPCloud-API.1.3.0.6.nupkg'
lookup['/file/hpPHP-1.1.0.zip'] = 'https://a248.e.akamai.net/cdn.hpcloudsvc.com/hdb0a98359ca04396dd429335015a1b4b/prodaw2/HPCloud-PHP-1.1.0.zip'
lookup['/file/nova-stuff.tar'] = 'https://a248.e.akamai.net/cdn.hpcloudsvc.com/hdb0a98359ca04396dd429335015a1b4b/prodaw2/prettytable-0.5.tar.gz'
lookup['/file/python-novaclient-debian.deb'] = 'https://a248.e.akamai.net/cdn.hpcloudsvc.com/hdb0a98359ca04396dd429335015a1b4b/prodaw2/python-novaclient_2-5.6.8-1hp10_all.deb'
lookup['/file/python-novaclient.tar'] = 'https://a248.e.akamai.net/cdn.hpcloudsvc.com/hdb0a98359ca04396dd429335015a1b4b/prodaw2/python-novaclient_2-3.6.8-1hp10.tar.gz'
lookup['/file/python-novaclient_2.6.8.deb'] = 'https://a248.e.akamai.net/cdn.hpcloudsvc.com/hdb0a98359ca04396dd429335015a1b4b/prodaw2/python-novaclient_2.6.8-1hp14_all.deb'
lookup['/file/python-novaclient_2.6.8.tar.gz'] = 'https://a248.e.akamai.net/cdn.hpcloudsvc.com/hdb0a98359ca04396dd429335015a1b4b/prodaw2/python-novaclient_2.6.8-1hp14.tar.gz'
lookup['/file/WinCLI-1.3.0.1.zip'] = 'https://a248.e.akamai.net/cdn.hpcloudsvc.com/hdb0a98359ca04396dd429335015a1b4b/prodaw2/WinCLI-1.3.0.1.zip'
lookup['/file/WinCLI-1.3.0.4.zip'] = 'https://a248.e.akamai.net/cdn.hpcloudsvc.com/hdb0a98359ca04396dd429335015a1b4b/prodaw2/WinCLI-1.3.0.4.zip'
lookup['/file/WinCLI-1.3.0.6.zip'] = 'https://a248.e.akamai.net/cdn.hpcloudsvc.com/hdb0a98359ca04396dd429335015a1b4b/prodaw2/WinCLI-1.3.0.6.zip'
lookup['/file/WinCLI-1.3.1.8.zip'] = 'https://a248.e.akamai.net/cdn.hpcloudsvc.com/hdb0a98359ca04396dd429335015a1b4b/prodaw2/WinCLI-1.3.1.8.zip'
lookup['/file/WinCLI-1.3.1.9.zip'] = 'https://a248.e.akamai.net/cdn.hpcloudsvc.com/hdb0a98359ca04396dd429335015a1b4b/prodaw2/WinCLI-1.3.1.9.zip'
lookup['/file/WinCLI-1.3.2.2.zip'] = 'https://a248.e.akamai.net/cdn.hpcloudsvc.com/hdb0a98359ca04396dd429335015a1b4b/prodaw2/WinCLI-1.3.2.2.zip'
lookup['/file/WinCLI.zip'] = 'https://a248.e.akamai.net/cdn.hpcloudsvc.com/hdb0a98359ca04396dd429335015a1b4b/prodaw2/WinCLI-3.zip'


def handle_no_file(env, start_response):
    if env['PATH_INFO'] in lookup:
        status = '307 Temporary Redirect'  # HTTP temporary redirect.
        headers = [('Location', lookup[env['PATH_INFO']])]
        start_response(status, headers)
        return env['PATH_INFO']
    else:
        f = open('_site/404.html')
        status = '404 Not Found'  # HTTP Status
        headers = [('Content-type', 'text/html')]  # HTTP Headers
        start_response(status, headers)

        return f.readlines()

application = handle_no_file

if __name__ == '__main__':
    port = int(os.getenv('PORT', '8000'))
    srv = make_server('localhost', port, application)
    srv.serve_forever()
