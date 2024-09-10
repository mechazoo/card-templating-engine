# Card Templating Engine
Better Name Pending...

## Usage
To use this tool, you'll need to define a template, and then create a set of cards.

### Requirements
You'll need an installation of the `Ruby` programming language. You can download it [here](https://www.ruby-lang.org/en/)  
You'll also need a command line terminal that you're comfortable using for very basic tasks. 
* On Windows, I'd recommend using/learning Powershell. 
* For Mac users (I make no guarantees that this works at all on mac) your pre-installed terminal will do fine. 
* Linux Users, you know what you like. 

### Defining Templates
To define a template, simply create it using HTML (ERB) and CSS. With ERB syntax, you have access to the full power of the Ruby language for creating your templates. 
> N.B. if you're new to ERB, I'd recommend taking a look at the examples at [ERB on Github](https://github.com/ruby/erb)

Templates live in the templates directory. Inside, create the following structure:
```
templates
    <template_name>
        card_template.erb
        card_template.css
```
for example, to define a template named `mechazoo-playtest`:
```
templates
    mechazoo-playtest
        card_template.css
        card_template.erb
```

#### What you have access to
Inside the ERB context, you'll have access to all the values you define later in your `<cardname>.yaml` file. 

#### A note on names
When choosing variable names to use in your erb file, I'd highly recommend choosing one of the following naming schemes, and sticking to it zealously. Other naming schemes may work, but notably, `kebab-case` will cause errors.
* `snake_case`: Words are kept strictly lower-case, and spaces are replaced with underscores (`_`)
* `lowerPascalCase`: Words aren't separated, and the first letter of all but the first word is capitalized.

### Writing cards
Once you've created your template, create a folder under the `sets` directory, the structure of these directories is as follows:
```
sets
    <set_name>
        cards
            <card>.yaml
            <other_card>.yaml
            <another_card>.yaml
        set.yaml
```
> Note: the `set.yaml` file noted in this example is *mandatory*

Each of the card yaml files just needs to contain the information that you want to be held in the fields you created when making your template.

An example of a card yaml file looks like this:
```yaml
cardname: Example Card
energy: 0
cardtype: action
scrap_cost: 1
scrap_value: 3
typeline: Scrapper Energy Weapon
limit: 2
text: "This weapon deals 1 point of damage."
```
> The above example is for the `mechazoo-playtest` template.

