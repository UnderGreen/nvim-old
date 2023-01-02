local status_ok, tmux_navigation = pcall(require, "nvim-tmux-navigation")
if not status_ok then
  return
end

tmux_navigation.setup = {
  disable_when_zoomed = false, -- defaults to false
}
