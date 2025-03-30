# Africa Ruby Community (ARC) Platform

[![Arc Platform CI Workflow](https://github.com/nairuby/arc_platform/actions/workflows/ci.yml/badge.svg)](https://github.com/nairuby/arc_platform/actions/workflows/ci.yml)
![Ruby](https://img.shields.io/badge/Ruby-3.4.1-red?logo=ruby)
![Rails](https://img.shields.io/badge/Rails-7.2.2-blue?logo=rubyonrails)

## Introduction
The Africa Ruby Community (ARC) Platform is a project aimed at creating a hub for Ruby language enthusiasts in Africa. This platform facilitates connection, knowledge sharing, collaboration on projects, and staying updated with the latest Ruby community developments. Whether you're a seasoned developer or a beginner, this platform offers tailored resources for different countries and cities, merchandise, meetup information, and details about online workshops and webinars.

- **Project Design:** [ARC Platform Design](https://still-snowflake-8822.animaapp.io/)
- **Database Design:** [ARC Database Design](https://dbdiagram.io/d/62afab7c9921fe2a96397c1e)

*Note: This project is open source, and contributions are encouraged.*

## Application Setup
- To follow along, watch this youtube tutorial on how to set up the application step by step on WSL.

[![Application Setup](https://img.youtube.com/vi/-mz76HidnGA/0.jpg)](https://www.youtube.com/watch?v=-mz76HidnGA)

- [Old README](./README.md): `rvm` and `rvenv` users

## Step 1: Install Prerequisites

### Installing ASDF


[ASDF](https://asdf-vm.com/) is a tool capable of managing all runtimes locally. Follow the instructions for installation, especially for Windows WSL users.

Install dependencies for compiling Ruby:

* macOS: Install Homebrew

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

* Ubuntu/ Windows WSL

```sh
sudo apt-get update
sudo apt-get install git-core zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev
```

2. Installing ASDF version manager

```sh
cd
git clone https://github.com/excid3/asdf.git ~/.asdf
echo '. "$HOME/.asdf/asdf.sh"' >> ~/.zshrc
echo '. "$HOME/.asdf/completions/asdf.bash"' >> ~/.zshrc
echo 'legacy_version_file = yes' >> ~/.asdfrc
exec $SHELL
```

#### Installing Ruby via ASDF
Install ASDF plugins.

```sh
asdf plugin add ruby
asdf plugin add nodejs
```

Install Ruby and set the default version by running the following commands:

```sh
asdf install ruby 3.4.1 

# Set the default Ruby version
asdf global ruby 3.4.1 

# Update to the latest Rubygems version
gem update --system
```

Install foreman gem

```shell
gem install foreman
```

Confirm the default Ruby version matches the version you just installed.

```sh
which ruby
#=> /Users/username/.asdf/shims/ruby
ruby -v
#=> 3.4.1
```

Install Node.js for handling Javascript in our Rails app

```sh
asdf install nodejs 20.9.0
asdf global nodejs 20.9.0

which node
#=> /Users/username/.asdf/shims/node
node -v
#=> 20.9.0

# Install yarn for Rails jsbundling/cssbundling or webpacker
npm install -g yarn
```

To switch to a different Ruby and Node version for a specific project, you can use the following command to set the Ruby or Node version for that project. You should be in the project directory.

```sh
asdf local ruby <ruby version>  # eg 3.4.1
asdf local nodejs <nodejs version> # eg 20.9.0
```

### Step 2: Create a Fork & Branch

1. Create a fork of this repository from the main branch.
2. Select an issue to work on from the main repository.
3. Create a branch named after the selected issue from the main branch.

*Note: Keep your fork in sync with the main repository, and make all changes on this branch.*

### Step 3: Clone & Install Dependencies

```sh
$ git clone <link to your forked repo>
$ cd <path to your cloned repo>
$ bundle install
```

### Step 4: Setup the Database

```sh
$ rails db:create
$ rails db:migrate
```

### Step 4: Install Yarn Dependencies

```sh
$ yarn install
```

### Step 5: Start Server

```sh
$ ./bin/dev
```

### Step 6: Creating a Pull Request

1. Make changes locally on your branch.
2. Push your changes to your branch on GitHub.
3. Create a pull request to the main branch of the main repository.

### Step 7: Merging

Once your changes are reviewed, they will be merged into the main branch.

## Contributing

Thank you for considering contributing to the Africa Ruby Community (ARC) Platform! We welcome contributions from developers of all experience levels.

### Finding Issues to Work On

We label our issues to help contributors find ones that match their skills and experience level. Here are some labels you might find helpful:

| Difficulty Level | Description | Label |
| ----------------- | ----------- | ----- |
| Easy/ Beginner/ Novice | Issues for first-time contributors | ![DifficultyLevelEasy](https://img.shields.io/badge/DifficultyLevelEasy-green.svg?style=for-the-badge) |
| Very Easy | Simple issues for quick fixes | ![DifficultyLevelVeryEasy](https://img.shields.io/badge/DifficultyLevelVeryEasy-619B16?style=for-the-badge) |
| Average/ Normal/ Medium/ Standard/ Intermediate | Issues requiring understanding of the codebase | ![DifficultyLevelAverage](https://img.shields.io/badge/DifficultyLevelAverage-DAD22C?style=for-the-badge&color=fbca04) |
| Hard/ Expert/ Difficult | Issues needing significant time and effort | ![DifficultyLevelHard](https://img.shields.io/badge/DifficultyLevelHard-E1803C?style=for-the-badge&color=d93f0b) |
| Harder | Very challenging issues requiring advanced knowledge | ![DifficultyLevelHarder](https://img.shields.io/badge/DifficultyLevelHarder-C70039?style=for-the-badge) |

To find issues:

1. Go to the project's repository on GitHub.
2. Click on the `Issues` tab.
3. Use the search bar to filter by labels and keywords.
4. Read issue descriptions and comments for details.
5. Leave a comment if you have questions or need help.

Happy contributing!
