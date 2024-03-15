import org.jetbrains.kotlin.gradle.tasks.KotlinCompile
import io.izzel.taboolib.gradle.*

plugins {
    java
    id("io.izzel.taboolib") version "2.0.9"
    id("org.jetbrains.kotlin.jvm") version "1.8.22"
}

taboolib {
    description {
        name = "${pluginName}"
        desc("${description}")
        <#if authors ??>
        contributors {
            <#list author as authors>
            name(${author})
            </#list>
        }
        </#if>
        <#if websites ??>
        links {
            <#list website as websites>
            name("#{website}")
            </#list>
        }
        </#if>
        <#if dependencies ?? || softDependencies??>
        dependencies {
            <#list dependencies as dependency>
            name("")
            </#list>
            <#list softDependencies as Softdependency>
                name("").optional(true)
            </#list>
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