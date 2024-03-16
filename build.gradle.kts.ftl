import org.jetbrains.kotlin.gradle.tasks.KotlinCompile
import io.izzel.taboolib.gradle.*
<#if extraPackages ??>
<#list extraPackages as extraPackage>
${extraPackage}
</#list>
</#if>


plugins {
    java
    id("io.izzel.taboolib") version "2.0.9"
    id("org.jetbrains.kotlin.jvm") version "1.8.22"
}

taboolib {
    env {
        <#list modules as module>
        install(${module})
        </#list>
    }
    description {
        name = "${name}"
        <#if description?has_content>
        desc("${description}")
        </#if>
        <#if authors ??>
        contributors {
            <#list authors as author>
            name("${author}")
            </#list>
        }
        </#if>
        <#if website?exists>
        links {
            name("${website}")
        }
        </#if>
        <#if dependencies ?? || softDependencies??>
        dependencies {
        <#if dependencies ??>
            <#list dependencies as dependency>
            name("${dependency}")
            </#list>
        </#if>
        <#if softDependencies ??>
            <#list softDependencies as softDependency>
            name("${softDependency}").optional(true)
            </#list>
        </#if>
        }
        </#if>
    }
    version { taboolib = "6.1.0" }
}

repositories {
    mavenCentral()
}

dependencies {
    compileOnly("ink.ptms.core:v12004:12004:mapped")
    compileOnly("ink.ptms.core:v12004:12004:universal")
    compileOnly(kotlin("stdlib"))
    compileOnly(fileTree("libs"))
}

tasks.withType<JavaCompile> {
    options.encoding = "UTF-8"
}

tasks.withType<KotlinCompile> {
    kotlinOptions {
        jvmTarget = "1.8"
        freeCompilerArgs = listOf("-Xjvm-default=all")
    }
}

configure<JavaPluginConvention> {
    sourceCompatibility = JavaVersion.VERSION_1_8
    targetCompatibility = JavaVersion.VERSION_1_8
}