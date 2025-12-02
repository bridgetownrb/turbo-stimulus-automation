# turbo-stimulus-automation

An automation for installing [Hotwire](https://hotwired.dev) Turbo & Stimulus in a [Bridgetown](https://www.bridgetownrb.com) site.

In your Bridgetown project folder, run:

```
bin/bridgetown apply https://github.com/bridgetownrb/turbo-stimulus-automation
```

(Note: it will modify your `index.js` file in your repo.)

You can also apply the automation when creating a new site:

```
bridgetown new mysite --apply=https://github.com/bridgetownrb/turbo-stimulus-automation
```

The automation will add Turbo & Stimulus to your `package.json` and add the import statements to your frontend JS entrypoint.

Any questions? [Check out the Bridgetown community discussion channels for help.](https://www.bridgetownrb.com/community)

----

## Future Compatibility Message

The Turbo & Stimulus automation used to be configuration options bundled with Bridgetown, but it has since been extracted to this community-maintained repository. I ([@jaredcwhite](https://github.com/jaredcwhite)) do not use or endorse 37signals-backed repositories, but I'm happy to accept PRs to keep the automation working in case a future version of Turbo or Stimulus breaks the script in some way. Thanks!

