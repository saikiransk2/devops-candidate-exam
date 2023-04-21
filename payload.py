import http.client
import json
import base64

def lambda_handler(event, context):
    url = "https://ij92qpvpma.execute-api.eu-west-1.amazonaws.com/candidate-email_serverless_lambda_stage/data"
    headers = {"X-Siemens-Auth": "test"}
    payload = {
        "subnet_id": "subnet-04625301f1d2eee6a",
        "name": "sai.kiran",
        "email": "sai.kiran@siemens.com"
    }
    
    data = json.dumps(payload)

    conn = http.client.HTTPSConnection(url)
    conn.request('POST', '/post', data, headers)
    response = conn.getresponse()
    print(response.read().decode())