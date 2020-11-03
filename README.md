#TO RUN THIS REPO
Clone the repo
# git clone https://github.com/onaiv22/devops-test.git
cd wipro/devops-test

Pre-checks before running this infrastructure.
The terraform version used for this work is Terraform v0.12.24
ensure you change aws profile to your profile with right right permissions/policy to run the relevant resources.
Note for lack of time I have manually created role and attached that to ec2 instance- this you will find under launch-configuration(instace_profile)
The role is to have access to your objects in s3 bucket. this is the repo for the node js app.

See TODO for a list of what is left to be done.

This will create the following
- 1 vpc
- 2 public subnets
- 1 internet gateway attached to the vpc
- 2 route tables attached 1 per subnet
- 1 Application load balancer with sg attached listening to public traffic on port 80
- 1 listener
- 1 target group which routes traffic to backend server.
- 1 autoscaling group with a launch configuration with a min instance of 2 and max of 4
- 2 ubuntu ec2 instances with sg recieving traffic on port 3000.
I have used user data to bootstrap the server at start up so it comes up with the app. aws cli copies the file from s3 so NOTE you have to do this part first as i could complete this as a result of time.

files to copy into s3 are; index.js, package.json and index.test.js
















# DevOps Engineer - Technical Test
We think infrastructure is best represented as code, and provisioning of resources should be automated as much as possible.

 Your task is to create a CI build pipeline that deploys this web application to a load-balanced
environment. You are free to complete the test in a local environment (using tools like Vagrant and
Docker) or use any CI service, provisioning tool and cloud environment you feel comfortable with (we
recommend creating a free tier account so you don't incur any costs).

 * Your CI job should:
  * Run when a feature branch is pushed to Github (you should fork this repository to your Github account). If you are working locally feel free to use some other method for triggering your build.
  * Deploy to a target environment when the job is successful.
* The target environment should consist of:
  * A load-balancer accessible via HTTP on port 80.
  * Two application servers (this repository) accessible via HTTP on port 3000.
* The load-balancer should use a round-robin strategy.
* The application server should return the response "Hi there! I'm being served from {hostname}!".

 ## Context
We are testing your ability to implement modern automated infrastructure, as well as general knowledge of system administration. In your solution you should emphasize readability, maintainability and DevOps methodologies.

 ## Submit your solution
Create a public Github repository and push your solution in it. Commit often - we would rather see a history of trial and error than a single monolithic push. When you're finished, send us the URL to the repository.

 ## Running this web application
 This is a NodeJS application:	This is a NodeJS application:

- `npm test` runs the application tests	- `npm test` runs the application tests
- `npm start` starts the http server
