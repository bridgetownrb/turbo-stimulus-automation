# frozen_string_literal: true

require "fileutils"

say_status :turbo, "Installing Turbo..."

add_npm_package "@hotwired/turbo turbo-shadow"

say_status :turbo, 'Adding Turbo to "frontend/javascript/index.js"...', :magenta

javascript_import do
  <<~JS
    import * as Turbo from "@hotwired/turbo"

    /**
     * Adds support for declarative shadow DOM. Requires your HTML <head> to include:
     * `<meta name="turbo-cache-control" content="no-cache" />`
     */
    import * as TurboShadow from "turbo-shadow"

    /**
     * Uncomment the line below to add transition animations when Turbo navigates.
     * Use data-turbo-transition="false" on your <main> element for pages where
     * you don't want any transition animation.
     */
    // import "./turbo_transitions.js"
  JS
end

copy_file "https://raw.githubusercontent.com/bridgetownrb/turbo-stimulus-automation/refs/heads/main/turbo_transitions.js",
          "frontend/javascript/turbo_transitions.js"

say_status :turbo, "Turbo successfully added!", :magenta
say_status :turbo, "For declarative shadow DOM support, you will need to update", :blue
say_status :turbo, "your HTML <head> to add the following code:", :blue
say %(<meta name="turbo-cache-control" content="no-cache" />)
say_status :turbo, "Check out your index.js file for optional animation setup.", :blue
say_status :turbo, 'For further reading, visit "https://turbo.hotwired.dev/"', :blue

####

say "Installing Stimulus...", :green

add_npm_package "@hotwired/stimulus"

say 'Adding Stimulus to "frontend/javascript/index.js"...', :magenta

javascript_import do
  <<~JS
    import { Application } from "@hotwired/stimulus"
  JS
end

javascript_dir = File.join("frontend", "javascript")

append_to_file(File.join(javascript_dir, "index.js")) do
  <<~JS

    window.Stimulus = Application.start()

    import controllers from "./controllers/**/*.{js,js.rb}"
    Object.entries(controllers).forEach(([filename, controller]) => {
      if (filename.includes("_controller.") || filename.includes("-controller.")) {
        const identifier = filename.replace("./controllers/", "")
          .replace(/[_-]controller\\..*$/, "")
          .replace(/_/g, "-")
          .replace(/\\//g, "--")

        Stimulus.register(identifier, controller.default)
      }
    })
  JS
end

controller_dir = File.join(javascript_dir, "controllers")

say "Creating a `./#{controller_dir}` directory...", :magenta
FileUtils.mkdir_p(controller_dir)

say "Creating an example Stimulus Controller for you!...", :magenta
create_file(File.join(controller_dir, "example_controller.js")) do
  <<~JS
    import { Controller } from "@hotwired/stimulus"
    export default class extends Controller {
      connect() {
        console.log("Hello, Stimulus!", this.element)
      }
    }
  JS
end

say "Stimulus successfully added", :green

say "To start adding controllers, visit the `./frontend/javascript/controllers/` directory", :blue
say "Make sure your controllers follow the `[name]_controller.js` convention", :blue
say 'For further reading, check out "https://stimulus.hotwired.dev/"', :blue
