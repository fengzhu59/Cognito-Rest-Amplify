import config from './aws-exports';
import AWS from 'aws-sdk';

const secretsManager = new AWS.SecretsManager();
const callApiWithAPIKey = async () => {
  const apiInfo = config.aws_cloud_logic_custom.find(e => e.name === 'restAppApi');
  const apiEndpoint = apiInfo.endpoint;
  
  let apiKey;
  try {
    const secretData = await secretsManager.getSecretValue({ SecretId: 'my-secret-id' }).promise();
    apiKey = JSON.parse(secretData.SecretString).apiKey;
  } catch (error) {
    console.error('Error:', error);
    return;
  }
    return fetch(apiEndpoint, {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json',
        'x-api-key': apiKey
      },
    })
    .then(response => response.json())
    .catch((error) => {
      console.error('Error:', error);
    });
  }
  
  export default callApiWithAPIKey;