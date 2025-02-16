local MyModule = loadstring([[
    local module = {}

    module.value = 100

    function module.sayHello()
        print("Xin chào từ MyModule!")
    end

    return module
]])() -- Chạy loadstring để tạo module

-- Gọi hàm từ module
MyModule.sayHello() -- In ra: "Xin chào từ MyModule!"
print(MyModule.value) -- In ra: 100
