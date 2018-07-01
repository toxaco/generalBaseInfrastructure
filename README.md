Auto-Deploy instructions
---

Setup
---

### Pre

* soon.

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
