def debug(*data)
  puts "\n\n"
  puts '#' * 100
  data.each do |item|
    p item
    puts '#' * 100
  end
  puts "\n\n"
end
