# TabooLib SDK

## Settings
```groovy
taboolib {
    tabooLibVersion = '5.47'
    loaderVersion = '2.10'
    classifier = null
    // relocate package
    relocate('io.izzel.taboolib', 'ink.ptms.taboolib')
    // built-in
    builtin = true
}
```

## Release Source Code
````groovy
processResources {
    from(sourceSets.main.allSource) {
    exclude 'plugin.yml'
}
````
