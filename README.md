# rideside.net

Social Media

Visit us at https://rideside.net

## System Dependencies

Ruby and it's Bundler. Convenient to use `rvm` to install Ruby 3.2.3

Mariadb is also needed, run directly or through Docker.

## Getting Started

Clone this repository. Make a `.env` file. Install gems and run.

The `.env` file will need the following entries:

```
DATABASE_URL=<add_db_connection_string>
TUMBLR_CONSUMER_KEY=<add_tumblr_consumer_key>
TUMBLR_CONSUMER_SECRET=<add_tumblr_consumer_secret>
```

The database will need to be created from a backup script.

Use `make setup` to configure a Python3 virtual environment to run `pre-commit` in.


```
cd rideside.net # local repository
make setup
source _venv/bin/activate
nano .env
bundle install
bundle exec foreman run puma
```

Application should be running at http://localhost:4567

## Docker does it

```
cd rideside.net # local repository
docker compose build
docker compose up -d
```

## Deploy

Install ansible.

Create an inventory file. A sample is at [here](./deploy/ansible/inventory.sample).

```
cd rideside.net # local repository
cd deploy
make deploy ANSIBLE_INVENTORY=/path/to/inventory/file
```
