import dev.s7a.gradle.minecraft.server.tasks.LaunchMinecraftServerTask
import dev.s7a.gradle.minecraft.server.tasks.LaunchMinecraftServerTask.JarUrl

plugins {
    java
    kotlin("jvm") version "1.9.0"
    id("io.izzel.taboolib") version "1.56"
    id("dev.s7a.gradle.minecraft.server") version "3.0.0"
}

taboolib {
    install("common")
    install("platform-bukkit")
    classifier = null
    version = "6.0.12-26"
}

repositories {
    mavenCentral()
}

dependencies {
    compileOnly("ink.ptms.core:v11701:11701:mapped")
    compileOnly("ink.ptms.core:v11701:11701:universal")
    compileOnly(kotlin("stdlib"))
    compileOnly(fileTree("libs"))
}

tasks.withType<JavaCompile> {
    options.encoding = "UTF-8"
}

kotlin {
    jvmToolchain(17)
    compilerOptions {
        freeCompilerArgs.add("-Xjvm-default=all")
    }
}

tasks.create<LaunchMinecraftServerTask>("launchMinecraftServer") {
    // 运行前先构建
    dependsOn("build")

    // 将构建出来的 Jar 复制到服务器插件文件夹
    doFirst {
        copy {
            from(buildDir.resolve("libs/${project.name}-${project.version}.jar"))
            into(buildDir.resolve("MinecraftServer/plugins"))
        }
    }

    // 是否接受 EULA
    agreeEula.set(true)

    // 设置服务器核心与版本
    jarUrl.set(JarUrl.Paper("1.20.2"))
}