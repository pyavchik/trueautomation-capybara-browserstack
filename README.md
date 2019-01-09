# trueautomation-capybara-browserstack

You must have: <br>
installed TrueAutomation client <br>
account at www.browserstack.com

## How to run test: 

* Checkout project
 
 ```
 git clone https://github.com/pyavchik/trueautomation-capybara-browserstack.git
 ```
* Set up your username and accesskey key at spec_helper.rb:
```
username = 'your_username'
accesskey = 'your_accesskey'
```
* Init project use `trueautomation init` command
 
* Run test

```bash
bundle install
rspec spec/test_scenario/trueautomation_spec.rb
```