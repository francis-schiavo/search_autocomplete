# SearchAutocomplete
This gem was created to add simple autocomplete and search/filter functionality to Ruby on Rails apps with minimal effort.

Other alternatives available are outdated or aren't as simple, often requiring many external libraries such as jQuery.
This gem only requires modules already shipped with Rails and the only external library required is available as a npm package you can add in your webpack files.

## Installation

### Ruby
Add this line to your application's Gemfile:

```ruby
gem 'search_autocomplete'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install search_autocomplete
```

### Webpack

Add the compatible web component for npm:
```bash
yarn add @francisschiavo/search-autocomplete
```

and then require it anywhere in your scripts:

```js
require('@francisschiavo/search-autocomplete');
```

## Usage

### Autocomplete

After installing this gem you can configure its options with an initializer like this:

**config/initializers/search_autocomplete.rb**
```ruby
SearchAutocomplete.configure do |options|
  options.autocomplete_size = 5
end
```

You must mount the autocomplete engine like this:

**config/routes.rb**
```ruby
Rails.application.routes.draw do
  mount SearchAutocomplete::Engine, at: '/autocomplete'
end
```

To allow your model on the autocomplete search you must configure it like this:
```ruby
class Category < ApplicationRecord
  belongs_to :category, optional: true

  autocomplete :name
end
```
The example above will allow searches on the `name` field for the `Category` model.

To test this you can do a get request to: `{APP URL}/autocomplete/category?term=Cat 1`

Note `/autocomplete` is the base uri you specify on the routes and `/category` is the lowercase name of the model.

You can also search namespaced models by adding the lowercase name of every namespace as part of the URI:

If your model is `Admin::User` the search would be: `{APP URL}/autocomplete/admin/user?term=Roger`

### Search / Filter

You can use the method `search` on your controllers as a way to filter data.

This method takes 3 arguments:
* The model class to perform the search
* An array of fields to permit approximate matches (like)
* An array of fields to permit exact matches (=)

Here is a sample of the `index` action of a `category` controller:

```ruby
def index
  @categories = search(Category, %i[name], []).all
end
```

You can also use it with pagination gems like kaminari:

```ruby
def index
  @categories = search(Category, %i[name], []).page(params[:page])
end
```

### Postgres Jsonb support

There is a limited support for `jsonb` fields, currently limited to one level deep fields.

To query using a jsonb field you must pass an array as the name argument:

```ruby
class Category < ApplicationRecord
  belongs_to :category, optional: true

  autocomplete %i[name pt_BR]
end
```

This will use `arel` infix operators to create the following query:

```sql
SELECT * FROM categories WHERE category.name->>'pt_BR' ILIKE "%term%";
``` 

## Known issues

* Uses WebComponents requires modern browsers or polyfills
* There is no automated tests at this moment.
* There is no support for json fields other than `postgres`.
* Json fields are supported but limited to one level deep fields. 

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
