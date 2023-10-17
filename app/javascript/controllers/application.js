import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
import { Pagy } from 'pagy';
window.Pagy = Pagy;


//= require_tree .
//= require post