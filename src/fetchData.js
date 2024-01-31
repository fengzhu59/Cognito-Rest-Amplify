import config from './aws-exports';

const callApiWithAPIKey = () => {
  const apiInfo = config.aws_cloud_logic_custom.find(e => e.name === 'restAppApi');
  const apiEndpoint = apiInfo.endpoint;
  
    return fetch(apiEndpoint, {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json',
        'x-api-key': '573b9734-9bbf-4831-af93-2a1067047e15'
      },
    })
    .then(response => response.json())
    .catch((error) => {
      console.error('Error:', error);
    });
  }
  
  export default callApiWithAPIKey;