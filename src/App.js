import logo from './logo.svg';
import './App.css';
import { API, Auth } from 'aws-amplify';
import { withAuthenticator } from '@aws-amplify/ui-react';
import { useState } from 'react';
import '@aws-amplify/ui-react/styles.css';
import callApiWithAPIKey from './fetchData';

function App() {
  const [message, setMessage] = useState("waiting for api response")
  const [apiData, setApiData] = useState(null);

  const handleApiCallWithAPIKey = () => {
    callApiWithAPIKey()
      .then(data => {
        setApiData("called api with API key"); // store the entire data object
      });
  }

  async function callApi() {
    const user = await Auth.currentAuthenticatedUser()
    const token = user.signInUserSession.idToken.jwtToken
    console.log({token})
    const requestInfo = {
       headers: {
        Authorization: token
      }
    }

    const data = await API.get('restAppApi', '/hello', requestInfo)
    console.log({data})
    setMessage(data)
  }
  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <p>
          Edit <code>src/App.js</code> and save to reload.
        </p>
        <button onClick={callApi}>Call API</button>
        <p>{ message }</p>
        <button onClick={handleApiCallWithAPIKey}>Call API using API key</button>
        <p>{ apiData }</p>
      </header>
    </div>
  );
}

export default withAuthenticator(App);
