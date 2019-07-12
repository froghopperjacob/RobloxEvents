<h1 align="center">Roblox Events</h1>
<div align="center">
	<a href="https://github.com/froghopperjacob/RobloxEvents/tree/master/LICENSE">
		<img src="https://img.shields.io/badge/License-Apache%202.0-brightgreen.svg?style=flat-square" alt="Lisence" />
	</a>
	<a href="https://travis-ci.com/froghopperjacob/RobloxEvents">
		<img src="https://img.shields.io/travis/com/froghopperjacob/RobloxEvents.svg?style=flat-square" alt="Travis" />
	</a>
	<a href="https://coveralls.io/github/froghopperjacob/RobloxEvents?branch=master">
		<img src="https://img.shields.io/coveralls/github/froghopperjacob/RobloxEvents.svg?style=flat-square" alt="Coveralls" />
	</a>
</div>

<div align="center">
	Roblox Events is a small event system built on <a href ="https://github.com/TheFlamingBlaster/FDK">FDK</a> like RBXScriptSignal
</div>
<div>&nbsp;</div>

## Index

1. [Setup](#Setup)
2. [Usage](#Usage)
3. [Examples](#Examples)

## Setup
1. Install [FDK](https://github.com/TheFlamingBlaster/FDK).
2. Install Roblox Events through FDK's plugin OR the [releases](https://github.com/froghopperjacob/RobloxEvents/releases).

## Usage
Importing RobloxEvents:
```lua
local RobloxEvent = import("org.RobloxEvents.Event")
```

After importing it you need to provide can create a Event like:
```lua
local event = RobloxEvent() -- optional argument boolean debug
```

Connecting a function:
```lua
local connection = event:connect(function()
	print('fired')
end)
```

Yielding the current thread until the event is called:
```lua
event:wait() -- THIS HAS NOT BEEN IMPLMENTED
```

Disconnecting all connections:
```lua
event:disconnectAll()
```

Disconnecting a current connection:
```lua
connection:disconnect()
```

Destroying a unused event:
```lua
event:destroy()
```

## Examples

Example 1:
```lua
return function()
	local Event = import("org.robloxevents.Event")
	local set, get = Event(), Event() -- All databases get/sets

	local Database = BaseClass:new("Database")

	Database.Database = function(self, name)
		self.name = name
		self.data = { }

		self.get = Event() -- This databases get/sets
		self.set = Event()

		self.getEvent = self.get
		self.setEvent = self.set

		return self
	end

	Database.get = function(self, key, default)
		self.get:fire(key, default)
		get:fire(self.name, key, default)

		return self.data[key] or default
	end

	Database.set = function(self, key, value)
		self.set:fire(key, value)
		set:fire(self.name, key, value)

		self.data[key] = value

		return true
	end

	Database.allDataGetEvent = get
	Database.allDataSetEvent = set

	return Database
end
```
