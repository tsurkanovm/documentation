#### full static re-build by odocker:
odg clean:test && odg exec:test && odg less:test
'test' - name of the theme
odg - it is alias for bin/grunt that run into docker container
#### new Grunt tasks
add into Gruntfile.js bottom
```javascript
 // tsum
        grunt.registerTask('compile', ['clean', 'exec', 'less']);
        grunt.registerTask('default', ['compile', 'watch']);
```
`odg compile` - will work as odg clean:test && odg exec:test && odg less:test
`odg` - should run compile + watch, but on my tests its not working (I suppose cause odocker configuration), but `odg default` works well so not bad