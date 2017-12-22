------------------------------------------------------------------------------------------------------
-- 行为树 动作节点
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
local string        = string
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
local EBTStatus              = d_ms.d_behaviorCommon.EBTStatus
local BehaviorParseFactory   = d_ms.d_behaviorCommon.BehaviorParseFactory
local constInvalidChildIndex = d_ms.d_behaviorCommon.constInvalidChildIndex
------------------------------------------------------------------------------------------------------
module "behavior.node.actions.noopTask"
------------------------------------------------------------------------------------------------------
class("cCompositeStochasticTask", d_ms.d_compositeTask.cCompositeTask)
ADD_BEHAVIAC_DYNAMIC_TYPE("cCompositeStochasticTask", cCompositeStochasticTask)
BEHAVIAC_DECLARE_DYNAMIC_TYPE("cCompositeStochasticTask", "cCompositeTask")
------------------------------------------------------------------------------------------------------
function cCompositeStochasticTask:__init()
    self.m_set = {}
end

function cCompositeStochasticTask:copyTo(target)
    d_ms.d_compositeTask.cCompositeTask.copyTo(self, target)

    BEHAVIAC_ASSERT(target:isCompositeStochasticTask(), "target:isCompositeStochasticTask")
    target.m_set = table.copy(self.m_set)
end

function cCompositeStochasticTask:onEnter(obj)
    BEHAVIAC_ASSERT(#self.m_children > 0, "cCompositeStochasticTask:onEnter #self.m_children > 0")

    self:randomChild(obj)
    self.m_activeChildIndex = 1
    return true
end

function cCompositeStochasticTask:onExit(obj, status)
end

function cCompositeStochasticTask:update(obj, childStatus)
    local bFirst = true
    BEHAVIAC_ASSERT(self.m_activeChildIndex ~= constInvalidChildIndex, "cCompositeStochasticTask:update self.m_activeChildIndex ~= constInvalidChildIndex")

    while true do
        local s = childStatus

        if not bFirst or s == EBTStatus.BT_RUNNING then
            local childIndex = self.m_set[self.m_activeChildIndex]
            local pBehavior  = self.m_children[childIndex]
            s = pBehavior:exec(obj)
        end

        bFirst = false
        -- If the child succeeds, or keeps running, do the same.
        if s ~= EBTStatus.BT_FAILURE then
            return s
        end
        -- Hit the end of the array, job done!
        self.m_activeChildIndex = self.m_activeChildIndex + 1

        if self.m_activeChildIndex > #self.m_children then
            return EBTStatus.BT_FAILURE
        end
    end
end

function cCompositeStochasticTask:onExit(obj, status)
end