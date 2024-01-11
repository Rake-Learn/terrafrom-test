pipeline {

    parameters {
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
    } 
    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }

   agent  any
    stages {
        stage('checkout') {
            steps {
                 script{
                        dir("terraform")
                        {
                            git "https://github.com/Rake-Learn/terraform-learning.git"
                        }
                    }
                }
            }
        // stage('Debug') {
        //     steps {
        //         script {
        //                 dir("terraform") {
        //                 sh 'ls -la'  // Print directory contents
        //                 }
        //             }
        //         }
        //     }
       stage('Plan') {
            steps {
                script {
                    dir("terraform") {
                        sh '/opt/homebrew/bin/terraform init'
                        sh '/opt/homebrew/bin/terraform plan -out tfplan'
                        sh '/opt/homebrew/bin/terraform show -no-color tfplan > tfplan.txt'
                    }
                }
            }   
        }
        stage('Approval') {
           when {
               not {
                   equals expected: true, actual: params.autoApprove
               }
           }

           steps {
               script {
                    def plan = readFile 'terraform/tfplan.txt'
                    input message: "Do you want to apply the plan?",
                    parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
               }
           }
       }

        stage('Apply') {
            steps {
                script {
                    dir("terraform") {
                        sh '/opt/homebrew/bin/terraform apply -auto-approve'
                        sh '/opt/homebrew/bin/terraform output'   // Print Terraform outputs
                    }
                }
            }
        }
        // stage('Destroy') {
        //     steps {
        //         script {
        //             dir("terraform") {
        //                 sh '/opt/homebrew/bin/terraform destroy -auto-approve'
        //             }
        //         }
        //     }
        // }

    }
}
