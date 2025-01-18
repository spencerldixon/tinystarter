gem "mission_control-jobs"

route <<-eos
  authenticate :user, ->(user) { user.admin? } do
    mount MissionControl::Jobs::Engine, at: \"/jobs\"
  end
eos
