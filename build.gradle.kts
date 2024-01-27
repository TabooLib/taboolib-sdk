import io.izzel.taboolib.gradle.*
import org.jetbrains.kotlin.gradle.tasks.KotlinCompile

plugins {
    java
    id("io.izzel.taboolib") version "2.0.0"
    id("org.jetbrains.kotlin.jvm") version "1.8.22"
}

taboolib {
    env {
        // 安装模块
        install(BUKKIT)
    }
    version { taboolib = "6.1.0" }
}

repositories {
    mavenLocal()
    mavenCentral()
}

dependencies {
    compileOnly("ink.ptms.core:v12004:12004:mapped")
    compileOnly("ink.ptms.core:v12004:v12004:universal")
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

// 用于开发模式，删除本地缓存
tasks.register("refreshDependencies") {
    doLast {
        val taboolibFile = File("../../caches/modules-2/files-2.1/io.izzel.taboolib").canonicalFile
        taboolibFile.listFiles()?.forEach { module ->
            val file = File(taboolibFile, "${module.name}/${taboolib.version.taboolib}")
            if (file.exists()) {
                file.deleteRecursively()
            }
        }
    }
}