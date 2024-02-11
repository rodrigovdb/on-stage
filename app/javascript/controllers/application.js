import { Application } from "@hotwired/stimulus"

import Sortable from 'stimulus-sortable'

const application = Application.start()
application.register('sortable', Sortable)

// Configure Stimulus development experience
application.debug = true
window.Stimulus   = application

export { application }
