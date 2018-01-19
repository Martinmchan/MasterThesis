
import matlab.net.*
import matlab.net.http.*
r = RequestMessage;
uri = URI('http://192.168.0.90/axis-cgi/audio/receive.cgi');

creds = Credentials('Username','root','Password','pass','Scope',uri);
options = matlab.net.http.HTTPOptions('Credentials',creds);

resp = r.send(uri,options);

k = 1
status = resp.StatusCode