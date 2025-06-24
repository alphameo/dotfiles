local M = {}

local function fail(s, ...)
    error(string.format(s, ...))
end

function M:entry(job)
    ya.hide()

    local args = { "--" }
    -- Yazi plugins only support long options at present
    for k, v in pairs(job.args or {}) do
        if type(k) == "string" then
            if v and v ~= "" then
                table.insert(args, 1, v)
            end

            table.insert(args, 1, "--" .. k)
        end
    end

    local child, err_run =
        Command("cdhist"):args(args):stdin(Command.INHERIT):stdout(Command.PIPED):stderr(Command.PIPED):spawn()

    if not child or err_run then
        return fail("Failed to start `cdhist`, error: " .. err_run)
    end

    local output, err_out = child:wait_with_output()
    if err_out then
        return fail("Cannot read `cdhist` output, error: " .. err_out)
    end

    if output.stderr ~= "" then
        return fail("Error from `cdhist`:" .. output.stderr)
    end

    local dir = output.stdout:gsub("\n$", "")
    if dir ~= "" then
        ya.manager_emit("cd", { dir })
    end
end

return M
-- vim: sw=4:ts=4:sts=4:et
