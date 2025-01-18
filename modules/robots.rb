append_to_file 'public/robots.txt' do
  <<-eos
User-agent: GPTBot
Disallow: /
  eos
end
