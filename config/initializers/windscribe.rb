# def syscall(*cmd)
#   begin
#     stdout, stderr, status = Open3.capture3(*cmd)
#     status.success? && stdout.slice!(0..-(1 + $/.size)) # strip trailing eol
#   rescue
#   end
# end

def get_public_ip()
  `curl --max-time 1 http://ipecho.net/plain`
end

def is_windscribe_running()
  log_output = `ps aux | grep -v grep | grep -c -i windscribe`.to_i
  log_output > 1
end

def reset_windscribe(max_attempts=15)
  puts "Resetting Windscribe [Beg]."

  open_command = "open -a Windscribe"
  quit_command = %w(
    osascript -e 'quit app "Windscribe"'
  ).join(" ")

  quit_attempts = 0

  while is_windscribe_running()
    system quit_command
    sleep 2

    quit_attempts += 1
    raise 'hell' if quit_attempts > max_attempts
  end

  init_ip = get_public_ip()
  new_ip = init_ip

  open_attempts = 0

  while new_ip == init_ip
    system open_command
    sleep 2

    open_attempts += 1
    raise 'hell' if open_attempts > max_attempts

    tmp_ip = get_public_ip()
    new_ip = tmp_ip unless tmp_ip.blank?
  end

  sleep 2
  puts "Resetting Windscribe [End]."
end
