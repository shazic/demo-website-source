pipeline{
    agent any
    parameters{
        string(
            name: 'gitCredentials',
            defaultValue: 'GitHubSSH',
            description: 'Credentials to access the git repository'
        )
        string(
            name: 'RepoUrl',
            defaultValue: 'git@github.com:shazic/demo-website-source.git',
            description: 'SSH URL to the repository'
        )
        string(
            name: 'branchname',
            defaultValue: 'master',
            description: 'Branch name of the git repository'
        )

    }
    stages{
        stage('Download Source'){
            agent any
            steps{
                git credentialsId: "${params.gitCredentials}", url: "${params.RepoUrl}", branch: "${params.branchname}"
                withCredentials(bindings: [sshUserPrivateKey(credentialsId: 'GitHubSSH', keyFileVariable: 'KEY_PATH', passphraseVariable: '', usernameVariable: '')]) {
                    sh '''
                     eval "$(ssh-agent -s)"
                     ssh-add $KEY_PATH
                    '''
                }
                sh " git submodule update --init"
                
            }
        }
        stage('Generate website'){
            agent {
                dockerfile true
            }
            steps{
                dir('site'){
                    sh "hugo"
                    sh "ls -a public/"
                }
            }
        }
        stage('Upload to S3'){
            steps{
                script{
                    echo "upload code goes here"
                }
                
            }
        }
    }
}