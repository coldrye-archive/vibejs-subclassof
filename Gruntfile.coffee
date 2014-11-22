# TODO:FILEHEADER


# we do not want the below grunt tasks to show up
# in our task list

gruntvows = require 'grunt-vows/tasks/vows'
gruntchangelog = require 'grunt-changelog/tasks/changelog'
gruntcontribcopy = require 'grunt-contrib-copy/tasks/copy'
gruntcontribuglify = require 'grunt-contrib-uglify/tasks/uglify'
gruntistanbul = require 'grunt-istanbul/tasks/istanbul'
gruntcoffee = require 'grunt-contrib-coffee/tasks/coffee'


latebound = false

latebind = (grunt) ->

    if not latebound

        gruntvows grunt
        gruntchangelog grunt
        gruntcontribcopy grunt
        gruntcontribuglify grunt
        gruntistanbul grunt
        gruntcoffee grunt

        latebound = true

        grunt.registerTask 'assemble-npm', 'assembles the npm package (./build/npm)', ->

            # write out package.json
            pkg = grunt.file.readJSON 'package.json'
            target = './build/npm/' + pkg.name + '/'

            grunt.file.mkdir target

            # we no longer have any dependencies except for node
            delete pkg.devDependencies
            delete pkg.dependencies
            delete pkg.scripts

            # the layout of the resulting package will be shallow
            pkg.main = './index.js'

            grunt.file.write target + 'package.json', JSON.stringify pkg, null, '    '

            # copy uglified scripts
            for path in grunt.file.expand { cwd : './build/javascript/src' }, '*.js'

                grunt.file.copy './build/javascript/src/' + path, target + path

            # copy documentation
            for path in ['README.md', 'LICENSE']

                grunt.file.copy './' + path, target + path

        grunt.registerTask 'assemble-meteor', 'assembles the meteor package (./build/meteor)', ->

            pkg = grunt.config.get 'pkg'
            config = grunt.config.get 'meteor'

            packageName = "#{pkg.name.split('-')[0]}:#{pkg.name.substr(pkg.name.indexOf('-')+1)}"
            target = "./build/meteor/#{packageName}/"

            grunt.file.mkdir target

            # write out package.js
            content = "Package.describe({\n"
            content += "    name    : '#{packageName}',\n"
            content += "    version : '#{pkg.version}',\n"
            content += "    summary : '#{pkg.description}',\n"
            content += "    git     : '#{pkg.repository.url}'\n"
            content += "});\n\n"

            content += "Package.onUse(function (api) {\n"
            content += "    api.versionsFrom('#{config.dependencies.meteor}');\n"

            for file in config.files.common

                content += "    api.addFiles('#{file}');\n"

                grunt.file.copy config.srcdir + '/' + file, target + '/' + file

            for file in config.files.server

                content += "    api.addFiles('#{file}', 'server');\n"

                grunt.file.copy config.srcdir + '/' + file, target + '/' + file

            content += "});\n"

            grunt.file.write target + 'package.js', content

            # copy documentation
            for path in ['README.md', 'LICENSE']

                grunt.file.copy './' + path, target + path


module.exports = (grunt) ->

    grunt.initConfig

        pkg: grunt.file.readJSON 'package.json'

        vows :

            all :

                options :

                    # String {spec|json|dot-matrix|xunit|tap}
                    reporter: 'spec'
                    verbose: false
                    silent: false
                    colors: true 
                    # somehow, isolate will not work
                    isolate: false
                    coverage: 'json'

                src: ['./test/*.coffee']

        coffee :

            default :

                expand: true
                flatten : false
                src : ['./src/**/*.coffee', './test/**/*.coffee']
                dest : './build/javascript'
                ext : '.js'

            bare :

                options :

                    bare : true

                expand: true
                flatten : false
                src : ['./src/**/*.coffee', './test/**/*.coffee']
                dest : './build/javascript'
                ext : '.js'

        meteor:

            srcdir : './build/javascript/src'

            dependencies :

                meteor : '1.0'

            files :

                common : [
                    'monkeypatch.js'
                    'subclassof.js'
                ]

                server : [
                    'macros.js'
                ]

    grunt.registerTask 'clean', 'cleans all builds (./build)', ->

        if grunt.file.exists './build'

            grunt.file.delete './build'

    grunt.registerTask 'clean-javascript', 'cleans javascript build (./build/javascript)', ->

        if grunt.file.exists './build/javascript'

            grunt.file.delete './build/javascript'

    grunt.registerTask 'clean-uglified', 'cleans uglified javascript build (./build/uglified)', ->

        if grunt.file.exists './build/uglified'

            grunt.file.delete './build/uglified'

    grunt.registerTask 'clean-npm', 'cleans npm build (./build/npm)', ->

        if grunt.file.exists './build/npm'

            grunt.file.delete './build/npm'

    grunt.registerTask 'clean-meteor', 'cleans meteor build (./build/meteor)', ->

        if grunt.file.exists './build/meteor'

            grunt.file.delete './build/meteor'

    grunt.registerTask 'clean-coverage', 'cleans coverage build (./build/coverage)', ->

        if grunt.file.exists './build/coverage'

            grunt.file.delete './build/coverage'

    grunt.registerTask 'package-npm', 'assemble npm package (./build/npm)', ->

        latebind grunt

        grunt.task.run 'test'
        grunt.task.run 'build-javascript'
        #grunt.task.run 'build-uglified'
        grunt.task.run 'clean-npm'
        grunt.task.run 'assemble-npm'

    grunt.registerTask 'package-meteor', 'assemble meteor package (./build/meteor)', ->

        latebind grunt

        grunt.task.run 'test'
        grunt.task.run 'build-javascript:bare'
        #grunt.task.run 'build-uglified'
        grunt.task.run 'clean-meteor'
        grunt.task.run 'assemble-meteor'

    grunt.registerTask 'publish-npm', 'publish npm package', ->

        grunt.task.requires 'package-npm'

        throw new Error 'not implemented yet.'

    grunt.registerTask 'publish-meteor', 'publish npm package', ->

        grunt.task.requires 'package-meteor'

        throw new Error 'not implemented yet.'

    grunt.registerTask 'coverage', 'coverage analysis and reports (./build/coverage)', ->

        grunt.task.requires 'build-javascript'

        latebind grunt

        throw new Error 'not implemented yet.'

    grunt.registerTask 'build-javascript', 'builds the javascript, options: default|bare (./build/javascript)', (mode = 'default') ->

        latebind grunt

        grunt.task.run 'coffee:' + mode

    grunt.registerTask 'build-uglified', 'builds the uglified javascript (./build/uglified)', ->

        #grunt.task.requires 'build-javascript'
        #grunt.task.run 'clean-uglified'
        #latebind grunt

        throw new Error 'not implemented yet.'

    grunt.registerTask 'test', 'run all tests', ->

        latebind grunt

        grunt.task.run 'vows'

    grunt.registerTask 'default', [
        'clean', 'build-javascript', 'coverage', 'test', 
        'build-uglified', 'package-npm', 'package-meteor'
    ]

