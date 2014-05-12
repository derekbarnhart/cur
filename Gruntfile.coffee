gruntModules = [
    "grunt-contrib-less"
    "grunt-contrib-watch"
    "grunt-contrib-coffee"
    "grunt-exec"
]

module.exports = (grunt) ->
    grunt.initConfig
        watch:
            coffee_cmd:
                files: ['source/lib/commands/**/*.coffee']
                tasks: ['coffee:cmd']
            coffee_lib:
                files: ['source/lib/**/*.coffee']
                tasks: ['coffee:lib']
        coffee:
            options:
                bare:true
            cmd:
                expand: true
                flatten: false
                cwd: "source/lib/commands"
                src: ['*.coffee']
                dest: 'lib/commands'
                ext: '.js'
            lib:
                expand: true
                flatten: false
                cwd: "source/lib/"
                src: ['*.coffee']
                dest: 'lib'
                ext: '.js'
        less:
            default:
                expand: true
                flatten: false
                #TODO make a more sensible place for less files
                src: ['public/stylesheets/**/*.less']
                dest: ''
                ext: '.css'
        exec:
            static: 'echo "yes\n" | ./manage.py collectstatic'

    # register the task
    grunt.loadNpmTasks gmod for gmod in gruntModules


    grunt.registerTask 'default', ['coffee', 'less']