-------------- Original Author: Strawberry --------------
----------------- Discord: exec_noir --------------------
local function onCombatEvent(unitId, eventType, sourceName, targetName, abilityId, abilityName, damageType, effectType, isActive)
    -- 支持的事件类型
    local supportedEvents = {
        "SPELL_AURA_APPLIED",
        "SPELL_AURA_REMOVED",
        "SPELL_DAMAGE",
        "SPELL_HEAL"
    }

    -- 检查事件类型是否支持
    local isSupported = false
    for _, supportedEvent in ipairs(supportedEvents) do
        if eventType == supportedEvent then
            isSupported = true
            break
        end
    end

    if not isSupported then
        return
    end

    -- 获取战斗日志详情
    local combatLogDetails = GetCombatLogDetails(unitId, eventType, sourceName, targetName, abilityId, abilityName, damageType, effectType, isActive)
    
    -- 调试日志：输出接口返回值
    if combatLogDetails then
        local debugMessage = "DEBUG: GetCombatLogDetails returned: " .. tostring(combatLogDetails.message)
        if CombatLogAddon and CombatLogAddon.addLog then
            CombatLogAddon.addLog(debugMessage)
        end
    else
        if CombatLogAddon and CombatLogAddon.addLog then
            CombatLogAddon.addLog("DEBUG: GetCombatLogDetails returned nil")
        end
    end

    if not combatLogDetails then
        return
    end

    -- 生成日志消息
    local timestamp = os.date("[%H:%M:%S]")
    local message = timestamp .. " COMBAT_LOG: " .. combatLogDetails.message

    -- 传递日志到JavaScript界面
    if CombatLogAddon and CombatLogAddon.addLog then
        CombatLogAddon.addLog(message)
    end
end

-- 绑定战斗事件
UIParent:SetEventHandler(UIEVENT_TYPE.COMBAT_MSG, onCombatEvent)