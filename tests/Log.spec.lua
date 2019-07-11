return function()
	local FDK = require(script.Parent.Parent.src.FDK)

	FDK:wrapEnvironment(getfenv())

	local Log = import("org.log4lua.Log")

	local Test = BaseClass:new("Test")

	local config, ClassLog = {
		["Debug"] = true,

		["FunctionCalls"] = {
			["Debug"] = function() return 1 end,
			["Info"] = function() return 2 end,
			["Warn"] = function() return 3 end,
			["Error"] = function() return 4 end
		}
	}, nil

	--print(ClassLog:atDebug())

	describe("Log", function()
		it("should be ok", function()
			expect(Log).to.be.ok()
		end)

		it("should use the log correctly", function()
			expect(function()
				Log(config)
			end).never.to.throw()
		end)

		it("should create the handler properly", function()
			expect(function()
				ClassLog = Log:getLogger(Test)
			end).never.to.throw()

			expect(ClassLog).to.be.ok()
		end)

		describe("ClassLog", function()
			describe("Debug", function()
				it("atDebug should log", function()
					expect(ClassLog:atDebug()
						:log("asd")).to.equal(1)
				end)

				it("atDebug should log with arguments", function()
					expect(ClassLog:atDebug()
						:addArgument("asd")
						:log("{} {}")).to.equal(1)
				end)

				it("debug should log", function()
					expect(ClassLog:debug("t")).to.equal(1)
				end)

				it("debug should log with arguments", function()
					expect(ClassLog:debug("t {} {}", 't')).to.equal(1)
				end)
			end)

			describe("Info", function()
				it("atInfo should log", function()
					expect(ClassLog:atInfo()
						:log("asd")).to.equal(2)
				end)

				it("atInfo should log with arguments", function()
					expect(ClassLog:atInfo()
						:addArgument("asd")
						:log("{} {}")).to.equal(2)
				end)

				it("info should log", function()
					expect(ClassLog:info("t")).to.equal(2)
				end)

				it("info should log with arguments", function()
					expect(ClassLog:info("t {} {}", 't')).to.equal(2)
				end)
			end)

			describe("Warn", function()
				it("atWarn should log", function()
					expect(ClassLog:atWarn()
						:log("asd")).to.equal(3)
				end)

				it("atWarn should log with arguments", function()
					expect(ClassLog:atWarn()
						:addArgument("t")
						:log("{} {}")).to.equal(3)
				end)

				it("warn should log", function()
					expect(ClassLog:warn("t")).to.equal(3)
				end)

				it("warn should log with arguments", function()
					expect(ClassLog:warn("t {} {}", 't')).to.equal(3)
				end)
			end)

			describe("Error", function()
				it("atError should log", function()
					expect(ClassLog:atError()
						:log("asd")).to.equal(4)
				end)

				it("atError should log with arguments", function()
					expect(ClassLog:atError()
						:addArgument("asd")
						:log("{} {}")).to.equal(4)
				end)

				it("error should log", function()
					expect(ClassLog:error("t")).to.equal(4)
				end)

				it("error should log with arguments", function()
					expect(ClassLog:error("t {} {}", 't')).to.equal(4)
				end)
			end)
		end)
	end)
end