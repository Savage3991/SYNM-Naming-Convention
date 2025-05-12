--------- Synapse Mac Naming Convention

local failed_funcs = {}
local passed = 0
local failed = 0
local missing = 0

local function func_exists(func) 
    if func == nil then
         warn(" ❌ | " .. func .. " does not exist")
        missing = missing + 1
        return false
    end
    
    return true
end

local function func_exists2(func) 
    if func == nil then
        return false
    end
    
    return true
end

print("")
print("-- Synapse Mac Naming Convention")
print("--------------------------------------------------")

task.spawn(function() 
    if (func_exists(getgenv)) then

        local test_1 = getgenv().getgenv

        if (test_1 == nil) then
            warn(" ❌ | getgenv is not working properly")
            failed = failed + 1
            return
        end

        getgenv().stopidcat = true
        stopidcat = false
        if (getgenv().stopidcat == false) then
            warn(" ❌ | getgenv is not working properly (2)")
            failed = failed + 1
            return
        end

        getgenv().stopidcat = nil -- CLEAN UP

        passed = passed + 1
        print(" ✅ | getgenv")

    end
end)

task.spawn(function() 
    if (func_exists(getrenv)) then

        local test_1 = getrenv()

        if (test_1.rawget == nil) then
            warn(" ❌ | getrenv is not working properly (1)")
            failed = failed + 1
            return
        end

        if(func_exists2(iscclosure)) then
            if (iscclosure(test_1.rawget) == false) then
                warn(" ❌ | getrenv is not working properly (1.5)")
                failed = failed + 1
                return
            end
        else
            warn(" ❌ | getrenv (missing iscclosure)")
            failed = failed + 1
            return
        end

        if (test_1._G == nil) then
            warn(" ❌ | getrenv is not working properly (2)")
            failed = failed + 1
            return
        end

        if (test_1.shared == nil) then
            warn(" ❌ | getrenv is not working properly (2)")
            failed = failed + 1
            return
        end

        if (_G ~= test_1._G) then
            warn(" ❌ | getrenv is not working properly (3)")
            failed = failed + 1
            return
        end

        if (shared ~= test_1.shared) then
            warn(" ❌ | getrenv is not working properly (3)")
            failed = failed + 1
            return
        end

        passed = passed + 1
        print(" ✅ | getrenv")

    end
end)

task.spawn(function() 
    if (func_exists(getthreadidentity) and func_exists(setthreadidentity)) then

        if(getthreadidentity() == 0) then
            warn(" ❌ | getthreadidentity is not working properly (0)")
            failed = failed + 1
            return
        end

        local test_1 = getthreadidentity()
        setthreadidentity(4)

        if (getthreadidentity() ~= 4 ) then
            warn(" ❌ | setthreadidentity is not working properly (1)")
            failed = failed + 1
            return
        end

        setthreadidentity(test_1)

        if (getthreadidentity() ~= test_1) then
            warn(" ❌ | setthreadidentity is not working properly (2)")
            failed = failed + 1
            return
        end
        
        local success, response = pcall(function()
            setthreadidentity(2)
            local a = game:GetService("CoreGui")
            local b= a:FindFirstChild("RobloxGui")
        end)

        if (success == true) then
            warn(" ❌ | setthreadidentity is not working properly (3)")
            failed = failed + 1
            return
        end

        passed = passed + 2
        print(" ✅ | getthreadidentity")
        print(" ✅ | setthreadidentity")

    end
end)

print("--------------------------------------------------")

task.spawn(function()
    print(" ✅ | SMNC: " .. passed / 4 * 100 .. "%")
    print(" ❌ | Failed: " .. failed)
    print(" ❓ | Missing: " .. missing)
    print("--------------------------------------------------")
end)
