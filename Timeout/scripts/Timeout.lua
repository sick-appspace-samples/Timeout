--[[----------------------------------------------------------------------------

  Application Name:
  Timeout
           
  Summary:
  Introduction to time based and distance based (conveyor) timeouts
                                                                                  
  Description:
  This sample is setting up two types of timeout options, time based and
  distance based. The conveyor timeout is set to occur when the conveyor reaches
  a relative increment change of 1000. In this sample it is done by manually setting
  that increment. The timer timeout is configured to occur when the timer expires
  after 5000ms. Each timeout calls the respective handler function and the according
  message is printed to the console.
  
  How to run:
  The sample can be run on the emulator. The timeout messages are printed to the
  console.
------------------------------------------------------------------------------]]
--Start of Global Scope---------------------------------------------------------

-- Manually set the current increment to 1
Conveyor.setCurrentIncrement(1)

-- Creating a conveyor timeout handle
local conveyor = Conveyor.Timeout.create()

-- Creating a timer and setting its timeout to 5 seconds
local tmr = Timer.create()
Timer.setExpirationTime(tmr, 5000)

--End of Global Scope-----------------------------------------------------------

--Start of Function and Event Scope---------------------------------------------

-- Handler function of the timer Timeout event
local function handleTimerTimeout()
  print('Timer timeout occurred')
end
--Registration of the 'handleTimerTimeout' function to the timers 'OnExpired' event
Timer.register(tmr, 'OnExpired', handleTimerTimeout)

-- Handler function is called when the conveyor timeout expires
local function handleConveyorTimeout()
  print('Conveyor timeout occurred')
end
--Registration of the 'handleConveyorTimeout' function to the conveyor 'OnExpired' event
Conveyor.Timeout.register(conveyor, 'OnExpired', handleConveyorTimeout)

-- The timer and conveyor count are started after the "Engine.OnStarted" event occurred
-- this prevents that the timeout events happen, before the device is ready.
local function main()
  Conveyor.Timeout.startCount(conveyor, 1000)
  -- Make the increment change by +1000 manually; this should trigger the handler function
  Conveyor.setCurrentIncrement(1001)
  Timer.start(tmr)
end
--The following registration is part of the global scope which runs once after startup
--Registration of the 'main' function to the 'Engine.OnStarted' event
Script.register('Engine.OnStarted', main)

--End of Function and Event Scope------------------------------------------------
