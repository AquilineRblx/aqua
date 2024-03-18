--[[
    This file is part of Aqua, a collection of libraries for Roblox game development.
    Copyright (c) 2024 Aquiline Studios, MIT License

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.
]]

--// Imports
local Types = require(script.Parent.Types)

--// Class and functions
local Class = {}

--// Constructor
Class.new = function(items: Types.EnumItems)
    --// create a new table representing the class
    local enum: Types.EnumItems = {}

    --// copy over the values
    for name, ordinal in pairs(items) do 
        enum[name] = ordinal
    end
    
    --// return the table wrapped into this class
    return setmetatable(enum, { 
        __index = Class,
        __newindex = function(table, index, value)
            error("Enumeration tables are immutable")
        end
    })
end

--// Methods
function Class:values(): { [number]: Types.EnumItem }
    local items: { [number]: Types.EnumItem } = {}

    for name, ordinal in pairs(self) do 
        items[#items + 1] = { Name = name, Ordinal = ordinal }
    end

    return items
end

--// Exports
return Class