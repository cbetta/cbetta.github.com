---

title: "PayPal Seamless Checkout with Rails"
date: 2013-09-25 12:00
comments: true
tags: paypal rails tutorial
published: false
---

Continuing from previous post.

# Enable Seamless Checkout

* Login to [developer.paypal.com](http://developer.paypal.com)
* Go to **Applications**
* Select your application from the list
* Scroll down to **Login With PayPal**
* Check **Use Seamless Checkout**
* Scroll back up and hit **Save**
* Also make sure **Accept Payments** is turned on (we turned that off in the last post).

# Update OmniAuth to use Seamless Checkout

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :paypal, ... scope: "openid email profile https://uri.paypal.com/services/expresscheckout"
end
```

# Make a payment

Add the PayPal SDK to your Gemfile

```ruby
gem 'paypal-sdk-rest'
```

Now make a new initializer in `config/initializers/paypal.rb` to configure PayPal.

```ruby
PayPal::SDK::REST.set_config(
    :mode => :sandbox,  # Set :sandbox or :live
    :client_id     => "CLIENT_ID",
    :client_secret => "CLIENT_SECRET" )
```

Create a PaymentsController to prepare and setup the payment.

```ruby

```


