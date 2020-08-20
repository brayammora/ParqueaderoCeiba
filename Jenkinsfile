node('Slave4_Mac') {

    stage('Checkout') {

        // Checkout files.
        checkout([
            $class: 'GitSCM',
            branches: [[name: 'master']],
            doGenerateSubmoduleConfigurations: false,
            extensions: [], submoduleCfg: [],
            userRemoteConfigs: [[
                name: 'github',
                url: 'https://github.com/brayammora/ParqueaderoCeiba.git'
            ]]
        ])
    }

    stage('Build') {

        // Build 
	// sh 'xcodebuild -scheme "ParqueaderoCeiba" clean build CODE_SIGNING_REQUIRED=NO CODE_SIGNING_ALLOWED="NO"'
	// sh 'xcodebuild clean build CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO CODE_SIGN_ENTITLEMENTS="" CODE_SIGNING_ALLOWED="NO"'
	echo "Building..."
    }

    stage('Test') {

        // Test project.
	// sh 'xcodebuild -scheme "ParqueaderoCeiba" test -destination "platform=iOS Simulator,name=iPhone SE (2nd generation),OS=latest" CODE_SIGNING_REQUIRED=NO CODE_SIGNING_ALLOWED="NO"'
	echo "Testing..."
    }

    stage('Static Code Analysis') {
      steps{
	// Sonar Analysis
        withSonarQubeEnv('Sonar') {
        sh "${tool name: 'SonarScanner', type:'hudson.plugins.sonar.SonarRunnerInstallation'}/bin/sonar-scanner -Dproject.settings=sonar-project.properties"
        }
      }
    }
	
}
