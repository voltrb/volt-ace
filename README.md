# Volt::Ace

A quick ace editor example

## Installation

Add this line to your application's Gemfile:

    gem 'volt-ace', path: 'path/to/local/copy/of/repo

Next, include this as a dependency in any components you want to use the editor in

    component 'ace'

Finally, use the ```<:ace:editor />``` tag like so:

```html
<:ace:editor value="{page._code}" mode="ace/mode/javascript" />
```
