# description: Adds a TelegramNotifier service for sending custom notifications to a Telegram chat
gem "telegram-bot-ruby"
run "bundle install"

files_dir = File.join(File.expand_path("..", __dir__), "files")

copy_file File.join(files_dir, "lib/telegram_notifier.rb"), "lib/telegram_notifier.rb"

say "\n=== Telegram Notifier ========================================"
say "Set the following environment variables (or Rails credentials):"
say "  TELEGRAM_BOT_TOKEN=your_bot_token"
say "  TELEGRAM_CHAT_ID=your_chat_id"
say ""
say "Usage:"
say "  TelegramNotifier.notify(\"New user signed up: \#{user.email}\")"
say "  TelegramNotifier.notify(\"<b>Payment received</b>\\n\$\#{amount}\")"
say ""
say "To create a bot, message @BotFather on Telegram."
say "To find your chat ID, message @userinfobot on Telegram."
say "=============================================================\n"
