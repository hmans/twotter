module SeedData
  module_function

  def generate_basic_users
    puts "* Generating basic users"

    hmans = User.create!(name: 'hmans', full_name: 'Hendrik Mans',
      email: 'hendrik@mans.de', password: 'secret')

    alice = User.create!(name: 'alice', full_name: 'Alice',
      email: 'alice@test.com', password: 'secret')

    hmans.posts.create!(body: 'Hello Twotter!')
    alice.posts.create!(body: "Hi, I'm Alice!")

    hmans.followed_users << alice
  end

  def generate_bulk_data(users: 100)
    puts "* Generating #{users} random users with posts"

    FactoryBot.create_list(:user, users) do |u|
      FactoryBot.create_list :post, rand(0..20),
        user: u,
        created_at: rand(0.seconds..7.days).ago
    end
  end
end
