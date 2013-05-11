Rails.application.config.middleware.use OmniAuth::Builder do
  #provider :twitter, 'jKWWWSbLuinTIX813trzIw', 'ehUwtaOPdR2864e41OHMvKgFvP0VqJz5CQOs3g4rlQw'
  provider  :facebook, '492668117455191' , '4ee4b8b200f79f3572f78e7dfac75523'
end