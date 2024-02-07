const AWS = require('aws-sdk');
const mysql = require('mysql');

exports.handler = async (event) => {
  const secretsManager = new AWS.SecretsManager();
  const secretData = await secretsManager.getSecretValue({ SecretId: 'freetier/mysql' }).promise();
  const { username, password, host, port } = JSON.parse(secretData.SecretString);

  console.log(username);
  let maskedSecret = password.slice(0, 6) + '*'.repeat(password.length - 10) + password.slice(-4);

  console.log('Masked Secret: ', maskedSecret);

  const connection = mysql.createConnection({
    host: host,
    user: username,
    password: password,
    port: port,
    database: 'database-free-tier'
  });
  connection.connect();
  return new Promise((resolve, reject) => {
    connection.query('SHOW DATABASES', function (error, results, fields) {
        if (error) reject(error);
        else resolve(results);
      });
  });
  
}