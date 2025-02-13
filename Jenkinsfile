pipeline{
    agent any
    stages{
        stage("Validate the file"){
            steps{
                script{
                    sh "terraform fmt --check -recursive" 
                }
            }
        }
        stage("Initialize and validate the terraform"){
            matrix{
                axes{
                    axis{
                        name 'ENV_DIR'
                        values 'gcp-project-demo', 'gcp-project-dev'
                    }
                }
                stages{
                    stage("Initialize Terraform"){
                        steps{
                            dir("${ENV_DIR}") {
                                steps{
                                    sh "terraform init"
                                }
                            }
                        }
                    }

                    stage("Validate Terraform"){
                        steps{
                            dir("${ENV_DIR}") {
                                script{
                                    sh "terraform validate"
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}