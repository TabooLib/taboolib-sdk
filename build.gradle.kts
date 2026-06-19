import io.izzel.taboolib.gradle.*
import org.jetbrains.kotlin.gradle.tasks.KotlinCompile

plugins {
    java
    `maven-publish`
    kotlin("jvm") version "2.1.10"
    kotlin("plugin.serialization") version "2.1.0"
    id("io.izzel.taboolib") version "2.0.31"
}

taboolib {
    env {
        // 安装模块
        install(Basic, Bukkit, BukkitUtil, BukkitNMSUtil, BukkitNMSEntityAI, BukkitUI, Kether)
        install(MinecraftChat, MinecraftEffect, BukkitNavigation)
        install(CommandHelper)
    }
    version { taboolib = "6.3.0-a1d3953" }
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

// 可分发插件 JAR 输出到项目根目录 dist/，便于与 Gradle 中间产物 build/ 分离
tasks.jar {
    destinationDirectory.set(layout.projectDirectory.dir("dist"))
}
