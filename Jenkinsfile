node('Slave4_Mac') {

    stage('Checkout/Build/Test') {

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

        // Build and Test!
        // sh 'xcodebuild -scheme "ParqueaderoCeiba" -configuration "Debug" build test -destination "platform=iOS Simulator,name=iPhone 11 Pro,OS=13.6"'

	// Publish test restults.
	// step([$class: 'JUnitResultArchiver', allowEmptyResults: true, testResults: 'build/reports/junit.xml'])

	// Generate Code Coverage report
	// sh '/usr/local/bin/slather coverage --jenkins --html --scheme ParqueaderoCeiba ParqueaderoCeiba.xcodeproj/'

	// Publish coverage results
	// publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: 'html', reportFiles: 'index.html', reportName: 'Coverage Report'])

	// Generate Checkstyle report
	// sh '/usr/local/bin/swiftlint lint --reporter checkstyle > checkstyle.xml || true'

	// Send slack notification
	// slackSend channel: '#my-team', message: 'Time Table - Successfully', teamDomain: 'my-team', token: 'my-token'
    }
}
