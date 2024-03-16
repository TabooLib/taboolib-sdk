package ${group}

import taboolib.common.platform.Plugin
import taboolib.common.platform.function.info

object ${name} : Plugin() {

    override fun onEnable() {
        info("Successfully running ${name}!")
    }
}