# taboolib-sdk

基于 [TabooLib 6](https://docs.tabooproject.org/) 的 **Gradle + Kotlin** Bukkit 插件空工程模板。业务代码在 `src/main/kotlin`；模块与 TabooLib 版本在 `build.gradle.kts` 的 `taboolib { }` 中配置。

也可用 IDEA 插件 **TabooLib-Development** 创建/同步项目，与本模板等价，见 [TabooLib 文档](https://docs.tabooproject.org/)。

## 环境

- JDK 8+（本模板 `jvmTarget = 1.8`）
- 服务端 API：当前为 Paper/Spigot **1.20.4**（`dependencies` 中的 `ink.ptms.core:v12004`），换版本需自行改 `compileOnly` 坐标

## 构建

```bash
./gradlew build
```

可分发插件 JAR 在 **`dist/`**（由 `tasks.jar` 指定输出目录，TabooLib 打包仍走 `jar` / `taboolibMainTask`）。编译中间文件在 `build/`，`dist/` 已加入 `.gitignore`，需自行拷贝到服务端 `plugins/`。

## 更新 TabooLib

在 `build.gradle.kts` 里改两处（版本号以 [TabooLib 发布](https://github.com/TabooLib/taboolib) / 文档为准）：

1. **TabooLib 本体**（运行时打进插件的框架版本）：

```kotlin
taboolib {
    version { taboolib = "6.3.0-a1d3953" }
}
```

2. **Gradle 插件** `io.izzel.taboolib`（负责下载模块、打包、重定向等）：

```kotlin
plugins {
    id("io.izzel.taboolib") version "2.0.31"
}
```

可在 [Gradle Plugin Portal](https://plugins.gradle.org/plugin/io.izzel.taboolib) 查最新插件版本。改完后执行 `./gradlew build`；若依赖拉取异常，可删本地 TabooLib 缓存目录后重试（常见为 `libraries` / Gradle 缓存，以插件文档为准）。

大版本升级请看官方 [版本升级](https://docs.tabooproject.org/category/%E7%89%88%E6%9C%AC%E5%8D%87%E7%BA%A7%EF%B8%8F)。

## 安装模块

模块**不会**自动全开，必须在 `build.gradle.kts` 里声明，否则对应 API 不可用。

1. 文件顶部增加导入（使用类型常量写法时必需）：

```kotlin
import io.izzel.taboolib.gradle.*
```

2. 在 `taboolib { env { ... } }` 里 `install`：

```kotlin
taboolib {
    env {
        install(Basic, Bukkit)
        install(BukkitUtil, BukkitUI, Kether)
        install(MinecraftChat, CommandHelper)
    }
    version { taboolib = "6.3.0-a1d3953" }
}
```

- **平台**：Bukkit 插件至少 `install(Basic, Bukkit)`（`Basic` 含配置、任务链等；`Bukkit` 为 Bukkit 平台入口）。
- **一次装多个**：`install(A, B, C)` 与多次 `install(...)` 等价，按可读性写即可。
- **依赖关系**：部分模块会连带子模块（例如 `BukkitUI` 会拉 NMS、聊天等），完整列表与说明见 [模块索引](https://docs.tabooproject.org/plugin/modules)。
- 配置细节（仓库地址、`forceDownloadInDev` 等）见 [v6.2 配置项目](https://docs.tabooproject.org/plugin/configuration/settings-6-2)。

本模板当前已安装的模块见 `build.gradle.kts` 中 `env { install(...) }` 段，可按需增删后重新构建。

## 项目标识

- 插件坐标：`gradle.properties` 的 `group`、`version`
- Gradle 工程名：`settings.gradle.kts` 的 `rootProject.name`
- 入口类：继承 `taboolib.common.platform.Plugin` 的 `object`（示例为 `ExamplePlugin.kt`）

## 参考

- [开发文档](https://docs.tabooproject.org/)
- [taboolib-gradle-plugin](https://github.com/TabooLib/taboolib-gradle-plugin)