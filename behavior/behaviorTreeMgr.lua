-----------------------------------------------------------------------------------------------------
-- 行为树 节点基础类
------------------------------------------------------------------------------------------------------
local _G            = _G
local os            = os
local xml           = xml
local next          = next
local type          = type
local table         = table
local print         = print
local error         = error
local pairs         = pairs
local assert        = assert
local ipairs        = ipairs
local rawget        = rawget
local getfenv       = getfenv
local tostring      = tostring
local setmetatable  = setmetatable
local getmetatable  = getmetatable
------------------------------------------------------------------------------------------------------
local d_ms = require "ms"
------------------------------------------------------------------------------------------------------
local EBTStatus             = d_ms.d_behaviorCommon.EBTStatus
local triggerMode           = d_ms.d_behaviorCommon.triggerMode
local BehaviorParseFactory  = d_ms.d_behaviorCommon.BehaviorParseFactory
------------------------------------------------------------------------------------------------------
module "behavior.behaviorTreeMgr"
------------------------------------------------------------------------------------------------------
local behaviorTrees = {}
function loadBehaviorTree(path)
    return tree
end

function destroyBehaviorTreeTask(behaviorTreeTask, obj)

end

function createBehaviorTreeTask(path)
        
end
------------------------------------------------------------------------------------------------------
local constPreloadBehaviors = true
function preloadBehaviors()
    return constPreloadBehaviors
end

local constUseIntValue = true
function getUseIntValue()
    return constUseIntValue
end
------------------------------------------------------------------------------------------------------
