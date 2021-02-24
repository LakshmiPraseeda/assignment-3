pipeline
{
  agent any
  environment{
          PATH = "/opt/maven/apache-maven-3.6.3/bin:$PATH"
      }
    stages
	{
	stage('SCM GitCheckout'){
	      steps{
		    git credentialsId: 'fa1cca99-4fd9-4632-ba81-06fd2f6699fc', url: 'https://github.com/LakshmiPraseeda/JenkinsWar.git'
		    }
		  }
		stage('maven test'){
		    steps{
		sh "mvn --version"
		sh "mvn clean test surefire-report:report"
		}
             }
        stage('Test Case and Reports'){
           steps{
        echo "executing the test cases"
        junit allowEmptyResults: true, testResults: '/var/lib/jenkins/workspace/Jenkins_git_maven_docker_terra_s3_1/target/surefire-reports/*.xml'
        publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: '/var/lib/jenkins/workspace/Jenkins_git_maven_docker_terra_s3_1/target/site', reportFiles: 'surefire-report.html', reportName: 'SureFireReportsHTML', reportTitles: ''])
        }
	}
	stage('Package and Generate artifacts'){
	steps{
	sh "mvn clean package -DskipTests=true"
	}
	}
	stage('deployment of Application using Docker'){
	steps{
	sh "docker version"
	sh "cd /opt/docker; docker build  -t praseeda:newtag -f Dockerfile ."
	sh "docker run -p 1234:8080 -d praseeda:newtag"

	}
	}
	stage('War file to S3'){
	steps{
	withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws-credentials', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
        // some block
        sh "aws s3 ls "
        sh "aws s3 mb s3://praseeda-bucket-for-aws"
        sh "aws s3 cp /var/lib/jenkins/workspace/pipelinedemo/target/JenkinsWar.war s3://praseeda-bucket-for-aws"
    }
	}
	}
}
}
