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

    stage('Build/Test') {

        // Build and test project.
        sh 'xcodebuild -scheme "ParqueaderoCeiba" -configuration "Debug" clean build test -destination "platform:iOS Simulator, OS:latest, name:iPhone 8"' 
	      
    }

}
