-- requires: "GitProfile" to be set as an environment variable
function GetGitProfile()
  return os.getenv("GitProfile")
end

vim.api.nvim_create_user_command(
  'Gitprofile',
  function()
    vim.api.nvim_put({ GetGitProfile() }, 'c', true, true)
  end,
  { nargs = 0 }
)
