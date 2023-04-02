# Introduction 
TODO: This is a test case of using a Kubernetes cluster managed by EKS to run an Agent Pool that will be compatible with AWS-Cardprocessor, Copernicus-AWS, and AWSBLD at SWBC.

# Getting Started
TODO: Guide users through getting your code up and running on their own system. In this section you can talk about:
1.	Installation process
2.	Software dependencies
3.	Latest releases
4.	API references

# Build and Test
TODO: Describe and show how to build your code and run the tests. 

# Contribute
TODO: Explain how other users and developers can contribute to make your code better. 

# Thesis

The idea is to use a Sysbox enabled cluster to then run images of CentOS with the dependencies from machines in the three agent pools. I don't think it would be a huge security violation to list them here, but maybe? I guess we'll see.

Step 1:

I'll be working in the AWS DevOps sandbox account: #910525265351 using the DevOps-Sandbox role. 

aws ec2 create-key-pair --region us-east-1 --key-name awsEksKey

This generated an SSH key, which before I save it I will add to the .gitignore

Documentation located [here](https://github.com/nestybox/sysbox/blob/master/docs/user-guide/install-k8s-distros.md#aws-elastic-kubernetes-service-eks). I'll iterate on it in order to understand what's happening.

If you want to learn more about creating good readme files then refer the following [guidelines](https://docs.microsoft.com/en-us/azure/devops/repos/git/create-a-readme?view=azure-devops). You can also seek inspiration from the below readme files:
- [ASP.NET Core](https://github.com/aspnet/Home)
- [Visual Studio Code](https://github.com/Microsoft/vscode)
- [Chakra Core](https://github.com/Microsoft/ChakraCore)