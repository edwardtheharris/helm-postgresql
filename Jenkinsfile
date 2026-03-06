// Uses Declarative syntax to run
env.PROJECT_NAME="postgres"
stage('checkout') {
  env.POD_LABEL="helm"
  podTemplate(agentContainer: 'helm', cloud: 'the-hard-way',
              containers: [
              containerTemplate(alwaysPullImage: true, command: '/usr/local/bin/jenkins-agent',
                      image: 'ghcr.io/edwardtheharris/helm-jenkins/helm:0.0.1-10', livenessProbe: containerLivenessProbe(execArgs: '',
                      failureThreshold: 0, initialDelaySeconds: 0, periodSeconds: 0,
                      successThreshold: 0, timeoutSeconds: 0),
              name: 'helm', resourceLimitCpu: '', resourceLimitEphemeralStorage: '', resourceLimitMemory: '',
              resourceRequestCpu: '', resourceRequestEphemeralStorage: '',
              resourceRequestMemory: '', ttyEnabled: true,
              workingDir: '/home/jenkins/agent')], label: 'helm',
              name: 'helm', namespace: 'jenkins') {
    node("${env.POD_LABEL}") {
      gitHubPRStatus(githubPRMessage('${GITHUB_PR_COND_REF} run started'))
      container('helm') {
        ansiColor('xterm') {
          sh("helm create ${env.PROJECT_NAME}")
          tar archive: true, compress: false, defaultExcludes: false, dir: "${env.PROJECT_NAME}", exclude: '', file: "${env.PROJECT_NAME}.${env.BUILD_NUMBER}.tar", glob: '', overwrite: false
        }
      }
    }
  }
}
stage('test') {
  podTemplate(agentContainer: 'helm', cloud: 'the-hard-way',
              containers: [
                containerTemplate(alwaysPullImage: true, command: '/usr/local/bin/jenkins-agent',
                                  image: 'ghcr.io/edwardtheharris/helm-jenkins/helm:0.0.2-00',
                                  livenessProbe: containerLivenessProbe(execArgs: '',
                                                                        failureThreshold: 0,
                                                                        initialDelaySeconds: 0,
                                                                        periodSeconds: 0,
                                                                        successThreshold: 0,
                                                                        timeoutSeconds: 0),
              name: 'helm', resourceLimitCpu: '', resourceLimitEphemeralStorage: '', resourceLimitMemory: '',
              resourceRequestCpu: '', resourceRequestEphemeralStorage: '',
              resourceRequestMemory: '', ttyEnabled: true,
              workingDir: '/home/jenkins/agent')], label: 'helm',
              name: 'helm', namespace: 'jenkins') {
    node("${env.POD_LABEL}") {
        gitHubPRStatus(githubPRMessage('${GITHUB_PR_COND_REF} run started'))
        container('helm') {
          ansiColor('xterm') {
            checkout scm
            echo("helm create tarball for ${env.JOB_BASE_NAME}")
            tar(archive: true, compress: false, defaultExcludes: false, dir: '.', exclude: '', file: "${env.JOB_BASE_NAME}.${env.BUILD_NUMBER}.tar", glob: '', overwrite: false)
          }
        }
      }
    }
  }
stage("lint") {
  parallel helm: {
    podTemplate(agentContainer: 'helm', cloud: 'the-hard-way',
              containers: [
                containerTemplate(
                  alwaysPullImage: true, command: '/usr/local/bin/jenkins-agent',
                  image: 'ghcr.io/edwardtheharris/helm-jenkins/helm:0.0.2-00',
                  livenessProbe: containerLivenessProbe(execArgs: '',
                  failureThreshold: 0, initialDelaySeconds: 0, periodSeconds: 0,
                  successThreshold: 0, timeoutSeconds: 0),
                  name: 'helm', resourceLimitCpu: '', resourceLimitEphemeralStorage: '', resourceLimitMemory: '',
                  resourceRequestCpu: '', resourceRequestEphemeralStorage: '',
                  resourceRequestMemory: '', ttyEnabled: true,
                  workingDir: '/home/jenkins/agent'
                )
              ], 
              label: 'helm',
              name: 'helm', namespace: 'jenkins') {
      node("${env.POD_LABEL}") {
        container("helm") {
          ansiColor('xterm') {
            echo("lint the helm chart on ${env.BRANCH_NAME}")
            checkout scm
            sh(script: '''
              #!/bin/bash
              ls --color -lah
              for i in comms.values.yaml thw.values.yaml values.yaml; do
                helm lint . -f $i
              done
            ''', label: "lint the chart")
          }
        }
      }
    }
    podTemplate(
      agentContainer: 'mdlint', 
      cloud: 'the-hard-way',
      containers: [
        containerTemplate(
          alwaysPullImage: true,
          image: 'davidanson/markdownlint-cli2:v0.21.0',
          name: 'mdlint'
        )
      ],
      label: 'mdlint',
      name: 'mdlint',
      namespace: 'jenkins'
    ) {
      node("mdlint") {
        ansiColor('xterm') {
          container('mdlint') {
            checkout scm
            sh("\"**/*.md\" \"*.md\"")
          }
        }
      }
    }
  }
}
stage("helm unittests") {
  podTemplate(agentContainer: 'helm', cloud: 'the-hard-way',
              containers: [
              containerTemplate(alwaysPullImage: true, command: '/usr/local/bin/jenkins-agent',
                      image: 'ghcr.io/edwardtheharris/helm-jenkins/helm:0.0.2-00', livenessProbe: containerLivenessProbe(execArgs: '',
                      failureThreshold: 0, initialDelaySeconds: 0, periodSeconds: 0,
                      successThreshold: 0, timeoutSeconds: 0),
              name: 'helm', resourceLimitCpu: '', resourceLimitEphemeralStorage: '', resourceLimitMemory: '',
              resourceRequestCpu: '', resourceRequestEphemeralStorage: '',
              resourceRequestMemory: '', ttyEnabled: true,
              workingDir: '/home/jenkins/agent')], label: 'helm',
              name: 'helm', namespace: 'jenkins') {
    parallel helm: {
      node("${env.POD_LABEL}") {
        container('helm') {
          ansiColor('xterm') {
            checkout scm
            echo("Run helm unittests for ${env.BRANCH_NAME}")
            sh("helm unittest --color -u -f 'tests/*.yaml' .")
          }
        }
        container('helm') {
          ansiColor('xterm') {
            checkout scm
            echo("Save report for ${env.BRANCH_NAME}")
            sh("helm unittest -u -t JUnit -o results-${env.BRANCH_NAME}.xml .")
            junit("results-${env.BRANCH_NAME}.xml")
          }
        }
        container('helm') {
          ansiColor('xterm') {
            checkout scm
            echo("Publish report for ${env.BRANCH_NAME}")
            githubPRComment(comment: githubPRMessage(sh("helm unittest --color -u -f 'tests/*yaml' .")))
          }
        }
      }
    }
  }
}

