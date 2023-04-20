import requests

url = "https://ij92qpvpma.execute-api.eu-west-1.amazonaws.com/candidate-email_serverless_lambda_stage/data"
headers = {"X-Siemens-Auth": "test"}
payload = {
    "subnet_id": "nat-04bad8be564a37c70",
    "name": "sai.kiran",
    "email": "sai.kiran@siemens.com"
}

response = requests.post(url, headers=headers, json=payload)

print(response.status_code)
print(response.text)