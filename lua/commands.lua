v.nvim_create_user_command('Reload', 'silent! !setsid -f ' .. st.path_config .. '/scripts/reload_nvim.sh', {})
