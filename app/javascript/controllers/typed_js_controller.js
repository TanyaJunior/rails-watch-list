import { Controller } from "@hotwired/stimulus"
import Typed from "typed.js"

export default class extends Controller {
  connect() {
    new Typed(this.element, {
      strings: ["make a list ", "movies of all time"],
      typeSpeed: 50,
      loop: true
    })
  }
}
