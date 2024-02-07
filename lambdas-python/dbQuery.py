# ./lambdas/dbQuery.py

import boto3
import mysql.connector
import json

def lambda_handler(event, context):
    secretsmanager = boto3.client('secretsmanager')
    secret_data = secretsmanager.get_secret_value(SecretId='your-secret-id')
    secret_string = json.loads(secret_data['SecretString'])
    username = secret_string['username']
    password = secret_string['password']
    host = secret_string['host']
    port = secret_string['port']

    print(username)

    connection = mysql.connector.connect(host=host, user=username, password=password, port=port, database='your-database-name')
    cursor = connection.cursor()
    cursor.execute('SELECT * FROM your-table-name')
    rows = cursor.fetchall()