import org.jetbrains.kotlin.gradle.tasks.KotlinCompile
import io.izzel.taboolib.gradle.*
import org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_1_8
<#if extraPackages ??>
<#list extraPackages as extraPackage>
${extraPackage}
</#list>
</#if>


plugins {
    java
    id("io.izzel.taboolib") version "2.0.27"
    id("org.jetbrains.kotlin.jvm") version "2.2.0"
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
    version { taboolib = "${tabooVersion}" }
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
    compilerOptions {
        jvmTarget.set(JVM_1_8)
        freeCompilerArgs.add("-Xjvm-default=all")
    }
}

java {
    sourceCompatibility = JavaVersion.VERSION_1_8
    targetCompatibility = JavaVersion.VERSION_1_8
}