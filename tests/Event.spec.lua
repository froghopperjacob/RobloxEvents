return function()
	local FDK = require(script.Parent.Parent.src.FDK)

	FDK:wrapEnvironment(getfenv())

	local EventClass = import("org.robloxevents.Event")
	local event = nil

	describe("Event", function()
		it("should be ok", function()
			expect(EventClass).to.be.ok()
		end)

		it("should create a Event correctly", function()
			expect(function()
				event = EventClass(true)
			end).never.to.throw()
		end)

		it("should connect with no errors", function()
			expect(function()
				event:connect(function()

				end)
			end).never.to.throw()
		end)

		it("should wait with errors", function()
			expect(function()
				event:wait()
			end).to.throw()
		end)

		it("should fire with no errors", function()
			expect(function()
				event:fire()
			end).never.to.throw()
		end)

		describe("Connection", function()
			local connection

			it("should create a connection properly", function()
				expect(function()
					connection = event:connect(function()

					end)
				end).never.to.throw()

				expect(connection).to.be.ok()
			end)

			it("should disconnect properly", function()
				expect(function()
					connection:disconnect()
				end).never.to.throw()
			end)
		end)

		it("should disconnect all correctly", function()
			expect(function()
				event:disconnectAll()
			end).never.to.throw()
		end)

		it("should destroy correctly", function()
			expect(function()
				event:destroy()
			end).never.to.throw()
		end)
	end)
end