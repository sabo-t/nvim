st = {}
st.colorschemes = {'nord', 'kanagawa-wave', 'kanagawa-lotus', 'kanagawa-dragon', 'kanagawa'}
st.colorscheme = nil
st.path_config = v.nvim_exec2("echo stdpath('config')", {output = true})["output"]
st.dir_state = st.path_config .. '/state'
st.file_current_colorscheme = st.dir_state .. '/current_colorscheme'
return st
