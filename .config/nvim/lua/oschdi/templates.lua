local template_dir = vim.fn.expand("~/.config/nvim/templates")

vim.api.nvim_create_augroup("templates", { clear = true })

-- ------------------------ HPP ------------------------------

local function replace_placeholder(buf, placeholder, replacement)
    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    for i, line in ipairs(lines) do
        lines[i] = line:gsub(placeholder, replacement)
    end
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
end

local function to_screaming_snake(name)
    local snake = name:gsub("(%l)(%u)", "%1_%2")
    return snake:upper()
end

vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
    group = "templates",
    pattern = "*.hpp",
    callback = function(args)
        local buf = args.buf
        if vim.api.nvim_buf_line_count(buf) > 1 then 
            return
        end

        vim.cmd("0r " .. template_dir .. "/hpp.hpp")

        local basename  = vim.fn.expand("%:t:r")

        local replacements = {
            ["{{BASENAME}}"] = basename,
            ["{{INCLUDE_GUARD}}"] = to_screaming_snake(basename)
        }

        for k, v in pairs(replacements) do
            replace_placeholder(buf, k, v)
        end
  end,
})

-- ------------------------ CPP ------------------------------

local function find_header_for_cpp(basename, dir)
    local handle = vim.loop.fs_scandir(dir)
    if not handle then return nil end

    while true do
        local name, type = vim.loop.fs_scandir_next(handle)
        if not name then break end
        local path = dir .. "/" .. name
        if type == "file" then
            if name == basename .. ".hpp" or name == basename .. ".h" then
                return path
            end
        elseif type == "directory" then
            local res = find_header_for_cpp(basename, path)
            if res then return res end
        end
    end
    return nil
end

vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
    group = "templates",
    pattern = "*.cpp",
    callback = function(args)
        local buf = args.buf
        if vim.api.nvim_buf_line_count(buf) > 1 then 
            return
        end

        vim.cmd("0r " .. template_dir .. "/cpp.cpp")

        local include_path = ""
        local cpp_file = vim.fn.expand("%:p")
        local basename = vim.fn.fnamemodify(cpp_file, ":t:r")
        local header = find_header_for_cpp(basename, "include")
        if header then
            include_path = header
        end

        local replacements = {
            ["{{INCLUDE_PATH}}"] = include_path,
        }

        for k, v in pairs(replacements) do
            replace_placeholder(buf, k, v)
        end
    end,
})
