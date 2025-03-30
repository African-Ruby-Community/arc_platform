# Africa Ruby Community(ARC) Platform

## Introduction
The project aims to build a platform for African Ruby language enthusiasts to connect, share their knowledge and experience, collaborate on projects, and stay up-to-date with the latest developments in the Ruby community, whether they are seasoned developers or beginners just starting out. The platform features a variety of resources, including different chapters for different countries and cities, merchandise, and meetup information. It will also help users get information on online workshops, webinars, and meetups organized by the community, enabling them to learn from experts and network with other enthusiasts.

**Project Design:** https://still-snowflake-8822.animaapp.io/

**Database Design:** https://dbdiagram.io/d/62afab7c9921fe2a96397c1e

**N.B.** Please note that this project is open source, you are therefore encourage to contribute

## Application Setup

### Step 1: Install prerequisites
## Installing Ruby Version Manager(RVM) package
* RVM is a command-line tool that allows you to easily install, manage, and work with multiple Ruby environments, including interpreters and sets of gems. It supports both UNIX-like systems and Windows (with [Cygwin](https://cygwin.com) or [Bash on Ubuntu on Windows](https://msdn.microsoft.com/en-us/commandline/wsl/about)).

Run the following in the terminal or CMD (on Windows)

``` $ \curl -sSL https://get.rvm.io | bash -s stable ```

* Restart the terminal or cmd and run command below to check if rvm is installed.

  ```$ rvm list ```
### Installing ruby via RVM

``` $ rvm install <ruby version> ```

* e.g. Ruby Version 3.0.2

### Installing Rails via RVM

Since Rails is a gem, which is a standardized format that contains Ruby programs, you can also install various versions of Rails by using the ``` gem ``` command

``` $ gem install rails -v <rails specified version> ```

* e.g. Rails Version 7.0.3

NB: For more installation details, checkout [Installing RVM](https://rvm.io/rvm/install) documentation on the same.

## Installing rbenv

* rbenv is a version control tool for Ruby. It helps you switch between different Ruby versions and make sure that every project you are working on always operates independently on the designated version.

### Usage

You can choose the Ruby version for your project with, for example:
```sh
cd myproject
# choose Ruby version 3.0.2:
rbenv local 3.0.2
```

### Installation

On systems with Homebrew package manager, the “Using Package Managers” method is recommended. On other systems, “Git Checkout” might be the easiest way of ensuring that you are always installing the latest version of rbenv.

### Using Package Managers

1. Install rbenv using one of the following approaches.

   #### Homebrew

   On macOS or Linux, we recommend installing rbenv with [Homebrew](https://brew.sh).

   ```sh
   $ brew install rbenv ruby-build
   ```

   #### Debian, Ubuntu, and their derivatives

   >Note that the version of rbenv that is packaged and maintained in the Debian and Ubuntu repositories is _out of date_. To install the latest version, it is recommended to [install rbenv using git](#basic-git).

   ```sh
   $ sudo apt install rbenv
   ```

   #### Arch Linux and its derivatives

   Archlinux has an [AUR Package](https://aur.archlinux.org/packages/rbenv/) for
   rbenv and you can install it from the AUR using the instructions from this
   [wiki page](https://wiki.archlinux.org/index.php/Arch_User_Repository#Installing_and_upgrading_packages).

2. Load rbenv in your shell.

    ```sh
    # run this and follow the printed instructions:
    $ rbenv init
    ```

3. Restart your terminal so your changes take effect.

That's it! You are now ready to [install different ruby versions](#installing-ruby-versions).

### Basic Git

1. Clone rbenv into `~/.rbenv`.

    ```sh
    $ git clone https://github.com/rbenv/rbenv.git ~/.rbenv
    ```

2. Configure your shell to load rbenv:

    * For **bash**:

      _Ubuntu Desktop_ users should configure `~/.bashrc`:
      ```bash
      $ echo 'eval "$(~/.rbenv/bin/rbenv init - bash)"' >> ~/.bashrc
      ```

      On _other platforms_, bash is usually configured via `~/.bash_profile`:
      ```bash
      $ echo 'eval "$(~/.rbenv/bin/rbenv init - bash)"' >> ~/.bash_profile
      ```

    * For **Zsh**:
      ```zsh
      echo 'eval "$(~/.rbenv/bin/rbenv init - zsh)"' >> ~/.zshrc
      ```
3. Restart your shell so that these changes take effect.

### Installing ruby via rbenv

Before attempting to install Ruby, check that [your build environment](https://github.com/rbenv/ruby-build/wiki#suggested-build-environment) has the necessary tools and libraries. Then:

```sh
# list latest stable versions:
rbenv install -l
# list all local versions:
rbenv install -L
# install a Ruby version:
rbenv install 3.0.2
```
All done!

You are now free to proceed to the steps below:

### Step 2: Create a Fork & Branch

* Create a fork of this repository from main branch
* Select an issue to work on from the main repository
* Create a branch name to match the selected issue from the main branch

NB:
1. Always make sure your fork is in sync with the main
2. All changes you make for the issue will be on this branch

### Step 3: Clone & install dependencies

Run the following command in the terminal

``` $ git clone <link to you forked repo> ```

``` $ cd <path to your cloned repo> ```

``` $ bundle install ```

### Step 4: Setup the database

``` $ rails db:create ```

``` $ rails db:migrate ```

### Step 4: Install yarn dependancies

``` yarn install ```

### Step 5: Start server

```./bin/dev```

### step 6: Creating a pull request

* make changes locally on your branch
* push your changes to your branch on github
* create a pull request to main branch of the main repository

### step 7: Merging

Once your changes are reviewed they will be merged to the main branch

## Contributing

Thank you for your interest in contributing to the Africa Ruby Community (ARC) Platform! We welcome contributions from developers of all experience levels.

### Finding Issues to Work On

We label our issues to help contributors find ones that match their skills and experience level. Here are some labels you might find helpful:


| Difficulty Level | Description                              | Label    |
  |------------------|------------------------------------------|----------|
| Easy/ Beginner/ Novice | Issues that are ideal for first-time contributors | ![DifficultyLevelEasy](https://img.shields.io/badge/DifficultyLevelEasy-green.svg?style=for-the-badge)|
| Very Easy        | Simple issues that can be fixed quickly  | ![DifficultyLevelVeryEasy](https://img.shields.io/badge/DifficultyLevelVeryEasy-619B16?style=for-the-badge)|
| Average/ Normal/ Medium/ Standard/ Intermediate          | Issues that require some understanding of the codebase  | ![DifficultyLevelAverage](https://img.shields.io/badge/DifficultyLevelAverage-DAD22C?style=for-the-badge&color=fbca04) |
| Hard/ Expert/ Difficult             | Issues that require a significant amount of time and effort | ![DifficultyLevelHard](https://img.shields.io/badge/DifficultyLevelHard-E1803C?style=for-the-badge&color=d93f0b) |
| Harder           | Very challenging issues that require advanced knowledge | ![DifficultyLevelHarder](https://img.shields.io/badge/DifficultyLevelHarder-C70039?style=for-the-badge)|


To guide people in searching for issues using these labels, you can provide the following steps:

1. Go to the project's repository on GitHub.
2. Click on the `Issues` tab.
3. Use the search bar at the top to search for issues using one or more of the labels listed above.
4. You can refine your search by adding additional keywords or filters, such as language, platform, or component.
5. Once you find an issue you are interested in working on, read through the description and comments to get a better understanding of the problem and any suggested solutions.
6. If you have any questions or need help, leave a comment on the issue and wait for feedback from other contributors or maintainers.