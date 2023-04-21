import http.client
import json
import base64

def lambda_handler(event, context):
    url_path = "/candidate-email_serverless_lambda_stage/data"
    headers = {"X-Siemens-Auth": "test", "Content-Type": "application/json"}
    payload = {
        "subnet_id": "subnet-04625301f1d2eee6a",
        "name": "sai.kiran",
        "email": "sai.kiran@siemens.com"
    }
        
    data = json.dumps(payload)
    conn = http.client.HTTPSConnection("ij92qpvpma.execute-api.eu-west-1.amazonaws.com")
    conn.request('POST',url_path, data, headers)
    response = conn.getresponse()
    print(response.read().decode())


   