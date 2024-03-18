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

--// Java streams style wrapper around tables
local Streams = {}
Streams.__index = Streams

--- Creates a new 'Stream' class from an array.
--- @param array The array to create the stream from
--- @return The newly created Stream
Streams.of = function(array: { any }?)
	local Stream = {}
	setmetatable(Stream, Streams)

	Stream.array = array

	return Stream
end

--- Returns a stream consisting of the elements of this stream that match the given predicate.
--- @param predicate The predicate to match for
--- @return The filtered Stream
function Streams:filter(predicate: (value: any) -> boolean)
	local filtered = {}
	for _, value in ipairs(self.array) do
		if predicate(value) then
			table.insert(filtered, value)
		end
	end

	self.array = filtered
	return self
end

--- Returns a stream consisting of the results of applying the given function to the elements of this stream.
--- @param mapper The mapper function to apply to the elements
--- @return The mapped Stream
function Streams:map(mapper: (value: any) -> any)
	local mapped = {}
	for _, value in ipairs(self.array) do
		table.insert(mapped, mapper(value))
	end

	self.array = mapped
	return self
end

--- Performs an action for each element of this stream.
--- @param action The action to preform on the element
function Streams:forEach(action: (value: any) -> ())
	for _, value in ipairs(self.array) do
		action(value)
	end
end

function Streams:iter(action: (index: number, value: any) -> ())
	for index, value in pairs(self.array) do
		action(index, value)
	end
end

--- Returns the first element in the array, if present.
--- @return The first element in the array, or nil if not found.
function Streams:findFirst(): any | nil
	if #self.array > 0 then
		return self.array[1]
	end
	return nil
end

--- Returns a stream consisting of the elements of this stream that match the given predicate.
--- @param predicate The predicate to match for with the index of the value filtered
--- @return The filtered Stream
function Streams:filterIterable(predicate: (index: number, value: any) -> boolean)
	local filtered = {}
	for index, value in ipairs(self.array) do
		if predicate(index, value) then
			table.insert(filtered, value)
		end
	end

	self.array = filtered
	return self
end

return Streams