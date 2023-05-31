import requests

svc_name_i = input('Service Name : ')
request_i = input('Description : ')

url = 'https://api.anti403.ir/api/request/create'

data = f""" -----------------------------138399718122119792821236773089
Content-Disposition: form-data; name="service_name"

{svc_name_i}
-----------------------------138399718122119792821236773089
Content-Disposition: form-data; name="request"

{request_i}
-----------------------------138399718122119792821236773089--
"""

print(data)

with requests.Session() as s:
    print(s)
    p = s.post(url, data=data)
    print(data)
