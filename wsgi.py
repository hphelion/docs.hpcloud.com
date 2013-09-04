import os
from wsgiref.simple_server import make_server

# Lookup is a lookup for redirects to files in object storage.
lookup = {}
lookup['/file/hpcloud-1.3.0.gem'] = 'https://a248.e.akamai.net/cdn.hpcloudsvc.com/hdb0a98359ca04396dd429335015a1b4b/prodaw2/unixcli/v1.3.0/hpcloud-1.3.0.gem'
lookup['/file/hpcloud-1.4.0.gem'] = 'https://a248.e.akamai.net/cdn.hpcloudsvc.com/hdb0a98359ca04396dd429335015a1b4b/prodaw2/unixcli/v1.4.0/hpcloud-1.4.0.gem'
lookup['/file/hpcloud-1.5.0.gem'] = 'https://a248.e.akamai.net/cdn.hpcloudsvc.com/hdb0a98359ca04396dd429335015a1b4b/prodaw2/unixcli/v1.5.0/hpcloud-1.5.0.gem'
lookup['/file/hpcloud-1.6.0.gem'] = 'https://a248.e.akamai.net/cdn.hpcloudsvc.com/hdb0a98359ca04396dd429335015a1b4b/prodaw2/unixcli/v1.6.0/hpcloud-1.6.0.gem'
lookup['/file/hpcloud-1.7.0.gem'] = 'https://a248.e.akamai.net/cdn.hpcloudsvc.com/hdb0a98359ca04396dd429335015a1b4b/prodaw2/unixcli/v1.7.0/hpcloud-1.7.0.gem'
lookup['/file/hpcloud-1.8.0.gem'] = 'https://a248.e.akamai.net/cdn.hpcloudsvc.com/hdb0a98359ca04396dd429335015a1b4b/prodaw2/unixcli/v1.8.0/hpcloud-1.8.0.gem'
lookup['/file/hpcloud-1.9.0.gem'] = 'https://a248.e.akamai.net/cdn.hpcloudsvc.com/hdb0a98359ca04396dd429335015a1b4b/prodaw2/unixcli/v1.9.0/hpcloud-1.9.0.gem'
lookup['/file/hpcloud-1.9.1.gem'] = 'https://a248.e.akamai.net/cdn.hpcloudsvc.com/hdb0a98359ca04396dd429335015a1b4b/prodaw2/unixcli/v1.9.1/hpcloud-1.9.1.gem'
lookup['/file/hpcloud-2.0.0.gem'] = 'https://region-a.geo-1.objects.hpcloudsvc.com:443/v1/89388614989714/documentation-downloads/unixcli/v2.0.0/hpcloud-2.0.0.gem'
lookup['/file/hpcloud-test.gem'] = 'https://a248.e.akamai.net/cdn.hpcloudsvc.com/hdb0a98359ca04396dd429335015a1b4b/prodaw2/unixcli/hpcloud-test.gem'
lookup['/file/hpcloud.gem'] = 'https://a248.e.akamai.net/cdn.hpcloudsvc.com/hdb0a98359ca04396dd429335015a1b4b/prodaw2/unixcli/v1.9.1/hpcloud-1.9.1.gem'
lookup['/file/hpfog-0.0.16.gem'] = 'https://a248.e.akamai.net/cdn.hpcloudsvc.com/hdb0a98359ca04396dd429335015a1b4b/prodaw2/hpfog-0.0.16.gem'
lookup['/file/hpfog-0.0.17.gem'] = 'https://a248.e.akamai.net/cdn.hpcloudsvc.com/hdb0a98359ca04396dd429335015a1b4b/prodaw2/hpfog-0.0.17.gem'
lookup['/file/hpfog-0.0.18.gem'] = 'https://a248.e.akamai.net/cdn.hpcloudsvc.com/hdb0a98359ca04396dd429335015a1b4b/prodaw2/hpfog-0.0.18.gem'
lookup['/file/hpfog-0.0.19.gem'] = 'https://a248.e.akamai.net/cdn.hpcloudsvc.com/hdb0a98359ca04396dd429335015a1b4b/prodaw2/hpfog-0.0.19.gem'
lookup['/file/hpfog-0.0.20.gem'] = 'https://a248.e.akamai.net/cdn.hpcloudsvc.com/hdb0a98359ca04396dd429335015a1b4b/prodaw2/hpfog-0.0.20.gem'
lookup['/file/hpfog.gem'] = 'https://a248.e.akamai.net/cdn.hpcloudsvc.com/hdb0a98359ca04396dd429335015a1b4b/prodaw2/hpfog.gem'
lookup['/file/hpNET-1.3.0.6.nupkg'] = 'https://a248.e.akamai.net/cdn.hpcloudsvc.com/hdb0a98359ca04396dd429335015a1b4b/prodaw2/HPCloud-API.1.3.0.6.nupkg'
lookup['/file/hpPHP-1.1.0.zip'] = 'https://a248.e.akamai.net/cdn.hpcloudsvc.com/hdb0a98359ca04396dd429335015a1b4b/prodaw2/HPCloud-PHP-1.1.0.zip'
lookup['/file/nova-stuff.tar'] = 'https://a248.e.akamai.net/cdn.hpcloudsvc.com/hdb0a98359ca04396dd429335015a1b4b/prodaw2/prettytable-0.5.tar.gz'
lookup['/file/python-novaclient-debian.deb'] = 'https://a248.e.akamai.net/cdn.hpcloudsvc.com/hdb0a98359ca04396dd429335015a1b4b/prodaw2/python-novaclient_2-5.6.8-1hp10_all.deb'
lookup['/file/python-novaclient.tar'] = 'https://a248.e.akamai.net/cdn.hpcloudsvc.com/hdb0a98359ca04396dd429335015a1b4b/prodaw2/python-novaclient_2-3.6.8-1hp10.tar.gz'
lookup['/file/python-novaclient_2.6.8.deb'] = 'https://a248.e.akamai.net/cdn.hpcloudsvc.com/hdb0a98359ca04396dd429335015a1b4b/prodaw2/python-novaclient_2.6.8-1hp15_all.deb'
lookup['/file/python-novaclient_2.6.8.tar.gz'] = 'https://a248.e.akamai.net/cdn.hpcloudsvc.com/hdb0a98359ca04396dd429335015a1b4b/prodaw2/python-novaclient_2.6.8-1hp15.tar.gz'
lookup['/file/Python-novaclient2.6.8.zip'] = 'https://a248.e.akamai.net/cdn.hpcloudsvc.com/hdb0a98359ca04396dd429335015a1b4b/prodaw2/python-novaclient_2.6.8-1hp15.zip'
lookup['/file/python-novaclient_2.6.8-17.tar.gz'] = 'https://a248.e.akamai.net/cdn.hpcloudsvc.com/hdb0a98359ca04396dd429335015a1b4b/prodaw2/python-novaclient_2.6.8-1hp17.tar.gz'
lookup['/file/Python-novaclient2.6.8-17.zip'] = 'https://a248.e.akamai.net/cdn.hpcloudsvc.com/hdb0a98359ca04396dd429335015a1b4b/prodaw2/python-novaclient_2.6.8-1hp17.zip'
lookup['/file/python-novaclient_2.6.8-17.deb'] = 'https://a248.e.akamai.net/cdn.hpcloudsvc.com/hdb0a98359ca04396dd429335015a1b4b/prodaw2/python-novaclient_2.6.8-1hp17_all.deb'
lookup['/file/WinCLI-1.3.3.8.zip'] = 'https://a248.e.akamai.net/cdn.hpcloudsvc.com/hdb0a98359ca04396dd429335015a1b4b/prodaw2/WinCLI-1.3.3.8.zip'
lookup['/file/WinCLI-1.3.3.9.zip'] = 'https://a248.e.akamai.net/cdn.hpcloudsvc.com/hdb0a98359ca04396dd429335015a1b4b/prodaw2/WinCLI-1.3.3.9.zip'


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
