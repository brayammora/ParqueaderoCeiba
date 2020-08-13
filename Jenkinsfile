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
	sh 'xcodebuild -scheme "ParqueaderoCeiba" clean build CODE_SIGNING_REQUIRED=NO CODE_SIGNING_ALLOWED="NO"'
    }

    stage('Test') {

        // Test project.
	sh 'xcodebuild -scheme "ParqueaderoCeiba" test -destination "platform=iOS Simulator,name=iPhone SE (2nd generation),OS=latest" CODE_SIGNING_REQUIRED=NO CODE_SIGNING_ALLOWED="NO"'
    }

	
}
