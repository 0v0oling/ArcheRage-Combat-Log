// 全局对象，用于与Lua脚本交互
window.CombatLogAddon = {
    addLog: function(message) {
        const logContent = document.getElementById('log-content');
        const logEntry = document.createElement('div');
        logEntry.textContent = message;
        logContent.appendChild(logEntry);
        logContent.scrollTop = logContent.scrollHeight;
    }
};

// 战斗日志数据
let combatLog = [];

// 添加日志到界面
function addToCombatLog(event) {
    console.log("收到战斗日志:", event); // 调试日志
    combatLog.push(event);
    const logContent = document.getElementById('log-content');
    const logEntry = document.createElement('div');
    logEntry.textContent = event;
    logContent.appendChild(logEntry);
    logContent.scrollTop = logContent.scrollHeight;
}

// 保存日志到本地文件
function saveCombatLog() {
    const blob = new Blob([combatLog.join('\n')], { type: 'text/plain' });
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = `combat-log-${new Date().toISOString().replace(/[:.]/g, '-')}.txt`;
    a.click();
    URL.revokeObjectURL(url);
}

// 初始化
document.addEventListener('DOMContentLoaded', () => {
    // 绑定保存按钮事件
    document.getElementById('save-log').addEventListener('click', saveCombatLog);
});