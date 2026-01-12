# frozen_string_literal: true
server "56.155.70.195",
  user: "ec2-user",
  roles: %w{web db app},
  ssh_options: {
    user: "ec2-user", # overrides user setting above
    keys: %w(/home/moaoy/.ssh/dic_sample_01.pem),
    forward_agent: false,
    auth_methods: %w(publickey password)
    # password: "please use keys"
  }
  set :default_env, { 'TOTTOKU_DATABASE_PASSWORD' => 'MoQCuBqhqePck/FD+glL8Q==' }