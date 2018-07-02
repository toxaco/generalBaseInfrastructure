Auto-Deploy instructions
---

Setup 123
---

### Pre

* Prepare these files:
    - Dockerrun.aws.json
    - buildspec.yml
    - .ebextensions/91_post_provision_app_deploy.config
* Create new AWS Elastic Beanstalk.
    - Create new Application.
    - Create new Environment:
        - Select: Web server environment.
        - Platform: Preconfigured platform
            - Multi-container Docker
        - Application code
            - Sample application
        - Click on "Configure more options"
        - Click in "Modify" on the "Software" square.
        - In "Environment properties" set all the application environment properties.
    - That's it's, this part is done.
* Create new AWS codepipeline.
    - Source: gihub 
        - Select repo and branch master.
    - Build: AWS Codebuild
        - Create new build project.
        - Environment image: Specify a Docker image
        - Environment type: Linux.
        - Custom image type: Other.
        - Custom image ID: toxaco/generalbaseinfrastructure:php7
        - AWS CodeBuild service role: Create a service role in your account
        - Advanced: Environment variables:
            - Set all the application Environment variables here. 
                - Type:"Plaintext".
    - Deploy.
        - AWS Elastic Beanstalk
            - Application name: Select the previous created application.
            - Environment name: Select the previous created environment.
    - AWS Service Role.
        - Role name : AWS-CodePipeline-Service (or click create new).
    - That's it's, the deployment configuration is done.
        

### Post

* soon.


Deploying
----

### Config
* Update AWS codebuild with any new environment parameter.
* Update AWS elasticbeanstalk with any new environment parameter.

### Deploy
* Push new code to master branch.
* Check AWS codepipeline for status if wanted.

### others

AWS S3 bucket police. (make sure to update the proper roles)

        {
            "Version": "2008-10-17",
            "Statement": [
                {
                    "Sid": "test",
                    "Effect": "Allow",
                    "Principal": {
                        "AWS": [
                            "arn:aws:iam::<AWS account id>:user/apps",
                            "arn:aws:iam::<AWS account id>:role/aws-elasticbeanstalk-ec2-role",
                            "arn:aws:iam::<AWS account id>:role/AWS-CodePipeline-Service"
                        ]
                    },
                    "Action": "s3:*",
                    "Resource": "arn:aws:s3:::codepipeline-eu-west-2-783384176554/variables/*"
                }
            ]
        }
