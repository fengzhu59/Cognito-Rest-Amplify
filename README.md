# Training Demo App
Demo react app to showcase Oauth2.0 code grant flow with AWS cognito, API gateway and Amplify.

This project is put together quickly for demo purpuse only. We use create react app and AWS amplify to speed things up. We want to be clear that these tech choice are not desired for a production-grade development.

## Credit
The code is mostly based on Nader Dabit's youtube video. https://www.youtube.com/watch?v=fs9HfYbWjXQ&list=WL&index=5&ab_channel=NaderDabit

## Initial setup required

- An free AWS account

### install the following tools

- aws cli
- amplify cli

### Setup aws profile
- Login to your AWS account via AWS console
- Goto IAM and create and IAM user with aws-managed policy AdministratorAccess-Amplify
![Alt text](image.png)
- In your local termerial
    - configure your aws cli with your IAM user via access key following the official guide https://docs.aws.amazon.com/cli/latest/userguide/cli-authentication-user.html#cli-authentication-user-configure.title
    - note that using access key is not recommended for security reason, however amplify does not work with aws sso user yet https://github.com/aws-amplify/amplify-cli/issues/4488. So we have to use it in this demo app
    - run aws s3 ls in the terminal to test your aws cli setup
### Initialize the amplify
After clone the repo, if you haven't to provision the API gateway, Cognito User Pool and the Lambda. You need to initialize your amplify to providion them. 
- amplify init
    - choose the AWS profile you have setup in previous step with aws cli
- Please follow this youtube video for the to add API gateway, auth and the Lambda.
https://www.youtube.com/watch?v=fs9HfYbWjXQ&list=WL&index=5&ab_channel=NaderDabit

### Continue working on the application
After clone the repo, if you have already provisioned the AWS resource mentioned above. You can run the following to regeneate your config (aws-exports.js) and cloudformation in the amplify folder (when you choose to changed the backend when prompted). 
You can find appId and envName in AWS console -> amplify

amplify pull --appId YOUR_APP_ID --envName APP_ENVIROMENT

## install the dependencies
- run yarn install

## Run app in dev mode

- run npm start and open [http://localhost:3000](http://localhost:3000) to view it in your browser.

