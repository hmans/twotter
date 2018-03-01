module SeedData
  module_function

  def generate_basic_users
    hmans = User.create!(name: 'hmans', full_name: 'Hendrik Mans',
      email: 'hendrik@mans.de', password: 'secret')

    alice = User.create!(name: 'alice', full_name: 'Alice',
      email: 'alice@test.com', password: 'secret')

    hmans.posts.create!(body: 'Hello Twotter!')
    alice.posts.create!(body: "Hi, I'm Alice!")

    hmans.followed_users << alice
  end
end
