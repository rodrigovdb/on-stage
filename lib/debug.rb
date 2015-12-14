def debug(data)
  data = [data] unless data.is_a?(Array)

  puts "\n\n"
  puts '#' * 100
  data.each do |item|
    p item
    puts '#' * 100
  end
  puts "\n\n"
end
