return {
    cmd = { "rust-analyzer" },
    filetypes = { "rust" },
    root_dir = function(buf, callback)
        local root = vim.fs.root(buf, { "Cargo.toml" })

        if root then
            vim.system({ "cargo", "metadata", "--no-deps", "--format-version", "1" }, { cwd = root }, function(out)
                if out.code ~= 0 then
                    return callback(root)
                end

                local success, metadata = pcall(vim.json.decode, out.stdout)
                if success and metadata.workspace_root then
                    callback(metadata.workspace_root)
                else
                    callback(root)
                end
            end)
        else
            callback(nil)
        end
    end,
    settings = {
        autoformat = true
    }
}
