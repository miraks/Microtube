Factory.define(:user) do |f|
  f.login { rand(100).to_s * 5 }
  f.password 'password'
  f.password_confirmation 'password'
end
