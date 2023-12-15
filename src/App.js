import logo from './logo.svg';
import './App.css';
import { API, Auth } from 'aws-amplify';
import { withAuthenticator } from '@aws-amplify/ui-react';
import { useState } from 'react';
import '@aws-amplify/ui-react/styles.css';

function App() {
  const [message, setMessage] = useState("waiting for api response")

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
      </header>
    </div>
  );
}

export default withAuthenticator(App);
