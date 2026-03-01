# description: Forwards unhandled exceptions to a Telegram chat for real-time error alerts
gem "telegram-bot-ruby"
run "bundle install"

files_dir = File.join(File.expand_path("..", __dir__), "files")

copy_file File.join(files_dir, "lib/telegram_error_subscriber.rb"), "lib/telegram_error_subscriber.rb"
copy_file File.join(files_dir, "config/initializers/telegram_error_subscriber.rb"), "config/initializers/telegram_error_subscriber.rb"

say "\n=== Telegram Error Subscriber ================================"
say "Set the following environment variables (or Rails credentials):"
say "  TELEGRAM_BOT_TOKEN=your_bot_token"
say "  TELEGRAM_CHAT_ID=your_chat_id"
say ""
say "To create a bot, message @BotFather on Telegram."
say "To find your chat ID, message @userinfobot on Telegram."
say "=============================================================\n"
